using ProjectManagement.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Task = ProjectManagement.entity.Task;

namespace ProjectManagement.dao
{
    public interface IProjectRepository
    {
        bool CreateEmployee(Employee emp);
        bool CreateProject(Project project);
        bool CreateTask(Task task);
        bool AssignProjectToEmployee(int projectId , int employeeId);
        bool AssignTaskInProjectToEmployee(int taskId, int projectId, int employeeId);
        bool DeleteEmployee(int employeeId);
        bool DeleteProject(int projectId);
        List<Task> GetAllTasks (int employeeId, int projectId);
    }
}
