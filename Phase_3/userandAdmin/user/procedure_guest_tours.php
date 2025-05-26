<?php
$conn = new mysqli("localhost", "root", "", "hotel_management");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$results = null;
$error = null;

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["guest_name"]) && isset($_POST["guest_surname"])) {
    $guestName = $_POST["guest_name"];
    $guestSurname = $_POST["guest_surname"];
    
    // Call the stored procedure
    try {
        $stmt = $conn->prepare("CALL GetGuestTours(?, ?)");
        $stmt->bind_param("ss", $guestName, $guestSurname);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result && $result->num_rows > 0) {
            $results = $result->fetch_all(MYSQLI_ASSOC);
        }
        
        $stmt->close();
    } catch (Exception $e) {
        $error = "Error: " . $e->getMessage();
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get Guest Tours</title>
</head>
<body>
    <h1>Get Guest Tours</h1>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Description:</h2>
        <p>This stored procedure retrieves all tours that a specific guest has attended, based on their name and surname.</p>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Enter Guest Information:</h2>
        <form method="post">
            <div style="margin-bottom: 10px;">
                <label for="guest_name">Guest Name:</label><br>
                <input type="text" id="guest_name" name="guest_name" required>
            </div>
            <div style="margin-bottom: 10px;">
                <label for="guest_surname">Guest Surname:</label><br>
                <input type="text" id="guest_surname" name="guest_surname" required>
            </div>
            <button type="submit">Get Tours</button>
        </form>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Results:</h2>
        <?php
        if (isset($error)) {
            echo "<div style='color: red;'>$error</div>";
        } else if (isset($results)) {
            if (count($results) > 0) {
                echo "<table style='width: 100%; border-collapse: collapse;'>";
                echo "<tr style='background-color: #f2f2f2;'>";
                foreach (array_keys($results[0]) as $header) {
                    echo "<th style='border: 1px solid #ddd; padding: 8px; text-align: left;'>$header</th>";
                }
                echo "</tr>";
                
                foreach ($results as $row) {
                    echo "<tr>";
                    foreach ($row as $value) {
                        echo "<td style='border: 1px solid #ddd; padding: 8px;'>$value</td>";
                    }
                    echo "</tr>";
                }
                echo "</table>";
            } else {
                echo "No tours found for this guest.";
            }
        } else {
            echo "Please enter guest information to view their tours.";
        }
        ?>
    </div>
    
    <div style="margin: 10px;">
        <a href="index.php">Back to Homepage</a>
    </div>
</body>
</html> 