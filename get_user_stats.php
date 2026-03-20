<?php
session_start();

$conn = mysqli_connect("localhost", "root", "", "fitplanner");

$user_id = $_SESSION['user_id'] ?? null;

if (!$user_id) {
    echo json_encode(['fullname' => 'Athlete', 'total' => 0, 'saved' => 0]);
    exit();
}

// get fullname
$stmt = mysqli_prepare($conn, "SELECT fullname FROM users WHERE id = ?");
mysqli_stmt_bind_param($stmt, 'i', $user_id);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
$user = mysqli_fetch_assoc($result);

// get workout counts
$stmt2 = mysqli_prepare($conn, "SELECT COUNT(*) as total FROM workouts WHERE user_id = ?");
mysqli_stmt_bind_param($stmt2, 'i', $user_id);
mysqli_stmt_execute($stmt2);
$r2 = mysqli_stmt_get_result($stmt2);
$total = mysqli_fetch_assoc($r2)['total'];

// get saved count
$stmt3 = mysqli_prepare($conn, "SELECT COUNT(*) as saved FROM workouts WHERE user_id = ? AND saved = 1");
mysqli_stmt_bind_param($stmt3, 'i', $user_id);
mysqli_stmt_execute($stmt3);
$r3 = mysqli_stmt_get_result($stmt3);
$saved = mysqli_fetch_assoc($r3)['saved'];

mysqli_close($conn);

echo json_encode([
    'fullname' => $user['fullname'],
    'total'    => $total,
    'saved'    => $saved,
]);
?>