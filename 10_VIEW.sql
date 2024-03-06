/*
<view>
select문 (쿼리문)을 저장해 둘 수 있는 객체
(자주 사용하는 select문을 저장해두면 긴 select문을 매번 다시 기술 할 필요가 없다.)
임시 테이블 같은 존재 (실제 데이터가 담겨있는 건 아님 => 논리적인 테이블)
*/

-- 한국에서 근무하는 사원 사번, 이름, 부서명, 급여, 근무국가명
select emp_id, emp_name, dept_title, salary, national_name
FROM employee
join department on (dept_code = dept_id)
join location on (location_id = local_code)
join national USING (national_code)
where national_name = '한국';

-------------------------------
/*
1. view생성방법
[표현식]
create view뷰명
as 서브쿼리
*/
--!! view인지 table인지 구분이 명확히 인지해야 한다!!

--tb
--vw

create view vw_employee
as select emp_id, emp_name, dept_title, salary, national_name
    FROM employee
    join department on (dept_code = dept_id)
    join location on (location_id = local_code)
    join national USING (national_code);

grant CREATE VIEW to kh;

SELECT
    * FROM vw_employee;
    
    --실제 실행되는 것은 아래와 같이 서브쿼리로 실행된다고 볼 수 있다.
    
SELECT
    * FROM (select emp_id, emp_name, dept_title, salary, national_name
    FROM employee
    join department on (dept_code = dept_id)
    join location on (location_id = local_code)
    join national USING (national_code));
    
--한국에서 근무하는 사원 사번, 이름, 부서명, 급여, 근무국가
SELECT
    * FROM vw_employee
where national_name = '한국';

SELECT
    * FROM vw_employee
where national_name = '일본';


-----------
/*
create or replace
만들거나
*/

-----------
/*
*뷰 컬럼에 별칭부여
서브쿼리의 select절에 함수식이나 산술연산식이 기술되어있을 경우 반드시 별칭 지정
*/

CREATE or REPLACE view vw_emp_job
as select emp_id, emp_name, job_name,
        decode (substr (emp_no, 8, 1), '1', '남', '2', '여') as "성별",
        extract (year from sysdate) - extract(year from hire_date) as "근무년수"
    from employee
    JOIN job using (job_code);
    
SELECT
    * FROM vw_emp_job;    
    
CREATE or REPLACE view vw_emp_job (사번, 이름, 직급명, 성별, 근무년수)
as select emp_id, emp_name, job_name,
        decode (substr (emp_no, 8, 1), '1', '남', '2', '여'), 
        extract (year from sysdate) - extract(year from hire_date) 
    from employee
    JOIN job using (job_code);    
    
 SELECT
    * FROM vw_emp_job
 WHERE 근무년수 >= 20;
 
 drop view vw_emp_job;
 
 ------------------------
 --생성된 뷰를 통해 dml(insert, update, delete)사용가능
 --뷰를 통해 조작해서 실제 데이터가 담겨 있는 테이블에 반영
 
 CREATE or REPLACE view vw_job
 as select job_code, job_name
 from job;
 
  SELECT
    * FROM vw_job;
    
  SELECT
    * FROM job;    
    
INSERT into vw_job VALUES('J8', '인턴');


UPDATE vw_job
set job_name = '알바'
where job_code = 'J8';
--select가 너무 복잡할 까봐? 길어서?
------------
/*
*dml명령어로 조작이 불가능한 경우
1) 뷰에 정의되어있지 않은 컬럼을 조작하려고 하는 경우
2) 뷰에 정의되어있지 않은 컬럼 중에 베이스테이블 상에 not null제약조건이 지정되어 있는 경우
3) 산술연삭식 또는 함수식으로 정의가 되어있는 경우
4) 그룹함수나 group by절이 포함된 경우
5) distinct구문이 포함된 경우
6) join을 이용해서 여러테이블을 연결

대부분 뷰는 조회를 목적임!!
그냥 뷰를 통해 dml은 안쓰는 것을 지향
Data Manipulation Language
데이터를 조작하는 명령어
*/
/*
view옵션

[상세표현]
create [or replace] [force | noforce] view 뷰명
as 서브쿼리
[with check option]
[with read only];

1) or replace : 기존에 동일한 뷰가 있을 경우 갱신, 존재하지 않을 경우 생성
2) force | noforce
    > force : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되도록
    > noforce : 서브쿼리에 기술된 테이블이 존재하는 테이블이여야 만 뷰가 생성
3) with check option : dml시 서브쿼리에 기술된 조건에 부합한 값으로만 dml이 가능하도록
4) with read only : 뷰에 대해서 조회 만 가능하도록
*/
--2)force | noforce
 
 CREATE or REPLACE NOFORCE view vw_emp
 as select Tcode, Tname, Tcontent
 from TT;

 
 --서브쿼리에 기술 된 테이블이 존재하지 않아도 뷰가 우선은 생기게 된다
  CREATE or REPLACE FORCE view vw_emp
 as select Tcode, Tname, Tcontent
 from TT;
 
SELECT
    * FROM vw_emp;
/*    
CREATE 
 from TT;    
    
SELECT
    * FROM vw_emp;    
 
 */--수정필
 
 --3) with check option : 서브쿼리에 기술된 조건에 부합하지 않는 값으로 수정 시 오류 발생
 CREATE or REPLACE view vw_emp
 as select *
    FROM employee
    where salary
    >= 3000000;
 
 SELECT
    * FROM vw_emp;   
    
    --200번사원 급여 200만으로 변경
UPDATE vw_emp
set salary = 2000000
where emp_id = 200;

ROLLBACK;

--4) with read only : 뷰에 대해 조회 만 가능하도록
create or REPLACE view vw_emp
as SELECT emp_id, emp_name, bonus
    from employee
    where bonus is not null
    WITH read only;
   
 SELECT
    * FROM vw_emp;   
    
delete
from vw_emp
where emp_id = 200;