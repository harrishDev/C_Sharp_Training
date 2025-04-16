CREATE DATABASE TicketBookingSystem;
GO
USE TicketBookingSystem

select * from Booking
select * from Customer
select * from Event
select * from Venue

CREATE TABLE Venue (
    venue_id INT PRIMARY KEY IDENTITY(1,1),
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);


CREATE TABLE Event (
    event_id INT PRIMARY KEY IDENTITY(1,1),
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL,
    event_type VARCHAR(20) CHECK (event_type IN ('Movie', 'Sports', 'Concert')),
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    event_id INT NOT NULL,
    num_tickets INT NOT NULL,
    total_cost DECIMAL(10,2),
    booking_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

INSERT INTO Venue (venue_name, address) VALUES 
('Royal Arena', '123 King Street, London'),
('Grand Theater', '45 Queen Street, New York'),
('Stadium One', '101 First Avenue, LA'),
('City Concert Hall', '88 Downtown Blvd, Chicago'),
('Open Air Grounds', '999 Hillside, San Francisco'),
('Sunset Arena', '450 Beach Road, Miami'),
('Opera House', '678 Liberty St, Toronto'),
('Metro Convention Center', '321 Central Ave, Houston'),
('Greenfield Park', '111 Greenfield Rd, Austin'),
('Eastside Pavilion', '57 Riverside Dr, Seattle');

INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type) VALUES
('Champions Cup Final', '2025-06-01', '18:00', 3, 50000, 30000, 1500, 'Sports'),
('Summer Music Festival', '2025-07-15', '19:00', 5, 20000, 5000, 2500, 'Concert'),
('Avengers Reloaded', '2025-05-10', '20:30', 1, 300, 120, 800, 'Movie'),
('Symphony Night', '2025-04-20', '18:00', 4, 600, 250, 1000, 'Concert'),
('Broadway Drama', '2025-08-10', '19:30', 2, 400, 100, 1200, 'Movie'),
('Rock & Roll Revival', '2025-09-05', '21:00', 6, 2500, 2200, 1800, 'Concert'),
('World Cup Qualifier', '2025-10-11', '17:00', 3, 50000, 48000, 2000, 'Sports'),
('RomCom Marathon', '2025-06-22', '16:00', 1, 300, 180, 700, 'Movie'),
('Jazz Evening', '2025-11-25', '18:30', 4, 500, 480, 1300, 'Concert'),
('Legendary Showdown', '2025-12-10', '20:00', 10, 15000, 15000, 2200, 'Sports');

INSERT INTO Customer (customer_name, email, phone_number) VALUES
('Alice Smith', 'alice@gmail.com', '123450000'),
('Bob Johnson', 'bob@gmail.com', '123451111'),
('Charlie Lee', 'charlie@gmail.com', '123452222'),
('Diana Prince', 'diana@gmail.com', '123453333'),
('Ethan Hunt', 'ethan@gmail.com', '123454444'),
('Fiona Glenanne', 'fiona@gmail.com', '123455555'),
('George Banks', 'george@gmail.com', '123456666'),
('Hannah Wells', 'hannah@gmail.com', '123457777'),
('Isaac Newton', 'isaac@gmail.com', '123458888'),
('Jane Foster', 'jane@gmail.com', '123459999');

INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost) VALUES
(1, 1, 5, 7500),
(2, 2, 2, 5000),
(3, 3, 3, 2400),
(4, 4, 1, 1000),
(5, 5, 4, 4800),
(6, 6, 2, 3600),
(7, 7, 6, 12000),
(8, 8, 1, 700),
(9, 9, 2, 2600),
(10, 10, 5, 11000)
;

-- TASK2
SELECT * FROM Event;

SELECT * FROM Event 
WHERE available_seats > 0;

SELECT * FROM Event 
WHERE event_name LIKE '%cup%';

SELECT * FROM Event 
WHERE ticket_price BETWEEN 1000 AND 2500;

SELECT * FROM Event 
WHERE event_date 
BETWEEN '2025-06-01' AND '2025-12-31';

SELECT * FROM Event 
WHERE available_seats > 0 AND event_type = 'Concert' AND 
event_name LIKE '%Concert%';

SELECT * FROM Customer
ORDER BY customer_id
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

SELECT * FROM Booking 
WHERE num_tickets > 4;

SELECT * FROM Customer 
WHERE phone_number LIKE '%000';

SELECT * FROM Event 
WHERE total_seats > 15000 
ORDER BY total_seats DESC;

SELECT * FROM Event 
WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%';

-- TASK3
SELECT event_type, AVG(ticket_price) AS avg_price
FROM Event
GROUP BY event_type;

SELECT event_id, SUM(total_cost) AS total_revenue
FROM Booking
GROUP BY event_id;

SELECT TOP 1 event_id, SUM(num_tickets) AS tickets_sold
FROM Booking
GROUP BY event_id
ORDER BY tickets_sold DESC;

SELECT event_id, SUM(num_tickets) AS tickets_sold
FROM Booking
GROUP BY event_id;

SELECT e.event_id, e.event_name
FROM Event e
LEFT JOIN Booking b ON e.event_id = b.event_id
WHERE b.event_id IS NULL;

SELECT TOP 1 customer_id, SUM(num_tickets) AS total_tickets
FROM Booking
GROUP BY customer_id
ORDER BY total_tickets DESC;

SELECT FORMAT(booking_date, 'yyyy-MM') AS booking_month, SUM(num_tickets) AS total_tickets
FROM Booking
GROUP BY FORMAT(booking_date, 'yyyy-MM');

SELECT v.venue_name, AVG(e.ticket_price) AS avg_price
FROM Event e
JOIN Venue v ON e.venue_id = v.venue_id
GROUP BY v.venue_name;

SELECT event_type, SUM(b.num_tickets) AS tickets_sold
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY event_type;

SELECT YEAR(event_date) AS year, SUM(b.total_cost) AS revenue
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY YEAR(event_date);

SELECT customer_id
FROM Booking
GROUP BY customer_id
HAVING COUNT(DISTINCT event_id) > 1;

SELECT customer_id, SUM(total_cost) AS user_revenue
FROM Booking
GROUP BY customer_id;

SELECT e.event_type, v.venue_name, AVG(e.ticket_price) AS avg_price
FROM Event e
JOIN Venue v ON e.venue_id = v.venue_id
GROUP BY e.event_type, v.venue_name;

SELECT customer_id, SUM(num_tickets) AS total_tickets
FROM Booking
WHERE booking_date >= DATEADD(DAY, -30, GETDATE())
GROUP BY customer_id;

-- TASK 4
SELECT venue_id, 
       (SELECT AVG(ticket_price) FROM Event e2 WHERE e2.venue_id = e1.venue_id) AS avg_price
FROM Event e1
GROUP BY venue_id;

SELECT * FROM Event
WHERE (total_seats - available_seats) > (0.5 * total_seats);

SELECT event_id, SUM(num_tickets) AS total_tickets
FROM Booking
GROUP BY event_id;

SELECT * FROM Customer c
WHERE NOT EXISTS (
    SELECT 1 FROM Booking b WHERE b.customer_id = c.customer_id
);

SELECT * FROM Event 
WHERE event_id NOT IN (
    SELECT DISTINCT event_id FROM Booking
);

SELECT event_type, SUM(total_tickets) AS total
FROM (
    SELECT e.event_type, b.num_tickets AS total_tickets
    FROM Booking b
    JOIN Event e ON b.event_id = e.event_id
) AS temp
GROUP BY event_type;

SELECT * FROM Event
WHERE ticket_price > (SELECT AVG(ticket_price) FROM Event);

SELECT c.customer_id, c.customer_name,
       (SELECT SUM(b.total_cost) FROM Booking b WHERE b.customer_id = c.customer_id) AS total_revenue
FROM Customer c;

SELECT DISTINCT c.customer_id, c.customer_name
FROM Customer c
WHERE customer_id IN (
    SELECT b.customer_id FROM Booking b
    JOIN Event e ON b.event_id = e.event_id
    WHERE e.venue_id = 3 -- example venue
);

SELECT event_type, SUM(num_tickets) AS total_sold
FROM (
    SELECT e.event_type, b.num_tickets
    FROM Booking b
    JOIN Event e ON b.event_id = e.event_id
) AS sub
GROUP BY event_type;

SELECT DISTINCT customer_id
FROM Booking
WHERE FORMAT(booking_date, 'yyyy-MM') IS NOT NULL;

SELECT venue_id,
       (SELECT AVG(ticket_price) FROM Event e2 WHERE e2.venue_id = e1.venue_id) AS avg_price
FROM Event e1
GROUP BY venue_id;




