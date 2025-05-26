<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Management System - User</title>
</head>
<body>
    <h1>Hotel Management System</h1>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Triggers</h2>
        <div style="border: 1px solid blue; padding: 10px; margin: 5px;">
            <h3>Room Vacancy Check</h3>
            <p>This trigger ensures a room cannot be reserved if it's already occupied or has an active reservation.</p>
            <p><strong>By:</strong> Hıdır Can Çağlar</p>
            <a href="trigger_room_vacancy.php">Test Room Vacancy Trigger</a>
        </div>
        <div style="border: 1px solid blue; padding: 10px; margin: 5px;">
            <h3>Guest Age Check</h3>
            <p>This trigger ensures that guests must be at least 18 years old to make a reservation.</p>
            <a href="trigger_guest_age.php">Test Guest Age Check Trigger</a>
        </div>
        <div style="border: 1px solid blue; padding: 10px; margin: 5px;">
            <h3>Parking Payment Check</h3>
            <p>This trigger ensures that guests pay for parking before their check-out from the hotel.</p>
            <p><strong>By:</strong> Mehmet Berkay Çatak</p>
            <a href="trigger_parking_payment.php">Test Parking Payment Trigger</a>
        </div>
        <!-- Add more triggers as needed -->
    </div>
    
    <div style="border: 1px solid black; padding: 10px; margin: 10px;">
        <h2>Stored Procedures</h2>
        <div style="border: 1px solid blue; padding: 10px; margin: 5px;">
            <h3>Calculate Guest Bill</h3>
            <p>This procedure calculates the total bill for a guest, including room charges, parking fees, and any applicable loyalty discounts.</p>
            <p><strong>By:</strong> Hıdır Can Çağlar</p>
            <a href="procedure_guest_bill.php">Use Guest Bill Calculator</a>
        </div>
        <div style="border: 1px solid blue; padding: 10px; margin: 5px;">
            <h3>Get Guest Tours</h3>
            <p>This procedure retrieves all tours that a specific guest has attended, based on their name and surname.</p>
            <a href="procedure_guest_tours.php">View Guest Tours</a>
        </div>
        <!-- Add more stored procedures as needed -->
        <div style="border: 1px solid blue; padding: 10px; margin: 5px;">
            <h3>Apply Royalty Check</h3>
            <p>This procedure checks a guest's eligibility to royalty program and includes them to the program if they are.</p>
            <p><strong>By:</strong> Mehmet Berkay Çatak</p>
            <a href="procedure_royalty_giver.php">Apply Royalty Check</a>
        </div>
    </div>
    
     <div style="margin: 20px 10px;">
        <a href="tickets.php">Support Page</a>
    </div>
</body>
</html>
