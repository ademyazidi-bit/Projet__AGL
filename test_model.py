import json
import sys
sys.path.append('.')
from predict_workout import predict_workout

# Test prediction
result = predict_workout(
    goal="Muscle Gain",
    difficulty="Intermediate",
    age=25,
    weight=75,
    height=175,
    gender="male",
    activity="moderate"
)

print(json.dumps(result, indent=2))