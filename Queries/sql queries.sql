use hospital_management;

-- 1.patient registered each month

select monthname(registration_date) as month,
count(registration_date) as registered_patients
from patients group by month;


-- 2.gender distribution

select gender,count(*) as distribution from patients
group by gender;


-- 3.age group of patients

select case
when age<18 then "Adolscents(<18)"
when age<30 then "Youth(<30)"
when age<59 then "working citizen(<50)"
when age<100 then "senior citizen(<100)"
end as age_group,count(*) as num_of_patients 
from age_of_patients group by age_group;



-- 4.insurance providers

select insurance_provider,count(*) as num_of_patients 
from patients group by insurance_provider
order by insurance_provider;

-- 5. patients from same address registered

SELECT address, COUNT(*) AS num_of_patients
FROM patients
GROUP BY address;






-- 6.doctor with most appointments

select 
concat(d.first_name,' ',d.last_name) as doctor_name,
count(a.appointment_id)as appointments
from doctors d join appointments a
on d.doctor_id=a.doctor_id
group by doctor_name
order by appointments desc limit 5;

-- 7.specilization revenue

select d.specialization,sum(b.amount) as revenue
from doctors d join appointments a on d.doctor_id=a.doctor_id
join treatments t on a.appointment_id=t.appointment_id
join billing b on t.treatment_id=b.treatment_id
group by d.specialization;


-- 8.patients per doctor 


select concat(d.first_name,' ',d.last_name) as doctor_name, 
count(a.patient_id) as total_patients
from doctors d join appointments a on d.doctor_id=a.doctor_id
group by doctor_name;


-- 9.most active hospital branch

select d.hospital_branch,count(a.appointment_id) as
 num_of_appointments,sum(b.amount) as revenue from 
 doctors d join appointments a on d.doctor_id=a.doctor_id
join billing b on a.patient_id=b.patient_id
group by d.hospital_branch
order by d.hospital_branch asc;


-- 10. Experience vs patients
select d.years_of_experience,count(a.patient_id)
as num_of_patients from 
doctors d join appointments a
on d.doctor_id=a.doctor_id
group by d.years_of_experience;


-- 11.appointments vs status

select status,count(*) as 
num_of_appointments
from appointments
group by status;

-- 12.peak monthsor dates for appointments

select monthname(appointment_date) as Month,
count(appointment_id) as total_appointments
from appointments group by Month
order by total_appointments desc;

-- peak times for appointments

select time(appointment_time) as time,count(appointment_id) as total_appointments
from appointments
group by time
order by total_appointments desc;

-- peak days for appointments

select dayname(appointment_date) as day,
count(appointment_id) as total_appointments
from appointments group by day
order by total_appointments desc;

select dayofmonth(appointment_date) as date,count(appointment_id) as total_appointments
from appointments
group by date
order by total_appointments desc;

-- 13.top5 doctors with cancelled appointments

select concat(d.first_name,' ',d.last_name) as name,
count(a.appointment_id) as cancelled_appointments
from doctors d join appointments a
on d.doctor_id=a.doctor_id
where a.status ="cancelled" group by name
order by cancelled_appointments desc limit 5;

-- 14.most common reason visit reasons 

select reason_for_visit,count(*) as total_reasons
from appointments
group by reason_for_visit
order by total_reasons desc;


-- 15.Total appointments took by patient

select concat(p.first_name,' ',p.last_name) 
as patient_name, count(a.appointment_id) as 
total_appointments from patients p join appointments a
 on  p.patient_id=a.patient_id
group by patient_name
order by total_appointments desc;

-- 16.Most common treatment

select treatment_type,count(treatment_id) 
as num_of_treatments from treatments
group by treatment_type
order by num_of_treatments desc;



-- 17.avg cost per treatment_type


select treatment_type,round(avg(cost),0) 
as avg_cost from treatments
group by treatment_type;


-- 18.Revenue by treatment

select t.treatment_type,sum(b.amount) as revenue
from treatments t join billing b
on t.treatment_id=b.treatment_id
group by t.treatment_type;


-- 19.Cost variation across branches


select d.hospital_branch,t.treatment_type,max(t.cost) as
 max_cost,min(t.cost) as min_cost from 
doctors d join appointments a on d.doctor_id=a.doctor_id
join treatments t on a.appointment_id=t.appointment_id
group by d.hospital_branch,t.treatment_type;



-- 20.Treatment trend over months

select monthname(treatment_date)as month,
count(treatment_id) as total_treatments
from treatments group by month;

select dayname(treatment_date)as day,count(treatment_id) as total_treatments
from treatments
group by day;



-- 21.Total revenue per month


select monthname(bill_date) as month_name,
sum(amount) as revenue from billing
group by month_name
order by revenue desc;


-- 22.Revenue by payment method

select payment_method,sum(amount) as revenue
from billing
group by payment_method;



-- 23.pending vs paid vs failed bills

select payment_status,count(*) as 
num_of_bills,sum(amount) as total_amount
from billing
group by payment_status;


-- 24.Top billing patients

select p.patient_id,concat(p.first_name,' ',p.last_name)
 as patient_name,sum(b.amount) as total_bill from 
 patients p join billing b on p.patient_id=b.patient_id
group by p.patient_id,patient_name
order by total_bill desc limit 10;


-- 25.Doctors contributing most revenue

select d.doctor_id,concat(d.first_name,' ',d.last_name)
as doctor_name,sum(b.amount) as revenue from doctors d 
join appointments a on d.doctor_id=a.doctor_id
join treatments t on a.appointment_id=t.appointment_id
join billing b on t.treatment_id=b.treatment_id
group by d.doctor_id,doctor_name
order by revenue desc limit 10;











0	28	20:56:12	update appointments
 set appointment_date=str_to_date(appointment_date,'%Y-%M-%D')	Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column. 
 To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec