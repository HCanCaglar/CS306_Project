<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$conn = new mysqli("localhost", "root", "", "hotel_management");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$results = [];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["test_vacant"])) {
        // Test case 1: Try to reserve a vacant room
        $roomId = 701;
                        
        try {
            $sql = "INSERT INTO Reserve (GuestID, RoomID, BookingDate, Duration, ResStatus) VALUES (13, $roomId, '2025-05-15',  3, 'Confirmed')";
            if ($conn->query($sql) === TRUE) {
                $results[] = (object)[
                    'body' => "Reservation successful for vacant room (Room ID: $roomId)",
                 
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
    } elseif (isset($_POST["test_occupied"])) {
        // Test case 2: Try to reserve an occupied room
        $roomId = 101;
        
        try {
            $sql = "INSERT INTO Reserve (GuestID, RoomID, ResStatus, Duration) VALUES (2, $roomId, 'Confirmed', 2)";
            if ($conn->query($sql) === TRUE) {
                $results[] = (object)[
                    'body' => "Reservation was made, but trigger should have prevented it!",
                  
                ];
            } else {
                $results[] = (object)[
                    'body' => "Trigger correctly prevented reservation of occupied room (Room ID: $roomId)",
                 
                ];
            }
          } catch (Exception $e) {
            if (isset($_POST["test_occupied"])) {
                $results[] = (object)[
                    'body' => "Trigger correctly prevented reservation of occupied room (Room ID: $roomId)",
                ];
            }
            
            else {
                $results[] = (object)[
                    'body' => "Trigger correctly prevented reservation: " . $e->getMessage(),
                ];
            }
        }
        
    } elseif (isset($_POST["test_pending"])) {
        // Test case 3: Try to reserve a room with pending reservation
        $roomId = 102;
        
        try {
            $sql = "INSERT INTO Reserve (GuestID, RoomID, ResStatus, Duration) VALUES (3, $roomId, 'Confirmed', 2)";
            if ($conn->query($sql) === TRUE) {
                $results[] = (object)[
                    'body' => "Reservation was made, but trigger should have prevented it since room has a pending reservation!",
                   
                ];
            } else {
                $results[] = (object)[
                    'body' => "Trigger correctly prevented reservation of room with pending status (Room ID: $roomId)",
                ];
            }
          } catch (Exception $e) {
            if (isset($_POST["test_pending"])) {
              $results[] = (object)[
                  'body' => "Trigger correctly prevented reservation of room with pending status (Room ID: $roomId)",
              ];
            } 
            
            else {
                $results[] = (object)[
                    'body' => "Trigger correctly prevented reservation: " . $e->getMessage(),
                ];
            }
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
    <title>Room Vacancy Check Trigger</title>
</head>
<body>
    <h1>Room Vacancy Check Trigger</h1>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Description:</h2>
        <p>This trigger prevents reservations from being made for rooms that are already occupied or have an active reservation.</p>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Test the Trigger:</h2>
        <form method="post">
            <button type="submit" name="test_vacant">Test with Vacant Room</button>
            <button type="submit" name="test_occupied">Test with Occupied Room</button>
            <button type="submit" name="test_pending">Test with Pending Room</button>
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
