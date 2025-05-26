<?php
require_once 'db_connect.php';

if (!isset($_GET['id'])) {
    header('Location: tickets.php');
    exit;
}

$ticketId = $_GET['id'];

try {
    $ticket = $ticketCollection->findOne(['_id' => new MongoDB\BSON\ObjectId($ticketId)]);
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
    exit;
}

if (!$ticket) {
    echo "Ticket not found!";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Details</title>
</head>
<body>
    <h1>Ticket Details</h1>
    
    
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Ticket Information</h2>
        <p><strong>Username:</strong> <?php echo htmlspecialchars($ticket->username); ?></p>
        <p><strong>Created At:</strong> <?php echo htmlspecialchars($ticket->created_at); ?></p>
        <p><strong>Status:</strong> <?php echo $ticket->status ? 'Active' : 'Resolved'; ?></p>
        <p><strong>Message:</strong></p>
        <div style="border: 1px solid #ddd; padding: 10px; margin: 10px 0; background-color: #f9f9f9;">
            <?php echo nl2br(htmlspecialchars($ticket->message)); ?>
        </div>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Comments</h2>
        <?php if (empty($ticket->comments)): ?>
            <p>No comments yet.</p>
        <?php else: ?>
            <?php foreach ($ticket->comments as $comment): ?>
                <div style="border: 1px solid #ddd; padding: 10px; margin: 5px 0;">
                    <p><strong><?php echo htmlspecialchars($comment->username); ?>:</strong></p>
                    <p><?php echo nl2br(htmlspecialchars($comment->message)); ?></p>
                    <p><small>Posted on: <?php echo htmlspecialchars($comment->timestamp); ?></small></p>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
    
    <?php if ($ticket->status): ?>
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Add Comment</h2>
        <form action="add_comment.php" method="POST">
            <input type="hidden" name="ticket_id" value="<?php echo $ticket->_id; ?>">
            <input type="hidden" name="username" value="<?php echo htmlspecialchars($ticket->username); ?>">
            
            <div style="margin-bottom: 10px;">
                <label for="comment">Your Comment:</label><br>
                <textarea id="comment" name="comment" rows="4" required style="width: 300px;"></textarea>
            </div>
            
            <button type="submit">Add Comment</button>
        </form>
    </div>
    <div style="margin-bottom: 20px;">
        <a href="tickets.php?username=<?php echo urlencode($ticket->username); ?>">Back to Ticket List</a>
    </div>
    <?php endif; ?>
</body>
</html>
