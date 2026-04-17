<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$fullname = $_SESSION['fullname'] ?? 'Athlete';
$firstname = explode(' ', $fullname)[0];

$conn_nav = mysqli_connect("localhost","root","","fitplanner");
$me_nav = mysqli_fetch_assoc(mysqli_query($conn_nav,"SELECT role FROM users WHERE id=".(int)($_SESSION['user_id']??0)));
$is_admin = $me_nav && $me_nav['role'] === 'admin';
mysqli_close($conn_nav);
?>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Segoe UI',sans-serif;background:#1a1a2e;color:#eee;min-height:100vh}
.navbar{background:#16213e;padding:15px 30px;display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #0f3460;margin-bottom:20px}
.navbar .logo{display:flex;align-items:center;gap:10px}
.navbar .logo img{height:40px}
.navbar .logo span{color:#5b9bd5;font-weight:bold;font-size:18px}
.navbar .nav-links{display:flex;gap:20px;align-items:center}
.navbar .nav-links a{color:#eee;text-decoration:none;padding:8px 16px;border-radius:8px;transition:all 0.3s}
.navbar .nav-links a:hover{background:#0f3460;color:#5b9bd5}
.navbar .nav-links a.active{background:#5b9bd5;color:white}
.navbar .user-info{display:flex;align-items:center;gap:15px}
.navbar .user-info span{color:#5b9bd5}
.navbar .user-info a{background:#e74c3c;padding:6px 12px;border-radius:6px;color:white;text-decoration:none;font-size:14px}
.navbar .user-info a:hover{background:#c0392b}
.stats-badge{background:#0f3460;padding:4px 10px;border-radius:20px;font-size:12px;color:#5b9bd5;margin-left:10px}
</style>

<div class="navbar">
    <div class="logo">
        <img src="FullLogo_Transparent_NoBuffer.png" alt="FitPlanner">
        <span>FitPlanner</span>
    </div>
    <div class="nav-links">
        <a href="workout_generator.php" class="<?= basename($_SERVER['PHP_SELF'])=='workout_generator.php'?'active':'' ?>">🏋️ Workout</a>
        <a href="saved_workouts.php" class="<?= basename($_SERVER['PHP_SELF'])=='saved_workouts.php'?'active':'' ?>">📋 Mes workouts</a>
        <a href="diet_plan_generator.php" class="<?= basename($_SERVER['PHP_SELF'])=='diet_plan_generator.php'?'active':'' ?>">🍽️ Nutrition</a>
        <a href="saved_meals.php" class="<?= basename($_SERVER['PHP_SELF'])=='saved_meals.php'?'active':'' ?>">📝 Mes repas</a>
        <a href="workout_history.php" class="<?= basename($_SERVER['PHP_SELF'])=='workout_history.php'?'active':'' ?>">📅 Workout History</a>
        <a href="diet_history.php" class="<?= basename($_SERVER['PHP_SELF'])=='diet_history.php'?'active':'' ?>">🥗 Diet History</a>
        <a href="profile.php" class="<?= basename($_SERVER['PHP_SELF'])=='profile.php'?'active':'' ?>">👤 Profile</a>
        <?php if ($is_admin): ?>
        <a href="admin_dashboard.php" class="<?= strpos(basename($_SERVER['PHP_SELF']),'admin')===0?'active':'' ?>" style="background:#9b59b6;color:#fff">🛠️ Admin</a>
        <?php endif; ?>
    </div>
    <div class="user-info">
        <span>👋 <?= htmlspecialchars($firstname) ?></span>
        <a href="logout.php">Déconnexion</a>
    </div>
</div>

<?php if (!in_array(basename($_SERVER['PHP_SELF']), ['diet_plan_generator.php','saved_meals.php','diet_history.php'])): ?>
<script>
fetch('get_nutrition_stats.php')
    .then(r=>r.json())
    .then(data=>{
        if(data.has_profile){
            const b=document.createElement('span');
            b.className='stats-badge';
            b.innerHTML=`🎯 ${data.daily_goal} kcal`;
            document.querySelector('.user-info').appendChild(b);
        }
    }).catch(()=>{});
</script>
<?php endif; ?>