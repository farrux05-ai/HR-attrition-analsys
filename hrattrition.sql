use testdb;
select * from hr_empa;
-- 1. Attrition (Ishdan ketish) asosiy insightlari
-- Ishdan ketayotganlar (Attrition = Yes) necha foiz?
 select 
 count(Attrition) as total_empolyees,
 sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_employees,
    round( 
    100  * sum(case when Attrition = 'Yes' then 1 else 0 end) / count(*), 2
    ) as percentage
    from hr_empa;
-- Attrition bilan bog‘liq eng kuchli omillar:
-- OverTime (ortiqcha ishlash → ko‘p ketishadimi?)
 select 
 count(Attrition) as total_empolyees,
 sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_employees,
 sum(case when OverTime = 'Yes' then 1 else 0 end) as overtime_employees,
 sum(case when OverTime = 'Yes' and Attrition = 'Yes' then 1 else 0 end) as overtime_plusattrition,
    round( 
    100  * sum(case when Attrition = 'Yes' then 1 else 0 end) / count(*), 2
    ) as percentage,
      -- attrition % among overtime employees
    ROUND(
        100.0 * SUM(CASE WHEN OverTime = 'Yes' AND Attrition = 'Yes' THEN 1 ELSE 0 END) 
        / NULLIF(SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END), 0),
        2
    ) AS overtime_attrition_percentage
    from hr_empa;


-- JobSatisfaction (qoniqish past bo‘lsa ketish ko‘p bo‘ladimi?)
select JobSatisfaction,
count(*) as total,
sum(case when Attrition = 'Yes' then 1 else 0 end) as attriton,
round(
100 * sum(case when Attrition = 'Yes' then 1 else 0 end) / count(*), 2
) as attritionpercentage
from hr_empa
group by JobSatisfaction
order by JobSatisfaction;

-- MonthlyIncome (past maosh ketishga sababmi?)
select avg(MonthlyIncome), min(MonthlyIncome), max(MonthlyIncome)
from hr_empa;
select
	case 
		when MonthlyIncome < 3000 then 'low'
        when MonthlyIncome between 3000 and 6000 then 'Medium'
        else 'High' 
        end as salary,
        JobSatisfaction,
        COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_percentage
	from hr_empa
    group by 
    case 
		when MonthlyIncome < 3000 then 'low'
        when MonthlyIncome between 3000 and 6000 then 'Medium'
        else 'High' end, JobSatisfaction
    ;
    

-- YearsAtCompany (yangi kelganlar ko‘proq ketadimi?)
select 
	case 
		 when YearsAtCompany between 0 and 1 then '0-1 years'
         when YearsAtCompany between 2 and 5 then '2-5 years'
         when YearsAtCompany between 6 and 10 then '6-10 years'
         else '10 + years' end as tanureband,
count(*) as total,
sum(case when Attrition  = 'Yes' then 1 else 0 end) as attrition,
round(
100 * sum(case when Attrition  = 'Yes' then 1 else 0 end) / count(*), 2 ) as attritionpercentage
from hr_empa
group by
case 
		 when YearsAtCompany between 0 and 1 then '0-1 years'
         when YearsAtCompany between 2 and 5 then '2-5 years'
         when YearsAtCompany between 6 and 10 then '6-10 years'
         else '10 + years' end
         order by  tanureband asc;

-- BusinessTravel (ko‘p safar qiladiganlar ketadimi?)
select * from hr_empa;
select Attrition, BusinessTravel
FROM hr_empa
group by Attrition, BusinessTravel;


select count(*) as total, BusinessTravel,
sum(case when Attrition = 'Yes' then 1 else 0 end) as attritionemp,
round(
100.0 * sum(case when Attrition = 'Yes' then 1 else 0 end) / count(*), 2 
) as percentageattrition
from hr_empa
group by BusinessTravel;

-- WorkLifeBalance (muvozanat yo‘q bo‘lsa ketish ko‘p bo‘ladimi?)
select distinct WorkLifeBalance from hr_empa;
select count(*) as totaL, WorkLifeBalance, 
sum(case when Attrition  = 'Yes' then 1 else 0 end) as attrition,
round(
100.0 * sum(case when Attrition  = 'Yes' then 1 else 0 end)/ count(*), 2)  as percentageattr
from hr_empa
group by WorkLifeBalance
order by WorkLifeBalance asc;

-- 2. Demografik insightlar
select min(Age), max(Age), avg(Age) from hr_empa;
select 
	case 
			when Age between 18 and 25 then '18-25 years old'
            when Age between 26 and 30 then '26-30 years old'
            when Age between 31 and 40 then '31-40 years old'
            when Age between 40 and 50 then '40-50 years old'
            when Age between 50 and 60 then '50-60 years old'
            else '60 + years' end as agecategory,
sum(case when Attrition = 'Yes' then 1 else 0 end) as attritionemp,
round(
100.0 * sum(case when Attrition = 'Yes' then 1 else 0 end) / count(*), 2 
) as percentageattrition
from hr_empa
group by case
			when Age between 18 and 25 then '18-25 years old'
            when Age between 26 and 30 then '26-30 years old'
            when Age between 31 and 40 then '31-40 years old'
            when Age between 40 and 50 then '40-50 years old'
            when Age between 50 and 60 then '50-60 years old'
                        else '60 + years' end
                        order by agecategory asc;

 -- Yosh bo‘yicha ketishlar (20–30 yoshdagilar ko‘proq ketadimi?).

 -- Gender va Attrition (ayollar/erkaklar orasida farq bormi?).
 select Gender, 
	sum(case when Attrition  = 'Yes' then 1 else 0 end) as attrrition
from hr_empa
group by Gender;

-- MaritalStatus (uylangan/bo‘ydoqlarda ketish foizi qanday?).
select distinct MaritalStatus from hr_empa;

select  MaritalStatus,
	sum(case when Attrition  = 'Yes' then 1 else 0 end) as totalattrtion,
    round(
    100.0 * sum(case when Attrition  = 'Yes' then 1 else 0 end)/ count(*), 2) as percentageatrrition
from hr_empa
group by MaritalStatus;
-- 3. Moliyaviy insightlar
-- MonthlyIncome va Attrition bog‘liqligi.
-- StockOptionLevel (aktsiya opsiyalari → odamni ushlab qoladimi?).
select distinct  StockOptionLevel from hr_empa;
select StockOptionLevel,
	sum(case when Attrition	= 'Yes' then 1 else 0 end) as numattrition
from hr_empa
group by StockOptionLevel
order by numattrition;

-- PercentSalaryHike (maosh oshirilsa ketish kamayadimi?).
with salaryband as (
select
	case
		when PercentSalaryHike between 11 and 15 then '11-15 percent'
        when PercentSalaryHike between 16 and 20 then '16-20 percent'
        when PercentSalaryHike between 21 and 25 then '21-25 percent'
        else '25%+'
        end as salaryhikerange,
        Attrition
from hr_empa
)
select salaryhikerange,
count(*) as total_employees,
    sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_employees,
    round(100.0 * sum(case when Attrition = 'Yes' then 1 else 0 end) / count(*), 2) as attrition_percentage
from salaryband
group by salaryhikerange
order by salaryhikerange;
-- 4. Career & Development insightlar
-- JobRole bo‘yicha Attrition (qaysi lavozimda eng ko‘p ketish?).

select Department, count(Attrition) as sumattrition,
	sum( case when Gender  = 'Male' then 1 else 0 end) as male,
    sum( case when Gender   = 'Female' then 1 else 0 end) as female
from hr_empa
where Attrition = 'Yes'
group by Department
order by count(Attrition) desc;

select JobRole, count(Attrition) as sumattrition,
	sum( case when Gender  = 'Male' then 1 else 0 end) as male,
    sum( case when Gender   = 'Female' then 1 else 0 end) as female
from hr_empa
where Attrition = 'Yes'
group by JobRole
order by count(Attrition) desc;

-- EducationField (qaysi soha vakillari ko‘proq ketadi?).
select EducationField, count(Attrition) as sumattrition,
	sum( case when Gender  = 'Male' then 1 else 0 end) as male,
    sum( case when Gender   = 'Female' then 1 else 0 end) as female
from hr_empa
where Attrition = 'Yes'
group by EducationField
order by count(Attrition) desc;
-- TrainingTimesLastYear (ko‘proq trening olganlar ushlanib qoladimi?).
select distinct TrainingTimesLastYear from hr_empa;
select TrainingTimesLastYear, count(Attrition) as sumattrition,
	sum( case when Gender  = 'Male' then 1 else 0 end) as male,
    sum( case when Gender   = 'Female' then 1 else 0 end) as female
from hr_empa
where Attrition = 'Yes'
group by TrainingTimesLastYear
order by TrainingTimesLastYear asc, count(Attrition) desc;
-- 5. Time-based insightlar
desc hr_empa;
alter table hr_empa
modify YearsSinceLastPromotion int;
alter table hr_empa
modify YearsWithCurrManager int;
-- YearsSinceLastPromotion (ko‘pdan beri ko‘tarilmaganlar ko‘proq ketadimi?)
select distinct YearsSinceLastPromotion from hr_empa;
select YearsSinceLastPromotion, count(*) as total_employee
from hr_empa
group by YearsSinceLastPromotion 
order by YearsSinceLastPromotion asc;

select YearsSinceLastPromotion, 
count(*) as total_employee,
sum(case when Attrition = 'Yes' then 1 else 0 end ) as total_attrition,
round(
100 * sum(case when Attrition = 'Yes' then 1 else 0 end ) / count(*), 2 )
as percentage_attrition
from hr_empa
group by YearsSinceLastPromotion 
order by YearsSinceLastPromotion asc;
-- YearsWithCurrManager (rahbar bilan ishlash va ketish bog‘liqligi).
select YearsWithCurrManager, count(*) as total_employee
from hr_empa
group by YearsWithCurrManager
order by YearsWithCurrManager asc;

select YearsWithCurrManager, 
count(*) as total_employee,
sum(case when Attrition = 'Yes' then 1 else 0 end ) as total_attrition,
round(
100 * sum(case when Attrition = 'Yes' then 1 else 0 end ) / count(*), 2 )
as percentage_attrition
from hr_empa
group by YearsWithCurrManager
order by YearsWithCurrManager asc;

-- 👉 Bu datasetdan asosiy business savol:
-- “Qaysi omillar xodimlarning ishdan ketishini ko‘proq ta’sir qiladi va kompaniya qanday choralar ko‘rsa ularni ushlab qolishi mumkin?”


