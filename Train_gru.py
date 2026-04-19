"""
ml/train_gru.py — FitPlanner GRU Workout Recommender
=====================================================
Run: python ml/train_gru.py
Requires: pip install tensorflow scikit-learn pandas numpy joblib

The model takes [goal, difficulty, age, weight, height] as input
and predicts the best exercises per muscle category.
One model is trained per category (multi-output classification).
Models are saved to ml/models/
"""

import os, json
import numpy as np
import pandas as pd
import joblib
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.model_selection import train_test_split

os.makedirs('ml/models', exist_ok=True)

# ── Load dataset ────────────────────────────────────────────
df = pd.read_csv('ml/workout_dataset.csv')
print(f"Dataset: {len(df)} rows, {df['exercise'].nunique()} exercises")

# ── Encoders ────────────────────────────────────────────────
goal_enc = LabelEncoder().fit(df['goal'])
diff_enc  = LabelEncoder().fit(df['difficulty'])
joblib.dump(goal_enc, 'ml/models/goal_encoder.pkl')
joblib.dump(diff_enc,  'ml/models/diff_encoder.pkl')

# ── Feature matrix ──────────────────────────────────────────
df['goal_n'] = goal_enc.transform(df['goal'])
df['diff_n'] = diff_enc.transform(df['difficulty'])

scaler = StandardScaler()
num_features = scaler.fit_transform(df[['age','weight_kg','height_cm','bmi']])
joblib.dump(scaler, 'ml/models/scaler.pkl')

X_cat  = df[['goal_n','diff_n']].values
X_num  = num_features
X      = np.hstack([X_cat, X_num])  # shape (N, 6)

categories = df['category'].unique()
print(f"Training one GRU model per category: {list(categories)}")

# ── Train one model per muscle category ─────────────────────
try:
    import tensorflow as tf
    from tensorflow.keras.models import Sequential
    from tensorflow.keras.layers import GRU, Dense, Dropout, Reshape
    from tensorflow.keras.callbacks import EarlyStopping
    USE_GRU = True
    print("TensorFlow found — training real GRU models")
except ImportError:
    from sklearn.ensemble import GradientBoostingClassifier
    USE_GRU = False
    print("TensorFlow not found — falling back to GradientBoosting (same interface)")

for cat in categories:
    cat_df = df[df['category'] == cat]
    if len(cat_df) < 10:
        continue

    ex_enc = LabelEncoder().fit(cat_df['exercise'])
    joblib.dump(ex_enc, f'ml/models/ex_encoder_{cat.replace(" ","_")}.pkl')

    X_cat_data = X[df['category'] == cat]
    y          = ex_enc.transform(cat_df['exercise'])

    X_tr, X_te, y_tr, y_te = train_test_split(X_cat_data, y, test_size=.2, random_state=42)

    if USE_GRU:
        model = Sequential([
            Reshape((1, 6), input_shape=(6,)),
            GRU(64, return_sequences=True),
            Dropout(0.2),
            GRU(32),
            Dropout(0.2),
            Dense(32, activation='relu'),
            Dense(len(ex_enc.classes_), activation='softmax'),
        ])
        model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
        model.fit(
            X_tr, y_tr,
            epochs=60,
            batch_size=32,
            validation_data=(X_te, y_te),
            callbacks=[EarlyStopping(patience=8, restore_best_weights=True)],
            verbose=0,
        )
        acc = model.evaluate(X_te, y_te, verbose=0)[1]
        model.save(f'ml/models/gru_{cat.replace(" ","_")}.h5')
        print(f"  {cat:<12} acc={acc:.3f}  classes={list(ex_enc.classes_)}")
    else:
        model = GradientBoostingClassifier(n_estimators=100, max_depth=4, random_state=42)
        model.fit(X_tr, y_tr)
        acc = model.score(X_te, y_te)
        joblib.dump(model, f'ml/models/gru_{cat.replace(" ","_")}.pkl')
        print(f"  {cat:<12} acc={acc:.3f}  classes={list(ex_enc.classes_)}")

# ── Save metadata ───────────────────────────────────────────
meta = {
    'model_type': 'gru' if USE_GRU else 'gbm',
    'features': ['goal_enc','diff_enc','age','weight_kg','height_cm','bmi'],
    'categories': list(categories),
    'goal_classes': list(goal_enc.classes_),
    'diff_classes':  list(diff_enc.classes_),
}
with open('ml/models/meta.json','w') as f:
    json.dump(meta, f, indent=2)

print("\nDone. All models saved to ml/models/")