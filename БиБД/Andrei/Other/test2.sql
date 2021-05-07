use AdventureWorks2012;

--------------------------------------------------------1 LABA---------------------------------------------

select * from HumanResources.Employee
where MaritalStatus = 'S' and
year(BirthDate) < 1960;



select * from HumanResources.Employee
where JobTitle = 'Design Engineer'
order by HireDate desc;


select BusinessEntityID, DepartmentID, StartDate, EndDate,
case
	when EndDate IS NULL then year(GETDATE()) - year(StartDate)
	when EndDate IS NOT NULL then year(EndDate) - year(StartDate)
end as years
from HumanResources.EmployeeDepartmentHistory
where DepartmentID = (select DepartmentID from HumanResources.Department
where Name = 'Engineering');

 ------------------------------------------------------2 LABA(1 задание)--------------------------------------------------------------------

select * from HumanResources.JobCandidate;

select  candidate.BusinessEntityID,
		employe.OrganizationLevel,
		employe.JobTitle,
		candidate.JobCandidateID,
		candidate.Resume,
		candidate.ModifiedDate
from HumanResources.Employee as employe
join HumanResources.JobCandidate as candidate on candidate.BusinessEntityID = employe.BusinessEntityID;






select employe.DepartmentID, Name, count(BusinessEntityID) as NumberOfEntities from HumanResources.EmployeeDepartmentHistory as employe
join HumanResources.Department as department on department.DepartmentID = employe.DepartmentID
group by employe.DepartmentID, Name
having count(BusinessEntityID) > 9



select department.Name, sum(employee.SickLeaveHours) from HumanResources.Employee as employee
join HumanResources.EmployeeDepartmentHistory as employeDepartment on employee.BusinessEntityID = employeDepartment.BusinessEntityID
join HumanResources.Department as department on employeDepartment.DepartmentID = department.DepartmentID
group by department.Name
order by department.Name;


---------------------------------------------------------2 LABA(2 задание)------------------------------


select * from HumanResources.Employee;
select * from HumanResources.Department;
select * from HumanResources.EmployeeDepartmentHistory;
select * from HumanResources.EmployeePayHistory;
select * from HumanResources.JobCandidate;
select * from HumanResources.Shift;




create table Address
(
	AddressId INT primary key,
	AddressLine1 nvarchar(60),
	AddressLine2 nvarchar(60),
	City nvarchar(30),
	StateProvinceId INT,
	PostalCode nvarchar(15),
	ModifiedDate datetime
)

Alter Table Address
Add Id INT identity(1, 1) unique

Alter table Address
Add Check (StateProvinceId % 2 = 1)

Alter table Address
Add constraint AL2 default('Unknown') for AddressLine2;

Alter table Address
Add Check (AddressLine2 is not null)


select * from Person.CountryRegion;

select * from Address



insert into Address (AddressId, AddressLine1, City, StateProvinceId, PostalCode, ModifiedDate)
select AddressId, AddressLine1, City, address.StateProvinceId, PostalCode, address.ModifiedDate from Person.Address as address
join Person.StateProvince as stateProvince on address.StateProvinceID = stateProvince.StateProvinceID
join Person.CountryRegion as country on stateProvince.CountryRegionCode = country.CountryRegionCode
where country.Name Like 'a%' and address.StateProvinceID % 2 = 1




--------------------------------------------------------------3 LABA(1 задание)-------------------------------------------------------


select * from Person.CountryRegion;
select * from Person.StateProvince;

Alter table Address
Add PersonName nvarchar(100)


Declare @TableAddress Table
(
	AddressId INT primary key,
	AddressLine1 nvarchar(60),
	AddressLine2 nvarchar(60),
	City nvarchar(30),
	StateProvinceId INT,
	PostalCode nvarchar(15),
	ModifiedDate datetime,
	Id INT,
	PersonName nvarchar(100)
)

insert into @TableAddress (AddressId, AddressLine1, AddressLine2, City, StateProvinceId, PostalCode, ModifiedDate, Id, PersonName)
select * from Address
where StateProvinceId = 77


  
update t2
set AddressLine2 = Concat(country.CountryRegionCode, ',',  stateP.Name, ',', t.City)
from @TableAddress t2, @TableAddress t
join Person.StateProvince as stateP on stateP.StateProvinceID = t.StateProvinceID
join Person.CountryRegion as country on country.CountryRegionCode = stateP.CountryRegionCode
where t.AddressId = t2.AddressId
select * from @TableAddress

update Address
set AddressLine2 = t.AddressLine2 from @TableAddress t
where Address.AddressId = t.AddressId


update t2
set PersonName = concat(Person.FirstName, ' ', Person.LastName) from Address t2, Address t
join Person.BusinessEntityAddress as EntityAddress on EntityAddress.AddressID = t.AddressId
join Person.BusinessEntity as BEntity on BEntity.BusinessEntityID = EntityAddress.BusinessEntityID
join Person.Person as Person on Person.BusinessEntityID = BEntity.BusinessEntityID
where t2.AddressId = t.AddressId


select * from Address;

delete from Address
from Address t join Person.BusinessEntityAddress as BEntity on BEntity.AddressID = t.AddressId
join Person.AddressType as TypeA on TypeA.AddressTypeID = BEntity.AddressTypeID
where TypeA.Name = 'Main Office'









select * from Person.Person
SELECT *
FROM AdventureWorks2012.INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Address';


delete from AdventureWorks2012.INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
WHERE TABLE_NAME = 'Address';


alter table Address
Drop Constraint CK__Address__Address__405A880E;

alter Table address drop column PersonName




select * from Person.AddressType;
select * from Person.BusinessEntityAddress


select * from Person.CountryRegion;
select * from Person.StateProvince;
select * from Address;
select * from Person.Person;
select * from Person.BusinessEntity;
select * from Person.BusinessEntityAddress;










