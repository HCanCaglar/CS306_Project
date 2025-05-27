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
require 'vendor/autoload.php';

try {
    $client = new MongoDB\Client("mongodb://mongodb:27017");
    $db = $client->selectDatabase('cs306_tickets');
    $ticketCollection = $db->selectCollection('tickets');
} catch (Exception $e) {
    die('MongoDB Connection Error: ' . $e->getMessage());
}

// Helper functions
function generateObjectId() {
    return new MongoDB\BSON\ObjectId();
}

function getCurrentTimestamp() {
    return date('Y-m-d H:i:s');
}
?>