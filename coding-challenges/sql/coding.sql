create database CareerHub

--1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”. 
use CareerHub

--2. Create tables for Companies, Jobs, Applicants and Applications
create table Companies(
CompanyID int identity PRIMARY KEY,
CompanyName varchar(255),
Location varchar(255)
)

create table Jobs(
JobID int identity PRIMARY KEY,
CompanyID int not null,
JobTitle varchar(255),
JobDescription text,
JobLocation varchar(255),
Salary decimal(10,2),
JobType varchar(255),
PostedDate datetime,
foreign key (CompanyId) references Companies(CompanyId) on delete cascade
)

create table Applicants(
ApplicantID int identity PRIMARY KEY,
FirstName varchar(255),
LastName varchar(255),
Email varchar(255) unique,
Phone bigint unique,
Resume text,
constraint ch_phone check (Phone like '[6-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

create table Applications(
ApplicationID int identity PRIMARY KEY,
JobID int not null,
ApplicantID int not null,
ApplicationDate datetime,
CoverLetter text,
foreign key (JobID) references Jobs(JobID) on delete cascade,	
foreign key (ApplicantID) references Applicants(ApplicantID) on delete cascade
)

--4. Ensure the script handles potential errors, such as if the database or tables already exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'CareerHub')
BEGIN
    CREATE DATABASE CareerHub;
    PRINT 'Database CareerHub created successfully.';
END
ELSE
BEGIN
    PRINT 'Database CareerHub already exists.';
END

--5.Write an SQL query to count the number of applications received for each job listing in the 
--"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all 
--jobs, even if they have no applications
select j.jobtitle, count(a.applicationId) as application_count
from Jobs j
left join Applications a on j.JobID=a.JobID
group by j.JobTitle

--6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary 
--range. Allow parameters for the minimum and maximum salary values. Display the job title, 
--company name, location, and salary for each matching job
select j.jobtitle, c.companyname, j.joblocation, j.salary
from jobs j
join companies c on j.companyid = c.companyid
where j.salary between 300000 and 1000000

--7.Write an SQL query that retrieves the job application history for a specific applicant. Allow a 
--parameter for the ApplicantID, and return a result set with the job titles, company names, and 
--application dates for all the jobs the applicant has applied to. 
select j.jobtitle, c.companyname, a.applicationdate
from applications a
join jobs j on a.jobid = j.jobid
join companies c on j.companyid = c.companyid
where a.applicantid = 4

--8.Create an SQL query that calculates and displays the average salary offered by all companies for 
--job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero. 
select avg(salary) as average_salary
from jobs
where salary > 0;

--9.Write an SQL query to identify the company that has posted the most job listings. Display the 
--company name along with the count of job listings they have posted. Handle ties if multiple 
--companies have the same maximum count
select top 1 with ties c.companyname, count(j.jobid)as job_count
from Companies c
join Jobs j on c.CompanyID=j.CompanyID
group by c.CompanyName
order by job_count desc

--10. Find the applicants who have applied for positions in companies located in 'CityX' and have at 
--least 3 years of experience
alter table applicants
add experience int;

select a.applicantid, a.firstname, a.lastname, a.email, a.experience, c.companyname, j.jobtitle
from applicants a
join applications app on a.applicantid = app.applicantid
join jobs j on app.jobid = j.jobid
join companies c on j.companyid = c.companyid
where c.location = 'chennai' 
and a.experience >= 3

 --11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000. 
select distinct jobtitle
from jobs
where salary BETWEEN 60000 AND 80000;

update  jobs
set salary=60000
where jobid = 6

update jobs
set salary=75000
where jobid = 7

select * from Jobs

--12.Find the jobs that have not received any applications. 
select j.jobid, j.jobtitle, j.salary
from jobs j
left join applications a on j.jobid = a.jobid
where a.applicationid IS NULL

--13.Retrieve a list of job applicants along with the companies they have applied to and the positions 
--they have applied for
select a.applicantid, a.firstname, a.lastname, c.companyname, j.jobtitle
from applicants a
join applications app on a.applicantid = app.applicantid
join jobs j on app.jobid = j.jobid
join companies c on j.companyid = c.companyid

--14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not 
--received any applications
select c.companyname, COUNT(j.jobid) as job_count
from companies c
left join jobs j on c.companyid = j.companyid
group by c.companyname

--15.List all applicants along with the companies and positions they have applied for, including those 
--who have not applied
select a.applicantid, a.firstname, a.lastname, c.companyname, j.jobtitle
from applicants a
left join applications app on a.applicantid = app.applicantid
left join jobs j on app.jobid = j.jobid
left join companies c on j.companyid = c.companyid

--16.Find companies that have posted jobs with a salary higher than the average salary of all jobs.
select c.companyname
from companies c
join jobs j on c.companyid = j.companyid
where j.salary > (select AVG(salary) from jobs)
group by c.companyname

--17.Display a list of applicants with their names and a concatenated string of their city and state.
select a.applicantid, 
concat(a.firstname, space(1), a.lastname) as applicant_name, 
concat(a.city, ', ', a.state) as location
from applicants a

alter table applicants
add city varchar(255),
state varchar(255)

update applicants
set city = 'chennai', state = 'TN'
where applicantid = 1

update applicants
set city = 'Bangalore', state = 'KA'
where applicantid = 2

update applicants
set city = 'mumbai', state = 'MR'
where applicantid = 3

update applicants
set city = 'madurai', state = 'TN'
where applicantid = 4

--18.Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'. 
select jobid, jobtitle
from jobs
where jobtitle LIKE '%Developer%' OR jobtitle LIKE '%Engineer%'

--19.Retrieve a list of applicants and the jobs they have applied for, including those who have not 
--applied and jobs without applicants
select a.applicantid, a.firstname, a.lastname, j.jobtitle, c.companyname
from applicants a
left join applications app on a.applicantid = app.applicantid
left join jobs j on app.jobid = j.jobid
left join companies c on j.companyid = c.companyid

--20. List all combinations of applicants and companies where the company is in a specific city and the 
--applicant has more than 2 years of experience. For example: city=Chennai 

select a.applicantid, a.firstname, a.lastname, c.companyname, j.jobtitle
from applicants a
join applications app on a.applicantid = app.applicantid
join jobs j on app.jobid = j.jobid
join companies c on j.companyid = c.companyid
where c.Location = 'Chennai'
and a.experience > 2


select * from Companies
select * from Jobs
select * from Applicants
select * from Applications


