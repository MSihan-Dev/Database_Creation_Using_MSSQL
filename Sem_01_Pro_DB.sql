select * from daily_attendance
select * from emp_personal_details
select * from emp_personal_details  where Em_id = '3'
select * from emp_personal_details s where s.Em_id = '3'

select s.Em_id, s.Em_full_name,
(select count (*) from daily_attendance where at.Em_id_fk = s.Em_id and at.intime between '2023-10-2' and '2023-10-30') as NoOfAttendance,
( select sum (DATEDIFF(hour, at.intime, at.out_time))from daily_attendance where at.Em_id_fk = s.Em_id and at.intime between '2023-10-30' and '30-10-2023') as NoOfHours
from emp_personal_details s where s.Em_id = '3'; 

SELECT s.Em_id, s.Em_full_name,
    (
        SELECT COUNT(*) 
        FROM daily_attendance at1 
        WHERE at1.Em_id_fk = s.Em_id 
        AND at1.intime BETWEEN '2023-10-2' AND '2023-10-30'
    ) as NoOfAttendance,
    (
        SELECT SUM(DATEDIFF(hour, at2.intime, at2.out_time))
        FROM daily_attendance at2
        WHERE at2.Em_id_fk = s.Em_id 
        AND at2.intime BETWEEN '2023-10-2' AND '2023-10-30'
    ) as NoOfHours
FROM emp_personal_details s 
WHERE s.Em_id = '3';

SELECT s.Em_id, s.Em_full_name,
    (
        SELECT COUNT(*) 
        FROM daily_attendance at1 
        WHERE at1.Em_id_fk = s.Em_id 
        AND at1.intime BETWEEN '2023-10-2' AND '2023-10-30'
    ) as NoOfAttendance,
    (
        SELECT SUM(worked_hours)
        FROM daily_attendance at2
        WHERE at2.Em_id_fk = s.Em_id 
        AND at2.intime BETWEEN '2023-10-2' AND '2023-10-30'
    ) as NoOfHours
FROM emp_personal_details s 
WHERE s.Em_id = '3';


select * from daily_attendance where daily_attendance.Em_id_fk = 3
select DATEDIFF(hour, intime, out_time) as h from daily_attendance where daily_attendance.Em_id_fk = 3

update daily_attendance set out_time = '2023-10-03 05:30:00.000' where att_id = 7



SELECT * FROM emp_personal_details WHERE Em_full_name = 'M.Kumar'

select (Em_Salary + Allowence) from emp_personal_details WHERE Em_full_name = 'M.Kumar'

select * from emp_personal_details

SELECT s.Em_id, s.Em_full_name,
    (
        SELECT sum (no_of_leaves) 
        FROM requested_leave at1 
        WHERE at1.Em_id = s.Em_id 
    ) *(
	(
	select (Em_Salary + Allowence) 
	from emp_personal_details 
	WHERE Em_full_name = 'M.Kumar'
	) /
	(
	select date_range 
	from workdays 
	WHERE Wo_id = '5'
	) )as 'Nopay Value'
FROM emp_personal_details s 
WHERE s.Em_id = '3';

select date_range from workdays WHERE Wo_id = '5'
select * from workdays

select * from requested_leave
select * from type_of_leaves

select sum(no_of_leaves) from requested_leave where Em_id ='3'


--basepay--
select (Em_Salary + Allowence) 
from emp_personal_details 
WHERE Em_full_name = 'M.Kumar'

select * from daily_attendance

--SELECT s.Em_id, s.Em_full_name,--
	SELECT
    (
       (
       SELECT SUM(worked_hours) as totalWorkedHours
       FROM daily_attendance at2
       WHERE at2.Em_id_fk = '3' 
       AND at2.intime BETWEEN '2023-10-2' AND '2023-10-30'
       ) - (
			(
			SELECT Daily_Working_hours FROM Configure
			) * (
				(
				SELECT date_range FROM workdays WHERE Wo_id = '5'
				) - ( 
					SELECT SUM (no_of_leaves) 
					FROM requested_leave
					WHERE Em_id = '3'
					)
				)
			)
		) 
		* 
		(
        SELECT OT_Rate_hourly
        FROM emp_personal_details
        WHERE Em_id = s.Em_id
		) 
		+ 
		(
        SELECT (Em_Salary + Allowence) 
        FROM emp_personal_details 
        WHERE Em_id = s.Em_id
	) AS BasepayValue
FROM emp_personal_details s 
WHERE s.Em_id = '3';

select * from Configure
insert into Configure (Daily_Working_hours) values ('8')
DELETE Configure WHERE Work_Hours_Id ='2'







SELECT s.Em_id, s.Em_full_name,
    (
       (
            SELECT SUM(worked_hours)
            FROM daily_attendance at2
            WHERE at2.Em_id_fk = s.Em_id 
            AND at2.intime BETWEEN '2023-10-2' AND '2023-10-30'
        ) - 80
    ) * (
        SELECT OT_Rate_hourly
        FROM emp_personal_details
        WHERE Em_id = s.Em_id
    ) + (
        SELECT (Em_Salary + Allowence) 
        FROM emp_personal_details 
        WHERE Em_id = s.Em_id
    ) AS 'Basepay Value',
	    (
        SELECT SUM (no_of_leaves)
        FROM requested_leave a 
        WHERE a.Em_id = s.Em_id 
    ) * (
        (
            SELECT (Em_Salary + Allowence) 
            FROM emp_personal_details 
            WHERE Em_id = s.Em_id
        ) / (
            SELECT date_range 
            FROM workdays 
            WHERE Wo_id = '5'
        )
    ) AS 'Nopay Value'
FROM emp_personal_details s 
WHERE s.Em_id = '3';


--grosspay--
SELECT (Em_Salary + Allowence) as TotalSalary FROM emp_personal_details WHERE Em_id = 3

select * from Em_salary
delete Em_salary where salary_id = 3






	SELECT
    (
       (
       SELECT SUM(worked_hours) as totalWorkedHours FROM daily_attendance at2 WHERE at2.Em_id_fk = '3'  AND at2.intime BETWEEN '2023-10-2' AND '2023-10-30'
       ) - (
			(
			SELECT Daily_Working_hours FROM Configure
			) * (
				(
				SELECT date_range FROM workdays WHERE Wo_id = '5'
				) - ( 
					SELECT SUM (no_of_leaves) FROM requested_leave WHERE Em_id = '3'
					)
				)
			)
		) 
		* 
		(
        SELECT OT_Rate_hourly FROM emp_personal_details WHERE Em_id = s.Em_id
		) 
		+ 
		(
        SELECT (Em_Salary + Allowence) as 'total_sallary' FROM emp_personal_details WHERE Em_id = 3
	) AS BasepayValue 
FROM emp_personal_details s  WHERE s.Em_id = '3';



select * from workdays
select begin_date ,end_date from workdays where Wo_id =5




--ot hourse--
SELECT
	(
		SELECT Daily_Working_hours FROM Configure
	) * (
		(
		SELECT date_range FROM workdays WHERE Wo_id = '5'
		) - ( 
			SELECT SUM (no_of_leaves) 
			FROM requested_leave
			WHERE Em_id = '3'
			)
		)
		) 
		* 
		(
        SELECT OT_Rate_hourly
        FROM emp_personal_details
        WHERE Em_id = 3
		) 




SELECT * FROM daily_attendance


SELECT
	(
		(
			SELECT SUM(worked_hours) AS Worked_Hours FROM daily_attendance where Em_id_fk = '3'
		) - (
				(
					(
						SELECT Daily_Working_hours FROM Configure
					) * (
							SELECT date_range FROM workdays WHERE Wo_id = '5'
						)
				) - (
						SELECT SUM (no_of_leaves) FROM requested_leave WHERE Em_id = '3'
					)
			)
	)


SELECT
	(
		(
			SELECT SUM(worked_hours) AS Worked_Hours FROM daily_attendance where Em_id_fk = '3'
		) - (
				(
					(
						SELECT date_range FROM workdays WHERE Wo_id = '5'
					) - (
							SELECT SUM (no_of_leaves) as Total_Leaves FROM requested_leave WHERE Em_id = '3' 
						)
				) * (
						SELECT Daily_Working_hours FROM Configure
					)
			)
	) AS Worked_OT_Hours


--base pay
SELECT
    (
       (
       SELECT SUM(worked_hours) as totalWorkedHours FROM daily_attendance at2 WHERE at2.Em_id_fk = '{id}'  AND at2.intime BETWEEN '2023-10-2' AND '2023-10-30'
       ) - (
			(
			SELECT Daily_Working_hours FROM Configure
			) * (
				(
				SELECT date_range FROM workdays WHERE Wo_id = '5'
				) - ( 
					SELECT SUM (no_of_leaves) FROM requested_leave WHERE Em_id = '{id}'
					)
				)
			)
		) 
		* 
		(
        SELECT OT_Rate_hourly FROM emp_personal_details WHERE Em_id = '{id}'
		) 
		+ 
		(
        SELECT (Em_Salary + Allowence) as 'total_sallary' FROM emp_personal_details WHERE Em_id = '{id}'
	) AS BasepayValue 
FROM emp_personal_details s  WHERE s.Em_id = '{id}';


SELECT(('{totSalaryTextBox}') + ( (SELECT OT_Rate_hourly FROM emp_personal_details WHERE Em_id = '{id}') * ('{OThourseTextBox}') ) * ('{taxRateTextBox}'))

select * from Configure
UPDATE Configure
SET Taxrate = '0.08'
WHERE Config_id = 1;


select * from requested_leave
Select sum (no_of_leaves) from requested_leave where Em_id = 3 and ToL_id = 6 and leave_begin_date BETWEEN '2023-10-2' AND '2023-10-30'

Select sum (no_of_leaves) as Total_Leaves from requested_leave where Em_id = 3 and leave_begin_date BETWEEN '2023-10-2' AND '2023-10-30' 

select Taxrate from Configure

select * (select Em_full_name from emp_personal_details ) from Em_salary

SELECT emp_personal_details.Em_full_name, Em_salary.* FROM emp_personal_details where Em_id =3 JOIN Em_salary ON emp_personal_details.Em_id = Em_salary.Em_id;
SELECT emp_personal_details.Em_full_name, Em_salary.* FROM emp_personal_details JOIN Em_salary ON emp_personal_details.Em_id = Em_salary.Em_id WHERE emp_personal_details.Em_id = 3;

SELECT emp_personal_details.Employee_Full_Name, type_of_leaves.Leave_Type, request_leave.* FROM emp_personal_details JOIN request_leave ON emp_personal_details.Employee_id = request_leave.Employee_id JOIN type_of_leaves ON type_of_leaves.Leave_Type_id = request_leave.Leave_Types_id;
SELECT emp_personal_details.Employee_Full_Name, type_of_leaves.Leave_Type, request_leave.* FROM emp_personal_details JOIN request_leave ON emp_personal_details.Employee_id = request_leave.Employee_id JOIN type_of_leaves ON type_of_leaves.Leave_Type_id = request_leave.Leave_Types_id where request_leave.Employee_id = 3

SELECT emp_personal_details.Employee_Full_Name, daily_attendance. * FROM emp_personal_details JOIN daily_attendance ON emp_personal_details.Employee_id = daily_attendance.Employee_id WHERE daily_attendance.Employee_id = 3

SELECT * FROM emp_personal_details , Employee_Types_Table.Employee_Type emp_personal_details JOIN Employee_Type ON emp_personal_details.Employee_Type = Employee_Type.Emloyee_Type_id
SELECT 
SELECT * FROM emp_personal_details JOIN Employee_Types.Employee_Type ON emp_personal_details.Employee_Type = Employee_Types.Employee_Type_id WHERE Employee_id = 3

select Employee_Type ,
	(select * from emp_personal_details)
from Employee_Types

SELECT * FROM Configure
select annually_leves from Configure
SELECT * FROM request_leave

SELECT No_of_Leaves FROM request_leave nf WHERE Employee_id = 3 AND nf.Leave_Begin_Date BETWEEN (select Annual_Year_Start_Date from Configure) AND (select Annual_Year_End_Date from Configure)

SELECT SUM(No_of_Leaves) FROM request_leave nf WHERE Employee_id = 3 AND nf.Leave_Begin_Date BETWEEN (SELECT Annual_Year_Start_Date FROM Configure) AND (SELECT Annual_Year_End_Date FROM Configure);

select annually_leves from Configure c1 WHERE 2023-10-23 BETWEEN C1.Annual_Year_Start_Date AND c1.Annual_Year_End_Date
SELECT annually_leves FROM Configure c1 WHERE '2023-10-23' BETWEEN c1.Annual_Year_Start_Date AND c1.Annual_Year_End_Date;

SELECT * FROM daily_attendance

SELECT((SELECT SUM (worked_hours) AS Worked_Hours FROM daily_attendance where Employee_id = '{id}' and ) - (((SELECT Work_Date_Range FROM workdays WHERE Wo_id = '{daterangeidbox.Text}') - (SELECT SUM (No_of_Leaves) as Total_Leaves FROM request_leave WHERE Employee_id = '{id}' and )) * (SELECT Daily_Working_Hours FROM Configure C1 WHERE '{}' BETWEEN C1.Annual_Year_Start_Date AND c1.Annual_Year_End_Date ))) AS Worked_OT_Hours
SELECT((SELECT SUM (worked_hours) AS Worked_Hours FROM daily_attendance DA where Employee_id = '3' and DA.Intime BETWEEN '2023-10-02' AND '2023-10-10') - (((SELECT Work_Date_Range FROM workdays WHERE Wo_id = '5') - (SELECT SUM (No_of_Leaves) as Total_Leaves FROM request_leave WHERE Employee_id = '3' and Leave_Begin_Date BETWEEN '2023-10-02' AND '2023-10-10')) * (SELECT Daily_Working_Hours FROM Configure C1 WHERE '2023-10-23' BETWEEN C1.Annual_Year_Start_Date AND c1.Annual_Year_End_Date ))) AS Worked_OT_Hours
SELECT SUM (worked_hours) AS Worked_Hours FROM daily_attendance DA where Employee_id = '3' and DA.Intime BETWEEN '2023-10-2' AND '2023-10-12'

SELECT sum(DATEDIFF(HOUR,Intime , Out_time)) AS Worked_Hours FROM daily_attendance DA where Employee_id = '3' and DA.Intime BETWEEN '2023-10-2' AND '2023-10-12'
SELECT sum(worked_hours) AS Worked_Hours FROM daily_attendance DA where Employee_id = '3' and DA.Intime BETWEEN '2023-10-2' AND '2023-10-12'

SELECT (Out_time - Intime) AS Worked_Hours FROM daily_attendance DA where Employee_id = '3' and DA.Intime BETWEEN '2023-10-6' AND '2023-10-15' and DA.Out_time BETWEEN '2023-10-6' AND '2023-10-15'
SELECT * FROM daily_attendance

SELECT * FROM request_leave
SELECT SUM (No_of_Leaves) as Total_Leaves FROM request_leave WHERE Employee_id = '3' and BETWEEN '2023-10-02' AND '2023-10-10'
SELECT (Leave_End_Date - Leave_Begin_Date) as Total_Leaves FROM request_leave WHERE Employee_id = '3' and BETWEEN '2023-10-02' AND '2023-10-10'

SELECT Leave_End_Date ,Leave_Begin_Date FROM request_leave;
SELECT DATEDIFF(day, Leave_Begin_Date, Leave_End_Date) AS Leave_Duration
FROM request_leave;


select * from Monthly_holiday


select * from workdays where Wo_id = '5'

SELECT SUM (No_of_Leaves) as Total_Leaves FROM request_leave WHERE Employee_id = '3' and Leave_Begin_Date BETWEEN '2023-10-02' AND '2023-10-10'

select * from request_leave where Employee_id = '4'

select * from Login_Details
select Admin_id from admin where Username = 'imadmin2'

SELECT *
FROM emp_personal_details
JOIN Employee_Types_Details.Employee_Type ON emp_personal_details.Employee_Type_id = Employee_Types_Details.Employee_Type_id;


 insert into Login_Details (User_Type,Username,Password) values ('Admin','adm','123')
  insert into Login_Details (User_Type,Username,Password) values ('Manager','mag','456')

update Monthly_holiday set Admin_Id = 2
select * from request_leave

SELECT SUM(No_of_Leaves) FROM request_leave nf WHERE Employee_id = '4' AND nf.Leave_Begin_Date BETWEEN (SELECT Annual_Year_Start_Date FROM Configure) AND (SELECT Annual_Year_End_Date FROM Configure)) AS LeaveSum
select ( ( SELECT annually_leves FROM Configure c1 WHERE '2023-10-15' BETWEEN c1.Annual_Year_Start_Date AND c1.Annual_Year_End_Date) - ( SELECT SUM(No_of_Leaves) FROM request_leave nf WHERE Employee_id = '3' AND nf.Leave_Begin_Date BETWEEN (SELECT MIN(Annual_Year_Start_Date) FROM Configure) AND (SELECT MAX(Annual_Year_End_Date) FROM Configure)and nf.RLeave_id != '' and nf.Leave_Types_id != '6')) AS LeaveSum

SELECT ( ('15000' / (SELECT Work_Date_Range FROM workdays WHERE Wo_id = '5')) * (Select sum (No_of_Leaves) as nopayLeves from request_leave where Employee_id = '4' and Leave_Types_id = 6  and Leave_Begin_Date BETWEEN '2023-10-01' AND '2023-10-31') ) as NoPayValue
 select ( ( SELECT annually_leves FROM Configure c1 WHERE '{_startdatebox}' BETWEEN c1.Annual_Year_Start_Date AND c1.Annual_Year_End_Date) - ( SELECT SUM(No_of_Leaves) FROM request_leave nf WHERE Employee_id = '{_empnamebox.SelectedValue}' AND nf.Leave_Begin_Date BETWEEN (SELECT Annual_Year_Start_Date FROM Configure) AND (SELECT Annual_Year_End_Date FROM Configure) and nf.RLeave_id != '{_idbox}'  and nf.Leave_Types_id != '6')) AS AnnualLeaveBalance";



SELECT No_of_Leaves FROM request_leave nf WHERE Employee_id = '3' AND nf.Leave_Begin_Date BETWEEN (SELECT Annual_Year_Start_Date FROM Configure) AND (SELECT Annual_Year_End_Date FROM Configure)

SELECT No_of_Leaves FROM request_leave nf WHERE Employee_id = '3' AND nf.Leave_Begin_Date BETWEEN 
    (SELECT MIN(Annual_Year_Start_Date) FROM Configure) AND (SELECT MAX(Annual_Year_End_Date) FROM Configure)

 select ( ( SELECT annually_leves FROM Configure c1 WHERE '{_startdatebox}' BETWEEN c1.Annual_Year_Start_Date AND c1.Annual_Year_End_Date) - ( SELECT SUM(No_of_Leaves) FROM request_leave nf WHERE Employee_id = '{_empnamebox.SelectedValue}' AND nf.Leave_Begin_Date BETWEEN (SELECT Annual_Year_Start_Date FROM Configure) AND (SELECT Annual_Year_End_Date FROM Configure) and nf.RLeave_id != '{_idbox}'  and nf.Leave_Types_id != '6')) AS AnnualLeaveBalance";

select ( ( SELECT annually_leves FROM Configure c1 WHERE '2023-10-15' BETWEEN c1.Annual_Year_Start_Date AND c1.Annual_Year_End_Date) - ( SELECT SUM(No_of_Leaves) FROM request_leave nf WHERE Employee_id = '24' AND nf.Leave_Begin_Date BETWEEN (SELECT MIN(Annual_Year_Start_Date) FROM Configure) AND (SELECT MAX(Annual_Year_End_Date) FROM Configure) and nf.RLeave_id != '33'  and nf.Leave_Types_id != '6')) AS AnnualLeaveBalance
