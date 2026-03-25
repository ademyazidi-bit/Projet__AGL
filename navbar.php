<?php
// navbar.php
// Vérifier si la session n'est pas déjà active
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$fullname = $_SESSION['fullname'] ?? 'Athlete';
$firstname = explode(' ', $fullname)[0];
?>

<!DOCTYPE html>
<html>
<head>
    <style>
        .navbar {
            background: #16213e;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #0f3460;
            margin-bottom: 20px;
        }
        .navbar .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .navbar .logo img {
            height: 40px;
        }
        .navbar .logo span {
            color: #5b9bd5;
            font-weight: bold;
            font-size: 18px;
        }
        .navbar .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .navbar .nav-links a {
            color: #eee;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s;
        }
        .navbar .nav-links a:hover {
            background: #0f3460;
            color: #5b9bd5;
        }
        .navbar .nav-links a.active {
            background: #5b9bd5;
            color: white;
        }
        .navbar .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .navbar .user-info span {
            color: #5b9bd5;
        }
        .navbar .user-info a {
            background: #e74c3c;
            padding: 6px 12px;
            border-radius: 6px;
            color: white;
            text-decoration: none;
            font-size: 14px;
        }
        .navbar .user-info a:hover {
            background: #c0392b;
        }
        .stats-badge {
            background: #0f3460;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            color: #5b9bd5;
            margin-left: 10px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <div class="logo">
        <img src="FullLogo_Transparent_NoBuffer.png" alt="FitPlanner">
        <span>FitPlanner</span>
    </div>
    <div class="nav-links">
        <a href="workout_generator.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'workout_generator.php' ? 'active' : ''; ?>">
            🏋️ Workout
        </a>
        <a href="saved_workouts.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'saved_workouts.php' ? 'active' : ''; ?>">
            📋 Mes workouts
        </a>
        <a href="diet_plan_generator.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'diet_plan_generator.php' ? 'active' : ''; ?>">
            🍽️ Nutrition
        </a>
        <a href="saved_meals.php" class="<?php echo basename($_SERVER['PHP_SELF']) == 'saved_meals.php' ? 'active' : ''; ?>">
            📝 Mes repas
        </a>
    </div>
    <div class="user-info">
        <span>👋 <?php echo htmlspecialchars($firstname); ?></span>
        <a href="logout.php">Déconnexion</a>
    </div>
</div>

<?php
// Appel AJAX pour récupérer les stats nutritionnelles
if (basename($_SERVER['PHP_SELF']) != 'diet_plan_generator.php' && basename($_SERVER['PHP_SELF']) != 'saved_meals.php') {
?>
<script>
fetch('get_nutrition_stats.php')
    .then(response => response.json())
    .then(data => {
        if (data.has_profile) {
            const statsBadge = document.createElement('span');
            statsBadge.className = 'stats-badge';
            statsBadge.innerHTML = `🎯 ${data.daily_goal} kcal`;
            document.querySelector('.user-info').appendChild(statsBadge);
        }
    })
    .catch(err => console.log('Stats non disponibles'));
</script>
<?php } ?>
</body>
</html>