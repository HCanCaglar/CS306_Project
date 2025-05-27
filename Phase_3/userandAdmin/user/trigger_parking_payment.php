<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$conn = new mysqli("mysql", "root", "root", "cs306_project");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$results = [];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["test_paid"])) {
        // Test case 1: Parking payment is paid before checkout.
        $roomId = 402;
        $guestId = 10;
        try {
            $sql = "UPDATE Rooms SET Vacancy = TRUE WHERE RoomId = $roomId";
            if ($conn->query($sql) === TRUE) {
                $results[] = (object)[
                    'body' => "Parking is paid prior to checkout, have a nice day(Guest ID: $guestId)",
                ];
            } else {
                $results[] = (object)[
                    'body' => "Error: " . $conn->error,
                ];
            }
        } catch (Exception $e) {
            $results[] = (object)[
                'body' => "Error: " . $e->getMessage(),
            ];
        }
    }
    if (isset($_POST["test_unpaid"])) {
        // Test case 2: Try to reserve with a minor guest (age < 18)
        $roomId = 501;
        
        try {
            $sql = "UPDATE Rooms SET Vacancy = TRUE WHERE RoomId = $roomId";
            if ($conn->query($sql) === TRUE) {
                $results[] = (object)[
                    'body' => "Guest checked out without paying for parking, what gives?",
                ];
            } else {
                $results[] = (object)[
                    'body' => "Trigger correctly prevented checkout for careless customer who forgot to pay for parking. (Guest ID: $guestId)",
                ];
            }
        } catch (Exception $e) {
            $results[] = (object)[
                'body' => "Warning! " . $e->getMessage(),
            ];
        }
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parking Payment Check Trigger</title>
</head>
<body>
    <h1>Parking Payment Check Trigger</h1>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Description:</h2>
        <p>This trigger prevents check-out of a guest from the hotel(vacating a room) prior to paying for parking.</p>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Test the Trigger:</h2>
        <form method="post">
            <button type="submit" name="test_paid">Test with Paid Parking</button>
            <button type="submit" name="test_unpaid">Test with Unpaid Parking</button>
        </form>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Results:</h2>
        <?php
        if (isset($results) && !empty($results)) {
            foreach ($results as $document) {
                echo "<div style='border: 1px solid blue; padding: 10px; margin: 5px;'>";
                echo "{$document->body}<br>";
                echo "</div>";
            }
        } else {
            echo "No results yet. Please test the trigger using the buttons above.";
        }
        ?>
    </div>
    
    <div style="margin: 10px;">
        <a href="index.php">Back to Homepage</a>
    </div>
</body>
</html> 
