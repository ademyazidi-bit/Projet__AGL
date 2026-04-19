import sys
import json
import os
import numpy as np
import joblib

MODELS_DIR = os.path.join(os.path.dirname(__file__), "models")

def find_model(cat):
    filename = f"{cat.lower().replace(' ', '_')}_model.pkl"
    path = os.path.join(MODELS_DIR, filename)
    return path if os.path.exists(path) else None


try:
    # -----------------------------
    # INPUT
    # -----------------------------
    goal = sys.argv[1]
    age = float(sys.argv[2])
    weight = float(sys.argv[3])
    difficulty = sys.argv[4]

    # -----------------------------
    # LOAD ENCODERS + SCALER
    # -----------------------------
    goal_enc = joblib.load(os.path.join(MODELS_DIR, "goal_encoder.pkl"))
    diff_enc = joblib.load(os.path.join(MODELS_DIR, "diff_encoder.pkl"))
    scaler = joblib.load(os.path.join(MODELS_DIR, "scaler.pkl"))

    goal_n = goal_enc.transform([goal])[0]
    diff_n = diff_enc.transform([difficulty])[0]

    # fallback height/bmi (if not passed)
    height = 175
    bmi = weight / ((height / 100) ** 2)

    import pandas as pd

input_df = pd.DataFrame([{
    "goal_n": goal_n,
    "diff_n": diff_n,
    "age": age,
    "weight_kg": weight,
    "height_cm": height,
    "bmi": bmi
}])

num = scaler.transform(input_df[["age","weight_kg","height_cm","bmi"]])[0]

X = np.array([[goal_n, diff_n, num[0], num[1], num[2], num[3]]])

    X = np.array([[goal_n, diff_n, num[0], num[1], num[2], num[3]]])

    # -----------------------------
    # CATEGORY MAP
    # -----------------------------
    GOAL_CATS = {
        "Weight Loss": ["Cardio", "Core", "Full Body"],
        "Muscle Gain": ["Chest", "Back", "Legs", "Shoulders", "Arms"],
        "Maintain Weight": ["Cardio", "Core", "Chest", "Legs"]
    }

    categories = GOAL_CATS.get(goal, ["Cardio", "Core", "Full Body"])

    results = []

    # -----------------------------
    # PREDICTION
    # -----------------------------
    for cat in categories:

        model_path = find_model(cat)
        if not model_path:
            continue

        model = joblib.load(model_path)

        probs = model.predict_proba(X)[0]

        ex_encoder_path = os.path.join(MODELS_DIR, f"ex_encoder_{cat.replace(' ','_')}.pkl")
        if not os.path.exists(ex_encoder_path):
            continue

        ex_enc = joblib.load(ex_encoder_path)

        top2 = np.argsort(probs)[::-1][:2]
        exercises = [ex_enc.classes_[i] for i in top2]

        results.append({
            "category": cat,
            "exercises": exercises
        })

    print(json.dumps(results))

except Exception as e:
    print(json.dumps({"error": str(e)}))