---1 Create a table for Patient with constraints.

create table patient(
patient_id int primary key,
name varchar(100),
gender varchar(10),
date_of_birth date,
contact_number varchar(15)
);

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_name VARCHAR(100),
    appointment_date DATE,
    department VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);
-----2.Alter the Appointment table to add a new column status VARCHAR(20).
alter table appointment
add  column status varchar(20)

-----3.Insert sample data into both tables for 5 patients and 5 appointments.
insert into patient(patient_id, name, gender, date_of_birth, contact_number)
values(1, 'aadya', 'female', '05-06-2003', 09876544)
insert into appointment(appointment_id, patient_id, doctor_name, appointment_date, department )
values(1,1,'kavya','05-04-2025', 'neurology')
select * from appointment
----4.Update the department of an appointment where appointment_id = 2 to 'Neurology'.
update  appointment 
 set  department = 'neurology' where appointment_id = 2;

 ---5.Delete the patient whose name = 'John Doe'.
 delete from patient 
 where name = 'John Doe'

 ---6.Retrieve all patient names along with their appointment date and doctor name.

select * from patient as p
left join appointment a 
on p.appointment_id = a.appointment_id

----7.List all patients who have appointments in the 'Cardiology' department.
select * from appointment a
join patient p
on a.patient_id = p.patient_id
where department = 'cardiology' 

----8.Get patient details who have an appointment with doctor 'Dr. Smith'.
select * from appointment a
join patient p
on a.patient_id = p.patient_id
where doctor_name = 'Dr.Smith'
----9.Display appointment details where the patient's age is greater than 60.

select * from appointment a
join patient p 
on a.patient_id = p.patient_id
where patient_age is > 60
----10. Find patients who have more than one appointment (use GROUP BY and HAVING).
select p.patient_id, count(a.appointment_id) as appointment_count
from Patient p
join Appointment a
on p.patient_id = a.patient_id
group by p.patient_id
having count(a.appointment_id) > 1;
----11.Find the patient(s) who have the most number of appointments.
select count(*) from appointment a
left join patient p 
on a.patient_id = p.patient_id

---12.List patients who do not have any appointments.
select count(*) from appointment a
left join patient p 
on a.patient_id = p.patient_id
where p.patient_id is null

---13.Show the name and age of all patients (calculate age from date_of_birth).
select * from patient 
name,date_of_birth

---14.List appointments made in the last 30 days from today’s date.
select count(*) as appointment_count from appointment
  where  appointment_date <= '05-04-2025'
---15.Count the number of appointments per department.
select count(*) as department from appointment
----1.Find the name(s) of patient(s) who have taken appointments in all departments available in the Appointment table.


SELECT p.name
FROM patient p
WHERE p.patient_id IN (
    SELECT a.patient_id
    FROM appointment a
    GROUP BY a.patient_id
    HAVING COUNT(DISTINCT a.department) = (SELECT COUNT(DISTINCT department) FROM appointment)
);


----2.Retrieve the patient(s) who had their first-ever appointment with doctor 'Dr. Smith'.
select  * from appointment a
join patient p
on a.patient_id = p.patient_id
where doctor_name = 'Dr.Smith'
----3.Find the doctors who have consulted at least 3 different patients across more than one department.
SELECT doctor_name
FROM appointment
GROUP BY doctor_name
HAVING COUNT(DISTINCT patient_id) >= 3  
   AND COUNT(DISTINCT department) > 1; 


----4.Identify patients who had appointments in the last week of each month for the past 3 months.
select * from appointment a
join patient p
on a.patient_id = p.patient_id
group by 

---5.List the top 3 patients who have had the highest number of appointments
SELECT patient_id, COUNT(*) AS appointment_count
FROM appointment
GROUP BY patient_id
ORDER BY appointment_count DESC
LIMIT 3;


