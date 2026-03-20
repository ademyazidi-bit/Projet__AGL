<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.html");
    exit();
}
$conn = mysqli_connect("localhost", "root", "", "fitplanner");

$user_id = $_SESSION['user_id'] ?? 6;
$goal = $_POST['goal'];
$difficulty = $_POST['difficulty'];

// map goal to categories
if ($goal == "Weight Loss") {
    $categories = ['Cardio', 'Core', 'Full Body'];
} elseif ($goal == "Muscle Gain") {
    $categories = ['Chest', 'Back', 'Legs', 'Shoulders', 'Arms'];
} else { // Maintain Weight
    $categories = ['Cardio', 'Core', 'Chest', 'Legs'];
}

$exercises = [];

// fetch 1 exercise per category matching the selected difficulty
foreach ($categories as $category) {
    $stmt = mysqli_prepare($conn, "
        SELECT e.id, e.name, e.difficulty, e.description, e.equipment, c.name AS category
        FROM exercises e
        JOIN categories c ON e.category_id = c.id
        WHERE c.name = ? AND e.difficulty = ?
        ORDER BY RAND()
        LIMIT 1
    ");
    mysqli_stmt_bind_param($stmt, 'ss', $category, $difficulty);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $row = mysqli_fetch_assoc($result);
    if ($row) {
        $exercises[] = $row;
    }
}

// save workout to database
if (!empty($exercises)) {
    $stmt2 = mysqli_prepare($conn, "INSERT INTO workouts (user_id, goal) VALUES (?, ?)");
    mysqli_stmt_bind_param($stmt2, 'is', $user_id, $goal);
    mysqli_stmt_execute($stmt2);
    $workout_id = mysqli_insert_id($conn);
    $_SESSION['workout_id'] = $workout_id;

    foreach ($exercises as $exercise) {
        $stmt3 = mysqli_prepare($conn, "INSERT INTO workout_exercises (workout_id, exercise_id) VALUES (?, ?)");
        mysqli_stmt_bind_param($stmt3, 'ii', $workout_id, $exercise['id']);
        mysqli_stmt_execute($stmt3);
    }
}

mysqli_close($conn);

$_SESSION['workout_goal'] = $goal;
$_SESSION['workout_difficulty'] = $difficulty;
$_SESSION['workout_exercises'] = $exercises;

header("Location: workout_plan.php");
exit();
?>