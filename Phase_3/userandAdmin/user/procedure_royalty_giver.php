<?php
$conn = new mysqli("localhost", "root", "", "hotel_management");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$results = null;
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["guest_id"]))
{
    $guestId = $_POST["guest_id"];

    // Call the stored procedure
    try {
        $stmt = $conn->prepare("CALL RoyaltyGiver(?)");
        $stmt->bind_param("i", $guestId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result && $result->num_rows > 0) {
            $results = $result->fetch_assoc();
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
    <title>Apply Royalty Check</title>
</head>
<body>
    <h1>Apply Royalty</h1>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Description:</h2>
        <p>This stored procedure checks the eligibility of a guest to be a part of the loyalty program and accepts them to the program if they're eligible.</p>
        <strong>By: Mehmet Berkay Çatak</strong>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Enter Guest ID:</h2>
        <form method="post">
            <input type="text" name="guest_id" required>
            <button type="submit">Apply Royalty Check</button>
        </form>
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
    <h2>Results:</h2>
    <?php
    if (isset($results) && $results) {
        echo "<table style='width: 100%; border-collapse: collapse;'>";
        echo "<tr style='background-color: #f2f2f2;'>";
        echo "<th style='border: 1px solid #ddd; padding: 8px; text-align: left;'>Field</th>";
        echo "<th style='border: 1px solid #ddd; padding: 8px; text-align: left;'>Value</th>";
        echo "</tr>";
        
        foreach ($results as $key => $value) {
            echo "<tr>";
            echo "<td style='border: 1px solid #ddd; padding: 8px;'><strong>ApplicationResult</strong></td>";
            echo "<td style='border: 1px solid #ddd; padding: 8px;'>{$value}</td>";
            echo "</tr>";
        }
        
        echo "</table>";
    } else if (isset($error)) {
        echo "<div style='border: 1px solid red; padding: 10px; margin: 5px;'>";
        echo $error;
        echo "</div>";
    } else {
        echo "No results yet. Please enter a Guest ID.";
    }
    ?>
</div>

    
    <div style="margin: 10px;">
        <a href="index.php">Back to Homepage</a>
    </div>
</body>
</html>