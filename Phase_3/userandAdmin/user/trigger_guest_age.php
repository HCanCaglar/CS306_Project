<?php
$conn = new mysqli("mysql", "root", "root", "cs306_project");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$results = [];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["test_adult"])) {
        // Test case 1: Try to reserve with an adult guest (age >= 18)
        $guestId = 12;
        $roomId = 601;
                        
        try {
            $sql = "INSERT INTO Reserve (GuestID, RoomID, BookingDate, Duration, ResStatus) VALUES ($guestId, $roomId, '2025-05-15', 3, 'Confirmed')";
            if ($conn->query($sql) === TRUE) {
                $results[] = (object)[
                    'body' => "Reservation successful for adult guest (Guest ID: $guestId)",
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
    
    if (isset($_POST["test_minor"])) {
        // Test case 2: Try to reserve with a minor guest (age < 18)
        $guestId = 11;
        $roomId = 602;
        
        try {
            $sql = "INSERT INTO Reserve (GuestID, RoomID, BookingDate, Duration, ResStatus) VALUES ($guestId, $roomId, '2025-05-15', 2, 'Confirmed')";
            if ($conn->query($sql) === TRUE) {
                $results[] = (object)[
                    'body' => "Reservation was made, but trigger should have prevented it!",
                ];
            } else {
                $results[] = (object)[
                    'body' => "Trigger correctly prevented reservation for minor guest (Guest ID: $guestId)",
                ];
            }
        } catch (Exception $e) {
            $results[] = (object)[
                'body' => "Trigger correctly prevented reservation: " . $e->getMessage(),
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
    <title>Guest Age Check Trigger</title>
</head>
<body>
    <h1>Guest Age Check Trigger</h1>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Description:</h2>
        <p>This trigger prevents reservations from being made by guests who are under 18 years old.</p>
        <strong>By: Ahmet Nusret Avcı</strong>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Test the Trigger:</h2>
        <form method="post">
            <button type="submit" name="test_adult">Test with Adult Guest</button>
            <button type="submit" name="test_minor">Test with Minor Guest</button>
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