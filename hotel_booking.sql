-- HOTEL BOOKING SYSTEM - SQL PROJECT (ARTTIFAI TECH)

-- STEP 1: Create Tables

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    RoomType VARCHAR(50),
    PricePerNight DECIMAL(10, 2),
    Availability VARCHAR(10) -- Values: 'Available', 'Booked'
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    RoomID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalAmount DECIMAL(10, 2),
    PaymentStatus VARCHAR(20), -- Values: 'Paid', 'Pending'
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    BookingID INT,
    AmountPaid DECIMAL(10, 2),
    PaymentMethod VARCHAR(50), -- e.g., 'Credit Card', 'UPI', 'Cash'
    PaymentDate DATE,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- STEP 2: Insert Sample Data

INSERT INTO Rooms VALUES
(101, 'Deluxe', 5000, 'Available'),
(102, 'Standard', 3000, 'Booked'),
(103, 'Suite', 8000, 'Available');

INSERT INTO Customers VALUES
(1, 'Raj Malhotra', '9876543210', 'raj@gmail.com'),
(2, 'Ananya Sharma', '7894561230', 'ananya@yahoo.com');

INSERT INTO Bookings VALUES
(1001, 1, 102, '2025-04-01', '2025-04-05', 12000, 'Paid'),
(1002, 2, 103, '2025-04-10', '2025-04-15', 40000, 'Pending');

INSERT INTO Payments VALUES
(5001, 1001, 12000, 'Credit Card', '2025-03-30'),
(5002, 1002, 20000, 'UPI', '2025-04-08');

-- STEP 3: Sample Report Queries

-- 1. View all bookings
SELECT * FROM Bookings;

-- 2. Show bookings with customer names and room types
SELECT B.BookingID, C.Name, R.RoomType, B.CheckInDate, B.CheckOutDate, B.TotalAmount
FROM Bookings B
JOIN Customers C ON B.CustomerID = C.CustomerID
JOIN Rooms R ON B.RoomID = R.RoomID;

-- 3. Show payments with customer name and status
SELECT P.PaymentID, C.Name, B.TotalAmount, P.AmountPaid, P.PaymentMethod
FROM Payments P
JOIN Bookings B ON P.BookingID = B.BookingID
JOIN Customers C ON B.CustomerID = C.CustomerID;

-- 4. Show available rooms only
SELECT * FROM Rooms WHERE Availability = 'Available';

-- 5. Total earnings by room type
SELECT R.RoomType, SUM(B.TotalAmount) AS TotalRevenue
FROM Bookings B
JOIN Rooms R ON B.RoomID = R.RoomID
GROUP BY R.RoomType;
