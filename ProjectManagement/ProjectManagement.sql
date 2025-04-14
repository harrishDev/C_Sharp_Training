use	ProjectManagement;

select * from Employee
select * from Project
select * from task

ALTER TABLE Employee
ALTER COLUMN Project_id INT NULL;

exec sp_rename 'tasks', 'task'


ALTER TABLE Task
ADD CONSTRAINT FK_Task_Employee
FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
ON DELETE CASCADE;

ALTER TABLE Task
ADD CONSTRAINT FK_Task_Project
FOREIGN KEY (project_id) REFERENCES Project(project_id)
ON DELETE CASCADE;

