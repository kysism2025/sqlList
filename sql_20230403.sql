use hr;

-- 모든 사원의 소속 부서 평균연봉을 계산하여 사원별로 성과 이름, 업무, 급여 부서번호,부서 평균연봉
select * from employees;

select  
	e1.employee_id,
	concat(e1.first_name, ' ', e1.last_name) name,
    e1.job_id,
    j.job_title,
    e1.department_id,
    d.department_name,
    format(round(e1.salary,0),0),
    format(round(e2.year_salary,0),0) 'Department Avg Salary'
from employees e1
left join 
(
	select 
		department_id, 
        avg(salary) *12 year_salary
	from employees
	where department_id is not null
	group by department_id
) e2
on e1.department_id = e2.department_id
join departments d
on e1.department_id = d.department_id
join jobs j
on e1.job_id = j.job_id
where e1.department_id is not null
order by e1.department_id ;

-- employees, job_history 테이블을 이용하여 모든 사원의 현재 및 이전의 업무 이력조회
-- 중복된 사원정보가 있을경우 한번만 표시
select
	e.employee_id,
	e.job_id cur_job_id,  
	ifnull((
				select 
					h2.job_id 
                from job_history h2 
                where h2.start_date = min_date 
                and e.job_id = h2.job_id
			), e.job_id) old_job_id
from employees e 
left join 
(
	select 
		employee_id, 
        min(start_date) min_date
    from job_history
    group by employee_id
) h
on e.employee_id = h.employee_id
;


select * from employees;

select 
*
from
(
	select employee_id, job_id, hire_date
	from employees
	union
	select employee_id, job_id, ''  hire_date
	from job_history
) a;

select 
count(*)
from
(
	select employee_id, job_id
	from employees
	union all
	select employee_id, job_id
	from job_history
) b;


select employee_id, count(*) 
from job_history
group by employee_id
having count(*) >= 2;

select * from job_history
where employee_id = 101;

select * from employees
where employee_id = 200;

select 
	e.employee_id, 
    h.job_id
from
(
    select 
		employee_id, 
        job_id
	from employees
) e,
(
	select 
		employee_id, 
        job_id
	from job_history
) h
where e.employee_id = h.employee_id
and e.job_id = h.job_id;

-- 위 결과를 이용하여 출력된 176번 사원의 업무 이력의 변경날짜 이력을 조회
select *
from job_history
where employee_id = 176;

select 
count(*)
from
(
	select employee_id, job_id, hire_date
	from employees
	union
	select employee_id, job_id, ''  hire_date
	from job_history
) a
;

select 
count(*)
from
(
	select employee_id, job_id
	from employees
	union
	select employee_id, job_id
	from job_history
) b
;

-- 우리 회사는 1년에 한번 업무를 변경하여 전체적인 회사업무를 사원들이 익히도록하는
-- role change 정책을 시행하고 있다. 이번 인사이동때 아직 업무가 변경된 적이 없는
-- 사원들을 적합한 업무로 이동시키려고 한다.
-- HR 스키마의 사원정보 테이블과 업무이력 정보 테이블을 이용하여 한번도 업무가 변경되지 않은 
-- 사원의 사번을 조회

select
	employee_id
from employees 
where employee_id not in 
(
	select 
		employee_id
    from job_history
    group by employee_id
    having count(*) >= 2
) 
order by employee_id asc;

-- 신규 프로젝트 성공으로 해당하는 각 업무 자들에 대한 급여 인상안을 결정하고
-- 다음과 같이 업무별 급여 인상에 대해 적용하고자 한다. 현재 107명의 사원은 
-- 19개 업무에 소속되어 근무중이다. 이 중 5개의 업무 자들에 대한 급여인상이
-- 결정되었고 나머지 업무에 대해서는 인상이 돌결되었다.
-- HR_REP 10%, MK_REP 12%, PR_REP 15%, SA_REP 18%, IT_PROG 20%

select 
	case 
		when job_id = 'HR_REP' then salary * 1.1
		when job_id = 'MK_REP' then salary * 1.12
		when job_id = 'PR_REP' then salary * 1.15
		when job_id = 'SA_REP' then salary * 1.18
		when job_id = 'IT_PROG' then salary * 1.2
        else salary
	end up_salary    
from employees
where salary is not null;


-- 2001년부터 2003년까지 입사자들의 급여를 각각 5%, 3%, 1% 인상하여 지분에 따른 배당금으로
-- 지급하고자한다. 전체 사원들 중 해당 년도에 해당하는 사원들의 급여를 검색하여 적용하고
-- 입사일자에 따른 오름차순 정렬

select 
    employee_id,
	concat(first_name, ' ', last_name) name,
    job_id,
    salary,
    YEAR(hire_date) hire_year,
	case 
		when YEAR(hire_date) = 2001 then salary * 1.05
		when YEAR(hire_date) = 2002 then salary * 1.03
        when YEAR(hire_date) = 2003 then salary * 1.01
        else salary
	end up_salary    
from employees
-- where  YEAR(hire_date) in ('2001','2002','2003')
order by hire_date asc;


select 
	case
		when sum(salary) > 50000 then "Good"
        when sum(salary) > 50000 then "Good"
        when sum(salary) > 50000 then "Good"
	end  up_salary
from   employees
group by department_id
;
  
-- 1995년 이전에 입사한 사원 중 업무에 "mgr"이 포함된 사원은 15% 급여를 인상하고
-- "man"이 포함된 사원은 20% 급여 인상이 정해졌고 또한 1995년부터 근무를 시작한
-- 사원 중 "mgr"이 포함된 사원은 25% 급여 인상을 수행하는 쿼리 작성

select 
    employee_id,
	concat(first_name, ' ', last_name) name,
    job_id,
    salary,
    YEAR(hire_date) hire_year,
	case 
		when instr(job_id, 'MGR') > 0 and year(hire_date) < 1995 then salary * 1.15
        when instr(job_id, 'MAN') > 0 and year(hire_date) < 1995 then salary * 1.2
        when instr(job_id, 'MGR') > 0 and year(hire_date) >= 1995 then salary * 1.25
        else salary
	end up_salary
from employees;

select date_format(hire_date, '%m') from employees;

select 
  e.department_id,
  d.department_name,
  sum(
	  case 
		  when date_format(hire_date, '%m') = '01' then 1
		  else 0
	   end 
   ) '1월',
   sum(
	  case 
		  when date_format(hire_date, '%m') = '02' then 1
		  else 0
	   end 
   ) '2월',
   sum(
	  case 
		  when date_format(hire_date, '%m') = '03' then 1
		  else 0
	   end 
   ) '3월' ,
   sum(
	  case 
		  when date_format(hire_date, '%m') = '04' then 1
		  else 0
	   end 
   ) '4월',  
   sum(
	  case 
		  when date_format(hire_date, '%m') = '05' then 1
		  else 0
	   end 
   ) '5월',  
   sum(
	  case 
		  when date_format(hire_date, '%m') = '06' then 1
		  else 0
	   end 
   ) '6월' , 
   sum(
	  case 
		  when date_format(hire_date, '%m') = '07' then 1
		  else 0
	   end 
   ) '7월' , 
   sum(
	  case 
		  when date_format(hire_date, '%m') = '08' then 1
		  else 0
	   end 
   ) '8월' , 
   sum(
	  case 
		  when date_format(hire_date, '%m') = '09' then 1
		  else 0
	   end 
   ) '9월' ,
   sum(
	  case 
		  when date_format(hire_date, '%m') = '10' then 1
		  else 0
	   end 
   ) '10월'  ,
   sum(
	  case 
		  when date_format(hire_date, '%m') = '11' then 1
		  else 0
	   end 
   ) '11월'  ,
   sum(
	  case 
		  when date_format(hire_date, '%m') = '12' then 1
		  else 0
	   end 
   ) '12월'
from employees e
left join departments d
on e.department_id = d.department_id
where e.department_id is not null
group by e.department_id
order by e.department_id
;




 




   
    
