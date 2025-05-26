<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require_once 'db_connect.php';

// Get all active tickets
$results = $ticketCollection->find(['status' => true]);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Support Tickets</title>
</head>
<body>
    <h1>Admin Support Dashboard</h1>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Active Tickets</h2>
        <?php
        $ticketCount = 0;
        foreach ($results as $ticket) {
            $ticketCount++;
            echo "<div style='border: 1px solid blue; padding: 10px; margin: 5px;'>";
            echo "<strong>Username: </strong>{$ticket->username}<br>";
            echo "<strong>Created At: </strong>{$ticket->created_at}<br>";
            echo "<strong>Message: </strong>" . $ticket->message ."<br>";
            echo "<a href='view_ticket.php?id={$ticket->_id}'>View Details</a>";
            echo "</div>";
        }
        
        if ($ticketCount === 0) {
            echo "<p>No active tickets found.</p>";
        }
        ?>
    </div>
</body>
</html>
