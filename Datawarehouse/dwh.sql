Create Table Employee_Sal_Desc as (
Select Emp_ID,
EMP_SALARY as Basic_M_Sal,
-- EMP_SALARY * 12 as Basic_Y_Salary,
EMP_EXTRA_ALLOWANCE,
EMP_SALARY + EMP_EXTRA_ALLOWANCE as Gross_M_Salary,
EMP_EXTRA_ALLOWANCE * 12 as Year_Allowance,
((EMP_SALARY * 12)+(EMP_EXTRA_ALLOWANCE * 12)) as Gross_Y_Salary,
concat(EMP_PROFUN_PERC,'%') as ProfundPerc,
((EMP_PROFUN_PERC/100)*EMP_SALARY) as Profund_Amnt FROM dwh_2_automiczone.emp_accounts_details);

create table Emp_Desc as (
select
a.Emp_ID ,
b.EMP_DOB ,
concat(b.Emp_F_NAME,' ',b.Emp_L_NAME) as Full_Name,
c.EMP_CNIC,
a.EMP_MOTHR_NAME ,
a.EMP_FATHR_NAME ,
a.EMP_MARITAL_ST , 
a.EMP_CHILD,
d.EMP_DEPARTMENT from dwh_2_automiczone.emp_family_det a inner join dwh_2_automiczone.emp_details b on a.Emp_ID = b.Emp_ID
 inner join dwh_2_automiczone.emp_credentials c on b.Emp_ID = c.Emp_ID inner join dwh_2_automiczone.emp_dept d on c.Emp_ID= d.Emp_ID );
 
Create table Prd_Cost as ( 
Select a.SALES_PRD_CODE ,
a.PRD_COST ,
a.PRD_OPEX_COST ,
b.SALES_TRN_AMT,
SALES_TRN_AMT-(PRD_COST+PRD_OPEX_COST) as Profit
from dwh_2_automiczone.sales_prdt_cost_details a inner join dwh_2_automiczone.sales_details b on a.SALES_PRD_CODE=b.SALES_TRN_PRD_CODE
group by a.SALES_PRD_CODE);

create table Emp_Finance as (
Select a.Emp_ID,
a.EMP_FIN_START_DT,
a.EMP_FIN_RATE,
a.EMP_FINANCING_AMT,
b.EMP_FIN_PRD
from dwh_2_automiczone.emp_fin_details a inner join dwh_2_automiczone.emp_finprd_details b on a.Emp_ID=b.Emp_ID );
 
create table Sales_Desc as ( 
Select a.SALES_TRN_REF ,
a.SALES_TRN_PRD_CODE ,
a.SALES_TRN_DATE , 
a.EMP_ID,
b.PRD_IMP_MARKER,
b.SALES_PRD_DESC 
from dwh_2_automiczone.sales_details a inner join dwh_2_automiczone.sales_prdt_desc b on a.SALES_TRN_PRD_CODE = b.SALES_PRD_CODE);

Create table Emp_Log_Sheet as (
select * from dwh_2_automiczone.emp_log_sheet);

select * from dwh_3_dimzone.emp_finance;