using System;
using System.Collections.Generic;
using ProjectManagement.dao;
using ProjectManagement.entity;
using ProjectManagement.myexceptions;

using Task = ProjectManagement.entity.Task;

namespace ProjectManagementSystem
{
    class Program
    {
        static void Main(string[] args)
        {
            IProjectRepository repo = new ProjectRepositoryImpl();
            bool exit = false;

            while (!exit)
            {
                Console.WriteLine("\n--- Project Management System Menu ---");
                Console.WriteLine("1. Add Employee");
                Console.WriteLine("2. Add Project");
                Console.WriteLine("3. Add Task");
                Console.WriteLine("4. Assign Project to Employee");
                Console.WriteLine("5. Assign Task within Project to Employee");
                Console.WriteLine("6. Delete Employee");
                Console.WriteLine("7. Delete Project");
                Console.WriteLine("8. List Tasks for an Employee in a Project");
                Console.WriteLine("9. Exit");
                Console.Write("Select an option: ");

                int choice;
                if (!int.TryParse(Console.ReadLine(), out choice))
                {
                    Console.WriteLine("Invalid input. Please enter a number.");
                    continue;
                }

                try
                {
                    switch (choice)
                    {
                        case 1:
                            Console.Write("Enter Employee ID: ");
                            int empId = int.Parse(Console.ReadLine());
                            Console.Write("Enter Name: ");
                            string name = Console.ReadLine();
                            Console.Write("Enter Designation: ");
                            string designation = Console.ReadLine();
                            Console.Write("Enter Gender: ");
                            string gender = Console.ReadLine();
                            Console.Write("Enter Salary: ");
                            decimal salary = decimal.Parse(Console.ReadLine());
                            
                            Employee emp = new Employee(empId, name, designation, gender, salary, null);
                            bool empCreated = repo.CreateEmployee(emp);
                            Console.WriteLine(empCreated ? "Employee added successfully." : "Failed to add employee.");
                            break;

                        case 2:
                            Console.Write("Enter Project ID: ");
                            int projId = int.Parse(Console.ReadLine());
                            Console.Write("Enter Project Name: ");
                            string projName = Console.ReadLine();
                            Console.Write("Enter Description: ");
                            string desc = Console.ReadLine();
                            Console.Write("Enter Start Date (yyyy-mm-dd): ");
                            DateTime startDate = DateTime.Parse(Console.ReadLine());
                            Console.Write("Enter Status (started/dev/build/test/deployed): ");
                            string status = Console.ReadLine();

                            Project proj = new Project(projId, projName, desc, startDate, status);
                            bool projCreated = repo.CreateProject(proj);
                            Console.WriteLine(projCreated ? "Project added." : "Failed to add project.");
                            break;

                        case 3:
                            Console.Write("Enter Task ID: ");
                            int taskId = int.Parse(Console.ReadLine());
                            Console.Write("Enter Task Name: ");
                            string taskName = Console.ReadLine();
                            Console.Write("Enter Project ID: ");
                            int taskProjId = int.Parse(Console.ReadLine());
                            Console.Write("Enter Employee ID: ");
                            int taskEmpId = int.Parse(Console.ReadLine());
                            Console.Write("Enter Status (Assigned/Started/Completed): ");
                            string taskStatus = Console.ReadLine();

                            Task task = new Task(taskId, taskName, taskProjId, taskEmpId, taskStatus);
                            bool taskCreated = repo.CreateTask(task);
                            Console.WriteLine(taskCreated ? "Task added." : "Failed to add task.");
                            break;

                        case 4:
                            Console.Write("Enter Project ID: ");
                            int assignProjId = int.Parse(Console.ReadLine());
                            Console.Write("Enter Employee ID: ");
                            int assignEmpId = int.Parse(Console.ReadLine());

                            bool projAssigned = repo.AssignProjectToEmployee(assignProjId, assignEmpId);
                            Console.WriteLine(projAssigned ? "Project assigned to employee." : "Assignment failed.");
                            break;

                        case 5:
                            Console.Write("Enter Task ID: ");
                            int assignTaskId = int.Parse(Console.ReadLine());
                            Console.Write("Enter Project ID: ");
                            int assignProj = int.Parse(Console.ReadLine());
                            Console.Write("Enter Employee ID: ");
                            int assignEmp = int.Parse(Console.ReadLine());

                            bool taskAssigned = repo.AssignTaskInProjectToEmployee(assignTaskId, assignProj, assignEmp);
                            Console.WriteLine(taskAssigned ? "Task assigned to employee." : "Assignment failed.");
                            break;

                        case 6:
                            Console.Write("Enter Employee ID to delete: ");
                            int delEmpId = int.Parse(Console.ReadLine());

                            bool empDeleted = repo.DeleteEmployee(delEmpId);
                            Console.WriteLine(empDeleted ? "Employee deleted." : "Failed to delete employee.");
                            break;

                        case 7:
                            Console.Write("Enter Project ID to delete: ");
                            int delProjId = int.Parse(Console.ReadLine());

                            bool projDeleted = repo.DeleteProject(delProjId);
                            Console.WriteLine(projDeleted ? "Project deleted." : "Failed to delete project.");
                            break;

                        case 8:
                            Console.Write("Enter Employee ID: ");
                            int searchEmpId = int.Parse(Console.ReadLine());
                            Console.Write("Enter Project ID: ");
                            int searchProjId = int.Parse(Console.ReadLine());

                            List<Task> tasks = repo.GetAllTasks(searchEmpId, searchProjId);
                            if (tasks.Count == 0)
                                Console.WriteLine("No tasks found.");
                            else
                            {
                                Console.WriteLine("\nTasks Assigned:");
                                foreach (var t in tasks)
                                    Console.WriteLine($"Task ID: {t.TaskId}, Name: {t.TaskName}, Status: {t.Status}");
                            }
                            break;

                        case 9:
                            exit = true;
                            Console.WriteLine("Exiting the application...");
                            break;

                        default:
                            Console.WriteLine("Invalid choice. Please select from the menu.");
                            break;
                    }
                }
                catch (EmployeeNotFoundException ex)
                {
                    Console.WriteLine($"Employee Error: {ex.Message}");
                }
                catch (ProjectNotFoundException ex)
                {
                    Console.WriteLine($"Project Error: {ex.Message}");
                }
                catch (FormatException)
                {
                    Console.WriteLine("Invalid input format. Please enter correct values.");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"An error occurred: {ex.Message}");
                }
            }
        }
    }
}
    