<?php
$current = basename($_SERVER['PHP_SELF']);
?>
<nav>
    <div class="nav-inner">
        <a href="workout_generator.php" class="nav-logo">
            <img src="FullLogo_Transparent_NoBuffer.png" alt="FitPlanner">
        </a>
        <div class="nav-links">
            <a href="workout_generator.php" class="<?php echo $current === 'workout_generator.php' ? 'active' : ''; ?>">Generate</a>
            <a href="saved_workouts.php" class="<?php echo $current === 'saved_workouts.php' ? 'active' : ''; ?>">Saved</a>
            <a href="logout.php" class="nav-logout">Logout</a>
        </div>
    </div>
</nav>
<style>
    nav {
        background: #16213e;
        border-bottom: 1px solid #0f3460;
        padding: 12px 24px;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 999;
    }
    .nav-inner {
        max-width: 900px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .nav-logo img { height: 35px; }
    .nav-links {
        display: flex;
        gap: 20px;
        align-items: center;
    }
    .nav-links a {
        color: #aaa;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        transition: color 0.2s;
    }
    .nav-links a:hover { color: #5b9bd5; }
    .nav-links a.active { color: #5b9bd5; }
    .nav-logout {
        background: #0f3460;
        padding: 7px 16px;
        border-radius: 8px;
        color: #aaa !important;
        transition: background 0.2s !important;
    }
    .nav-logout:hover {
        background: #e74c3c !important;
        color: white !important;
    }
</style>