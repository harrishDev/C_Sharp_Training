using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using ProjectManagement.entity;
using Microsoft.Data.SqlClient;
using Task = ProjectManagement.entity.Task;
using ProjectManagement.myexceptions;
using ProjectManagement.util;

namespace ProjectManagement.dao
{
    class ProjectRepositoryImpl : IProjectRepository
    {
        
        //string connectionString = DBPropertyUtil.GetConnectionString("db.properties");

        // string connectionString = "Server=DESKTOP-HNVF699;Database=ProjectManagement;TrustServerCertificate=True;Integrated Security=True;";
        public bool CreateEmployee(Employee emp)
        {
            string query = @"SET IDENTITY_INSERT Employee ON;
                 INSERT INTO Employee (employee_id, name, designation, gender, salary)
                 VALUES (@employee_id, @name, @designation, @gender, @salary);
                 SET IDENTITY_INSERT Employee OFF;";
            using (SqlConnection conn = DBConnUtil.GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@employee_id", emp.Id);
                cmd.Parameters.AddWithValue("@name", emp.Name);
                cmd.Parameters.AddWithValue("@designation", emp.Designation);
                cmd.Parameters.AddWithValue("@gender", emp.Gender);
                cmd.Parameters.AddWithValue("@salary", emp.Salary);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }
        public bool CreateProject(Project project)
        {
            string query = @"SET IDENTITY_INSERT Project ON;
                            INSERT INTO PROJECT (project_id, Projectname, Description, startdate, status)
                            VALUES (@project_id, @Projectname, @Description, @startdate, @status);
                            SET IDENTITY_INSERT Project OFF";
            using (SqlConnection conn = DBConnUtil.GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@project_id", project.Id);
                cmd.Parameters.AddWithValue("@Projectname", project.ProjectName);
                cmd.Parameters.AddWithValue("@Description", project.Description);
                cmd.Parameters.AddWithValue("@startdate", project.StartDate);
                cmd.Parameters.AddWithValue("@status", project.Status);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }
        
        public bool CreateTask(Task task)
        {
            string query = @"SET IDENTITY_INSERT Task ON;
                            INSERT INTO TASK (task_id, task_name, project_id, employee_id, status)
                            VALUES (@task_id, @task_name, @project_id, @employee_id, @status);
                            SET IDENTITY_INSERT Task OFF";
            using (SqlConnection conn = DBConnUtil.GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@task_id", task.TaskId);
                cmd.Parameters.AddWithValue("@task_name", task.TaskName);
                cmd.Parameters.AddWithValue("@project_id", task.ProjectId);
                cmd.Parameters.AddWithValue("@employee_id", task.EmployeeId);
                cmd.Parameters.AddWithValue("@status", task.Status);
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }
        public bool AssignProjectToEmployee(int project_id, int employee_id)
        {
            string query = @"UPDATE EMPLOYEE SET project_id = @project_id WHERE employee_id = @employee_id";
            using (SqlConnection conn = DBConnUtil.GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@project_id", project_id);
                cmd.Parameters.AddWithValue("@employee_id", employee_id);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                if (rows == 0)
                {
                    throw new EmployeeNotFoundException("Employee not found");
                }
                return true;
            }
        }

        public bool AssignTaskInProjectToEmployee(int task_id, int project_id, int employee_id)
        {
            string query = @"UPDATE TASK SET employee_id = @employee_id WHERE task_id = @task_id";
            using (SqlConnection conn = DBConnUtil.GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@employee_id", employee_id);
                cmd.Parameters.AddWithValue("@task_id", task_id);
                cmd.Parameters.AddWithValue("@project_id", project_id);
                conn.Open();
                return cmd.ExecuteNonQuery()>0;
            }
        }

        public bool DeleteEmployee(int employeeId)
        {
            string query = @"DELETE FROM EMPLOYEE WHERE employee_id = @employee_id";
            using (SqlConnection conn = DBConnUtil.GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                if (rows == 0)
                {
                    throw new EmployeeNotFoundException("Employee not found");
                }
                return true;
            }
        }
        public bool DeleteProject(int projectId)
        {
            string query = @"DELETE FROM PROJECT WHERE project_id = @project_id";
            using (SqlConnection conn = DBConnUtil.GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@project_id", projectId);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                if (rows == 0)
                {
                    throw new ProjectNotFoundException("Project not found");
                }
                return true;
            }
        }

        public List<Task> GetAllTasks(int employeeId, int projectId)
        {
            List<Task> tasks = new List<Task>();
            string query = @"SELECT * FROM TASK WHERE employee_id = @employee_id AND project_id = @project_id";
            using (SqlConnection conn = DBConnUtil.GetConnection())
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@employee_id", employeeId);
                cmd.Parameters.AddWithValue("@project_id", projectId);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Task task = new Task
                        (
                            reader.GetInt32(0),
                            reader.GetString(1),
                            reader.GetInt32(2),
                            reader.GetInt32(3),
                            reader.GetString(4)
                        );
                        tasks.Add(task);
                    }
                }    

            }
            return tasks;
        }
    }
}
