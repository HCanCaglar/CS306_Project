<?php

require_once 'db_connect.php';

$username = isset($_GET['username']) ? $_GET['username'] : '';
$message = '';
$success = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $message = $_POST['message'];
    
    if (!empty($username) && !empty($message)) {
        $result = $ticketCollection->insertOne([
            'username' => $username,
            'message' => $message,
            'created_at' => date('Y-m-d H:i:s'),
            'status' => true,
            'comments' => []
        ]);
        
        if ($result->getInsertedCount() > 0) {
            $success = true;
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Support Ticket</title>
</head>
<body>
    <h1>Create Support Ticket</h1>
    
    <div style="margin-bottom: 20px;">
        <a href="index.php">Back to Homepage</a> | 
        <a href="tickets.php">Back to Ticket List</a>
    </div>
    
    <?php if ($success): ?>
        <div style="border: 1px solid green; padding: 10px; margin: 10px; background-color: #e8f5e9;">
            <h2>Ticket Created Successfully!</h2>
            <p>Your support ticket has been submitted.</p>
            <a href="tickets.php?username=<?php echo urlencode($username); ?>">View Your Tickets</a> | 
            <a href="create_ticket.php">Create Another Ticket</a>
        </div>
    <?php else: ?>
        <div style="border: 1px solid black; padding: 10px; margin: 10px;">
            <h2>Submit a New Ticket</h2>
            <form method="POST">
                <div style="margin-bottom: 10px;">
                    <label for="username">Username:</label><br>
                    <input type="text" id="username" name="username" value="<?php echo htmlspecialchars($username); ?>" required style="width: 300px;">
                </div>
                
                <div style="margin-bottom: 10px;">
                    <label for="message">Message:</label><br>
                    <textarea id="message" name="message" rows="5" required style="width: 300px;"><?php echo htmlspecialchars($message); ?></textarea>
                </div>
                
                <button type="submit">Submit Ticket</button>
            </form>
        </div>
    <?php endif; ?>
</body>
</html>
