USE CMS

select * from Users
select * from Courier
select * from CourierServices
select * from Employee
select * from Location
select * from Payment

create table Users(
UserID INT PRIMARY KEY,  
Name VARCHAR(255),  
Email VARCHAR(255) UNIQUE,
Password VARCHAR(255),  
ContactNumber VARCHAR(20),  
Address TEXT 
)

create table Courier(
CourierID INT PRIMARY KEY,  
SenderName VARCHAR(255),  
SenderAddress TEXT,  
ReceiverName VARCHAR(255),  
ReceiverAddress TEXT,  
Weight DECIMAL(5, 2),  
Status VARCHAR(50),  
TrackingNumber VARCHAR(20) UNIQUE,  
DeliveryDate DATE
)

create table CourierServices(
ServiceID INT PRIMARY KEY,  
ServiceName VARCHAR(100),  
Cost DECIMAL(8, 2)
)

create table Employee(
EmployeeID INT PRIMARY KEY,  
Name VARCHAR(255),  
Email VARCHAR(255) UNIQUE,  
ContactNumber VARCHAR(20),  
Role VARCHAR(50),  
Salary DECIMAL(10, 2)
)

create table Location(
LocationID INT PRIMARY KEY,  
LocationName VARCHAR(100),  
Address TEXT
)

create table Payment(
PaymentID INT PRIMARY KEY,  
CourierID INT,  
LocationId INT,  
Amount DECIMAL(10, 2),  
PaymentDate DATE,  
FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),  
FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
)

--task2
--1.  List all customers
select * from Users

--2.  List all orders for a specific customer
select * from Courier
where SenderName='rohan'

--3.  List all couriers:  
select * from Courier

--4.List all packages for a specific order:
SELECT * FROM Courier
WHERE CourierID = 6

--5. List all deliveries for a specific courier
select * from Courier
where CourierID=3
and Status='delivered'

--6. List all undelivered packages: 
select * from Courier
where Status != 'delivered'

--7. List all packages that are scheduled for delivery today:  
update Courier
set DeliveryDate='2025-03-24'
where CourierID=6

select * from Courier
where DeliveryDate = CAST(getdate() as date) 

--8.List all packages with a specific status:  
select * from Courier
where Status='in transit'

--9.Calculate the total number of packages for each courier.  
SELECT CourierID, COUNT(*) AS TotalPackages
FROM Courier
GROUP BY CourierID;

--10.Find the average delivery time for each courier


--11. List all packages with a specific weight range:  
SELECT * FROM Courier
WHERE Weight BETWEEN 4 AND 6

--12. Retrieve employees whose names contain 'John'  
select * from Employee
where Name like '%John%'

--13. Retrieve all courier records with payments greater than $50.
select c.* from Courier c
join Payment p on c.CourierID=p.CourierID
where Amount>50

select * from Users
select * from Courier
select * from CourierServices
select * from Employee
select * from Location
select * from Payment