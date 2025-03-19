create database SISDB

use sisdb

create table Students(
student_id int identity primary key,
first_name varchar(255),
last_name varchar(255),
date_of_birth date,
email varchar(255),
phone_number bigint
)

create table Teacher(
teacher_id int identity primary key,
first_name varchar(255),
last_name varchar(255),
email varchar(255)
)

create table Courses(
course_id int identity primary key,
course_name varchar(255),
credits int,
teacher_id int ,
foreign key (teacher_id) references Teacher(teacher_id) on delete cascade
)

create table Enrollments(
enrollment_id int identity primary key,
student_id int,
course_id int,
enrollment_date date,
foreign key (student_id) references Students(student_id) on delete cascade,
foreign key (course_id) references Courses(course_id) on delete cascade
)

create table Payments(
payment_id int identity primary key,
student_id int,
amount decimal(15,2),
payment_date date,
foreign key (student_id) references Students(student_id) on delete cascade
)

select * from Students
select * from Courses
select * from Enrollments
select * from Teacher
select * from Payments

INSERT INTO Students(first_name, last_name, date_of_birth, email, phone_number) VALUES
('harrish','m','2003-11-14','harrish@gmail.com','987654321'),
('vishal','raj','2004-12-08','vishal@gmail.com','8545987456'),
('rohan','bk','2003-11-23','rohan@gmail.com','7893215015'),
('kishore','kumar','2004-01-14','kishore@gmail.com','8620126488'),
('laavesh','parthiban','2003-02-18','laavesh@gmail.com','8855669870'),
('arun','kumar','2003-04-19','arun@gmail.com','8899784590'),
('aswin','as','2002-02-10','aswin@gmail.com','8098742361'),
('aravind','raj','2003-01-01','aravind@gmail.com','7598362584'),
('ajay','raj','2003-09-09','ajay@gmail.com','9944789654'),
('herina','a','2003-08-25','herina@gmail.com','9988765842')

INSERT INTO Teacher(first_name, last_name, email) VALUES
('kriuthika', 'k', 'kiruthika@gmail.com'),
('seetha', 's', 'seetha@gmail.com'),
('anuradha', 'r', 'anuradha@gmail.com'),
('swaminathan', 's', 'swaminathan@gmail.com'),
('vanitha', 'sree', 'vanitha@gmail.com'),
('jaya', 'balan', 'jaya@gmail.com'),
('rahini', 'sudha', 'rahini@gmail.com'),
('walter', 'white', 'walter@gmail.com'),
('krishna', 'k', 'krishna@gmail.com'),
('dinakaran', 'g', 'dina@gmail.com')

INSERT INTO Courses (course_name, credits, teacher_id) VALUES
('sql', 3, 7),
('java', 4, 2),
('python', 3, 1),
('csharp', 5, 2),
('.net', 3, 5),
('cloud computing', 2, 4),
('ai', 5, 1),
('project', 5, 3),
('SE', 2, 5),
('data structures', 5, 1)

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-02-12'),
(3, 3, '2024-03-15'),
(4, 4, '2024-04-18'),
(5, 5, '2024-05-01'),
(6, 6, '2024-06-23'),
(7, 7, '2024-07-15'),
(8, 8, '2024-08-30'),
(9, 9, '2024-09-21'),
(10, 10, '2024-10-20')

INSERT INTO Payments (student_id, amount, payment_date) VALUES
(1, 500, '2024-02-01'),
(2, 600, '2024-02-03'),
(3, 700, '2024-02-05'),
(4, 800, '2024-02-07'),
(5, 900, '2024-02-09'),
(6, 1000, '2024-02-10'),
(7, 1100, '2024-02-11'),
(8, 1200, '2024-02-12'),
(9, 1300, '2024-02-13'),
(10, 1400, '2024-02-14')


select * from Students
select * from Courses
select * from Students
select * from Enrollments
select * from Teacher
select * from Payments
--task2

-- 1. Write an SQL query to insert a new student into the "Students" table with the following details:
insert into Students (first_name,last_name,date_of_birth,email,phone_number) values (
'john','doe','1995-08-15','john.doe@example.com',1234567890)

--2. Write an SQL query to enroll a student in a course. Choose an existing student and course 
-- and insert a record into the "Enrollments" table with the enrollment date.
insert into Enrollments (student_id, course_id, enrollment_date) 
values (3, 2, '2025-03-19')

-- 3. Update the email address of a specific teacher in the "Teacher" table. 
--Choose any teacher and modify their email address.
update Teacher
set email='anuradhahod@gmail.com'
where teacher_id=3

--4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. 
-- Select an enrollment record based on the student and course
delete from Enrollments
where student_id=10

--5. Update the "Courses" table to assign a specific teacher to a course. 
-- Choose any course and teacher from the respective tables.
update Courses
set teacher_id=6
where course_id=7 and course_name='ai'

--6. Delete a specific student from the "Students" table and remove all their 
-- enrollment records from the "Enrollments" table. Be sure to maintain referential integrity
delete from Students
where student_id=7

-- Update the payment amount for a specific payment record in the "Payments" table. 
-- Choose any payment record and modify the payment amount
update Payments
set amount=2599
where payment_id=10

--TASK3
-- 1. Write an SQL query to calculate the total payments made by a specific student. 
-- You will need to join the "Payments" table with the "Students" table based on the student's ID.
select s.first_name, sum(p.amount) as totalPayment
from Students s
join Payments p on s.student_id=p.student_id
group by s.first_name

--2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each 
-- course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.
select c.course_name, count(e.student_id) TotalStudentsEnrolled
from Courses c
join Enrollments e on c.course_id=e.course_id
group by c.course_name

-- 3. Write an SQL query to find the names of students who have not enrolled in any course. Use a 
-- LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.
select s.first_name, COUNT(e.student_id) as students_count
from Students s
left join Enrollments e on s.student_id=e.student_id
group by s.first_name
having COUNT(e.student_id)=0

-- 4. Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are 
-- enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.
select s.first_name, s.last_name, c.course_name
from Students s
join Enrollments e on s.student_id=e.student_id
join Courses c on e.course_id=c.course_id

--5. Create a query to list the names of teachers and the courses they are assigned to. 
-- Join the "Teacher" table with the "Courses" table. 
select t.first_name, t.last_name, c.course_name
from Teacher t
join Courses c on t.teacher_id=c.teacher_id

--6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the 
-- "Students" table with the "Enrollments" and "Courses" tables. 
select s.first_name, c.course_name, e.enrollment_date
from Students s
join Enrollments e on s.student_id=e.student_id
join Courses c on e.course_id=c.course_id

--7. Find the names of students who have not made any payments. Use a LEFT JOIN between the 
-- "Students" table and the "Payments" table and filter for students with NULL payment records.  
select s.first_name, p.amount
from Students s
left join Payments p on s.student_id=p.student_id
where p.amount is null

--8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN 
-- between the "Courses" table and the "Enrollments" table and filter for courses with NULL 
-- enrollment records
select c.course_id, c.course_name, e.enrollment_id
from Courses c
left join Enrollments e on c.course_id=e.course_id
where enrollment_id is null

--9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" 
-- table to find students with multiple enrollment records.
SELECT e1.student_id, COUNT(DISTINCT e1.course_id) AS course_count
FROM Enrollments e1
JOIN Enrollments e2 ON e1.student_id = e2.student_id AND e1.course_id <> e2.course_id
GROUP BY e1.student_id

--10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" 
-- table and the "Courses" table and filter for teachers with NULL course assignments.
select t.first_name, c.course_name
from Teacher t
left join Courses c on t.teacher_id=c.teacher_id
where c.course_name is null