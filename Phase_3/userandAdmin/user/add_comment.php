<?php
require_once 'db_connect.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: tickets.php');
    exit;
}

$ticketId = $_POST['ticket_id'];
$username = $_POST['username'];
$comment = $_POST['comment'];

if (empty($ticketId) || empty($username) || empty($comment)) {
    echo "All fields are required!";
    exit;
}

try {
    $newComment = [
        'username' => $username,
        'message' => $comment,
        'timestamp' => date('Y-m-d H:i:s')
    ];
    
    $result = $ticketCollection->updateOne(
        ['_id' => new MongoDB\BSON\ObjectId($ticketId)],
        ['$push' => ['comments' => $newComment]]
    );
    
    if ($result->getModifiedCount() > 0) {
        header('Location: view_ticket.php?id=' . $ticketId);
    } else {
        echo "Failed to add comment!";
    }
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
