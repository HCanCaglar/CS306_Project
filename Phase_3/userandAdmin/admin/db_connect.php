<?php
// MongoDB connection setup
require_once __DIR__ . '/vendor/autoload.php';

try {
    $client = new MongoDB\Client("mongodb://localhost:27017");
    $ticketCollection = $client->hotel_management->tickets;
} catch (Exception $e) {
    die("Error connecting to MongoDB: " . $e->getMessage());
}
?>
