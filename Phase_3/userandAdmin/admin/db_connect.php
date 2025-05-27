<?php
// Updated db_connect.php for Docker environment

// MySQL Connection (for triggers and stored procedures)
$mysql_host = 'mysql';  // Docker service name
$mysql_dbname = 'cs306_project';
$mysql_username = 'cs306_user';
$mysql_password = 'cs306_pass';

try {
    $pdo = new PDO("mysql:host=$mysql_host;dbname=$mysql_dbname", $mysql_username, $mysql_password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("MySQL Connection Error: " . $e->getMessage());
}

// MongoDB Connection (for support tickets)
try {
    // Use Docker service name for MongoDB
    $mongoManager = new MongoDB\Driver\Manager("mongodb://mongodb:27017");
    
    // Test the connection
    $command = new MongoDB\Driver\Command(['ping' => 1]);
    $mongoManager->executeCommand('admin', $command);
    
    // Database and collection names
    $database = 'cs306_tickets';
    $collection = 'support_tickets';
    $namespace = $database . '.' . $collection;
    
} catch (Exception $e) {
    die("MongoDB Connection Error: " . $e->getMessage());
}

// Helper functions
function generateObjectId() {
    return new MongoDB\BSON\ObjectId();
}

function getCurrentTimestamp() {
    return date('Y-m-d H:i:s');
}
?>