import os
import json
import numpy as np
import pandas as pd
import joblib

from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.ensemble import GradientBoostingClassifier

print("Loading dataset...")

# -----------------------------
# LOAD DATASET
# -----------------------------
df = pd.read_csv("ml/workout_dataset.csv")

print(f"Dataset loaded: {len(df)} rows")
print(f"Exercises: {df['exercise'].nunique()}")

# -----------------------------
# CREATE OUTPUT FOLDER
# -----------------------------
os.makedirs("ml/models", exist_ok=True)

# -----------------------------
# ENCODERS
# -----------------------------
goal_enc = LabelEncoder()
diff_enc = LabelEncoder()

df["goal_n"] = goal_enc.fit_transform(df["goal"])
df["diff_n"] = diff_enc.fit_transform(df["difficulty"])

joblib.dump(goal_enc, "ml/models/goal_encoder.pkl")
joblib.dump(diff_enc, "ml/models/diff_encoder.pkl")

# -----------------------------
# FEATURE SCALING (IMPORTANT)
# -----------------------------
scaler = StandardScaler()

# ensure numeric columns exist
required_cols = ["age", "weight_kg", "height_cm", "bmi"]

for col in required_cols:
    if col not in df.columns:
        df[col] = 0  # fallback safety

num_features = scaler.fit_transform(df[required_cols])
joblib.dump(scaler, "ml/models/scaler.pkl")

# final feature set
X = np.hstack([
    df[["goal_n", "diff_n"]].values,
    num_features
])

categories = df["category"].unique()

print(f"Training models for categories: {list(categories)}")

# -----------------------------
# TRAIN PER CATEGORY MODEL
# -----------------------------
for cat in categories:

    cat_df = df[df["category"] == cat]

    if len(cat_df) < 10:
        continue

    # encode target
    ex_enc = LabelEncoder()
    y = ex_enc.fit_transform(cat_df["exercise"])

    joblib.dump(ex_enc, f"ml/models/ex_encoder_{cat.replace(' ','_')}.pkl")

    # matching features
    X_cat = X[df["category"] == cat]

    X_train, X_test, y_train, y_test = train_test_split(
        X_cat, y, test_size=0.2, random_state=42
    )

    # -------------------------
    # MODEL (STABLE VERSION)
    # -------------------------
    model = GradientBoostingClassifier(
        n_estimators=120,
        learning_rate=0.05,
        max_depth=3,
        random_state=42
    )

    model.fit(X_train, y_train)

    acc = model.score(X_test, y_test)

    filename = f"ml/models/{cat.lower().replace(' ','_')}_model.pkl"
    joblib.dump(model, filename)

    print(f"{cat:12} accuracy={acc:.3f} | saved -> {filename}")

# -----------------------------
# SAVE META INFO
# -----------------------------
meta = {
    "features": ["goal", "difficulty", "age", "weight_kg", "height_cm", "bmi"],
    "categories": list(categories),
    "model": "GradientBoostingClassifier"
}

with open("ml/models/meta.json", "w") as f:
    json.dump(meta, f, indent=2)

print("\nDONE: All models trained successfully.")