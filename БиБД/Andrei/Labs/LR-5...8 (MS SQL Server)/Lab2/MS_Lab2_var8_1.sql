USE AdventureWorks2012;
GO

-- Вывести на экран список сотрудников которые подавали резюме при трудоустройстве.
SELECT
    *
FROM
    HumanResources.Employee
    JOIN HumanResources.JobCandidate ON Employee.BusinessEntityID = JobCandidate.BusinessEntityID
    AND [Resume] IS NOT NULL;

-- Вывести на экран названия отделов, в которых работает более 10-ти сотрудников.
SELECT
    tmp.DepartmentID,
    Department.Name,
    tmp.EmpCount
FROM
    HumanResources.Department
    JOIN (
        SELECT
            DepartmentID,
            COUNT(BusinessEntityID) as EmpCount
        FROM
            HumanResources.EmployeeDepartmentHistory
        GROUP BY
            DepartmentID
    ) AS tmp ON tmp.DepartmentID = Department.DepartmentID
    AND EmpCount > 10;

-- Вывести на экран накопительную сумму часов отпуска по причине болезни (SickLeaveHours) в
-- рамках каждого отдела. Сумма должна накапливаться по мере трудоустройства сотрудников
-- (HireDate).
SELECT
    Department.Name,
    HireDate,
    SickLeaveHours,
    AccumulativeSum
FROM
    (
        SELECT
            tmp1.DepartmentID,
            tmp1.HireDate,
            tmp1.SickLeaveHours,
            SUM(tmp2.SickLeaveHours) AS AccumulativeSum
        FROM
            (
                SELECT
                    DepartmentID,
                    HireDate,
                    SickLeaveHours
                FROM
                    HumanResources.Employee
                    JOIN HumanResources.EmployeeDepartmentHistory ON Employee.BusinessEntityID = EmployeeDepartmentHistory.BusinessEntityID
            ) AS tmp1
            JOIN (
                SELECT
                    DepartmentID,
                    HireDate,
                    SickLeaveHours
                FROM
                    HumanResources.Employee
                    JOIN HumanResources.EmployeeDepartmentHistory ON Employee.BusinessEntityID = EmployeeDepartmentHistory.BusinessEntityID
            ) AS tmp2 ON tmp2.DepartmentID = tmp1.DepartmentID
            AND tmp2.HireDate <= tmp1.HireDate
        GROUP BY
            tmp1.DepartmentID,
            tmp1.HireDate,
            tmp1.SickLeaveHours
    ) AS tmp
    JOIN HumanResources.Department ON tmp.DepartmentID = Department.DepartmentID
ORDER BY
    Department.Name,
    HireDate;