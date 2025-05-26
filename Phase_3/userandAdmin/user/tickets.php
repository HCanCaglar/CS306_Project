<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require_once 'db_connect.php';

$usernames = $ticketCollection->distinct('username', ['status' => true]);

$selectedUser = isset($_GET['username']) ? $_GET['username'] : null;
$results = null;

if ($selectedUser) {
    $results = $ticketCollection->find(['username' => $selectedUser, 'status' => true]);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Tickets</title>
</head>
<body>
    <h1>Support Tickets</h1>
    <div style="margin-bottom: 20px;">
        <a href="index.php">Back to Homepage</a>
    </div>

    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Select User</h2>
        <form method="GET">
            <select name="username">
                <option value="">Select a username</option>
                <?php foreach ($usernames as $username): ?>
                    <option value="<?php echo $username; ?>" <?php echo ($selectedUser == $username) ? 'selected' : ''; ?>>
                        <?php echo $username; ?>
                    </option>
                <?php endforeach; ?>
            </select>
            <button type="submit">View Tickets</button>
        </form>
    </div>

    <?php if ($selectedUser): ?>
        <div style="margin: 20px 0;">
            <a href="create_ticket.php?username=<?php echo $selectedUser; ?>">Create New Ticket</a>
        </div>

        <div style="border: 1px solid black; padding: 10px; margin: 10px;">
            <h2>Your Tickets</h2>
            <?php
            $resultsArray = $results ? iterator_to_array($results) : [];
            if (!empty($resultsArray)) {
                foreach ($resultsArray as $ticket) {
                    echo "<div style='border: 1px solid blue; padding: 10px; margin: 5px;'>";
                    echo "<strong>Created At: </strong>{$ticket->created_at}<br>";
                    echo "<strong>Message: </strong>" . $ticket->message . "<br>";
                    echo "<a href='view_ticket.php?id={$ticket->_id}'>View Details</a>";
                    echo "</div>";
                }
            } else {
                echo "No active tickets found for this user.";
            }
            ?>
        </div>
    <?php elseif (count($usernames) == 0): ?>
        <div style="border: 1px solid black; padding: 10px; margin: 10px;">
            <h2>No Active Tickets</h2>
            <p>There are no active tickets in the system.</p>
            <a href="create_ticket.php">Create New Ticket</a>
        </div>
    <?php endif; ?>
</body>
</html>
