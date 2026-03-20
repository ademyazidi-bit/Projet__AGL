<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.html");
    exit();
}
$fullname = $_SESSION['fullname'] ?? 'Athlete';
$firstname = explode(' ', $fullname)[0];

$motivational = [
    "Consistency beats motivation.",
    "Let's make today count.",
    "One rep closer to your goal.",
    "Your only competition is yesterday's you.",
    "Progress, not perfection.",
    "Show up. Every. Single. Day.",
    "The pain you feel today will be the strength you feel tomorrow.",
];
$quote = $motivational[array_rand($motivational)];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fit Planner - Generate Workout</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #1a1a2e;
            min-height: 100vh;
        }
        .page-wrapper {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 20px 20px 20px;
        }
        .container {
    width: 100%;
    max-width: 480px;
    margin-top: 40px;
}
        .welcome-box {
            text-align: center;
            margin-bottom: 30px;
        }
        .welcome-box .greeting {
            font-size: 14px;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 6px;
        }
        .welcome-box h1 {
            font-size: 32px;
            color: #eee;
            font-weight: 700;
            margin-bottom: 12px;
        }
        .welcome-box h1 span { color: #5b9bd5; }
        .quote-box {
            background: #0f3460;
            border-left: 3px solid #5b9bd5;
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 30px;
        }
        .quote-box p {
            color: #aaa;
            font-size: 14px;
            font-style: italic;
        }
        .card {
            background: #16213e;
            border: 1px solid #0f3460;
            border-radius: 16px;
            padding: 30px;
        }
        .card h2 {
            font-size: 18px;
            color: #5b9bd5;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group { margin-bottom: 18px; }
        .form-group label {
            display: block;
            color: #aaa;
            margin-bottom: 7px;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .form-group select {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #0f3460;
            background: #0f3460;
            color: white;
            font-size: 14px;
            cursor: pointer;
            appearance: none;
        }
        .form-group select:focus {
            outline: none;
            border-color: #5b9bd5;
        }
        .btn-generate {
            width: 100%;
            padding: 14px;
            background: #5b9bd5;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 5px;
        }
        .btn-generate:hover { background: #4a8ac4; }
        .saved-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #5b9bd5;
            font-size: 14px;
            text-decoration: none;
            padding: 12px;
            border: 1px solid #0f3460;
            border-radius: 10px;
            transition: all 0.2s;
        }
        .saved-link:hover {
            border-color: #5b9bd5;
            background: #0f3460;
        }
    </style>
</head>
<body>
<?php include 'navbar.php'; ?>
<div class="page-wrapper">
    <div class="container">

        <div class="welcome-box">
            <div class="greeting">Welcome back</div>
            <h1>Hey, <span><?php echo htmlspecialchars($firstname); ?></span> 👋</h1>
        </div>

        <div class="quote-box">
            <p>"<?php echo $quote; ?>"</p>
        </div>

        <div class="card">
            <h2>Generate Your Workout</h2>

            <form action="generate_workout.php" method="POST">
                <div class="form-group">
                    <label>Your Goal</label>
                    <select name="goal">
                        <option value="Weight Loss">Weight Loss</option>
                        <option value="Muscle Gain">Muscle Gain</option>
                        <option value="Maintain Weight">Maintain Weight</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Your Level</label>
                    <select name="difficulty">
                        <option value="Beginner">Beginner</option>
                        <option value="Intermediate">Intermediate</option>
                        <option value="Advanced">Advanced</option>
                    </select>
                </div>

                <button type="submit" class="btn-generate">Generate Workout →</button>
            </form>

            <a href="saved_workouts.php" class="saved-link">View My Saved Workouts →</a>
        </div>

    </div>
</div>
</body>
</html>