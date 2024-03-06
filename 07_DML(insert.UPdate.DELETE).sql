/*
DQL(QUWRY 데이터 정의어) : SELECT
DML (MAINPULATION 데이터 조작어) : insert, update, delete
DDl (DEFINITION 데이터 정의): CRTATE, ALTER, DROP
DCL (CONTROL 데이터 제어) : GRANT, REVOKE
TCL (TRANSACTION 트랜잭션 제어): COMMIT, ROLLBACK

<DML> 데이터 조작 언어
테이블 값을 삽입 <insert>하거나, 수정<update>하거나 삭제<delete>하는 구문
*/

-- crud 4가지가 가장 중요

/*
1. insert
테이블에 새로운 행을 추가하는 구문
[표현식]
1) insert into 테이블명 values(값,값,값..)
테이블의 모든 컬럼에 대한 값을 직접 제시해서 한 행을 insert하고자 할 떄
컬럼의 순번을 지켜서 values에 값을 나열해야 함

부족하게 값을 제시할 경우  -> not enough values오류
값을 더 많이 제시할 경우 -> too many values
*/

 select * from employee;
 insert into employee
 values (900, '이소근', '880914-1456789', 'SG8809@naver.com', 01075966990',
        'D7', 'J5', '4000000, 0.2, 200, SYSDATE, NULL, 'N');
        
        /*
**반드시 알아야함** 2) insert into 테이블 명 (컬럼, 컬럼, 컬럼) values (값, 값, 값)
        테이블에 내가 선택한 컬럼에 대한 값만 insert 할 때 사용
        그래도 한 행 단위 추가, 선택 한 된 컬럼 기본적으로 null이 들어감
        =>
        
        */
        
insert into employee (emp_id, emp_name, emp_no, job_code, hire_date)
values (901, '최지원', '440701-1234567', 'J7', sysdate); 

select*from employee;

insert
    into employee
    ( emp_id,
     emp_name,
     emp_no,
     job_code,
     hire_date)
values
    (902,
    '김개똥',
    '870105-224510',
    'J7',
    sysdate
);
---------------------------------------------------------------
/*
3) insert into 테이블명 (서브쿼리);
values로 값을 직접 명시하는 것 대신
서브쿼리로 조회 된 결과값을 통채로 insert가능
*/
---------------
--테이블 새로 만들기
create table emp_01(
    emp_id number,
    emp_name varchar2(20),
    dept_title varchar2(20)
    );
    
select * from emp_01;
insert into emp_01 (select emp_id, emp_name, dept_title
                    from employee
                    left join department on (dept_code = dept_id));

--------------------------------

/*
2. insert all
두 개 이상의 테이블에 각각 insert할 때
이 때 사용되는 서브쿼리가 동일할 경우
*/
CREATE TABLE emp_dept
as (select emp_id, emp_name, dept_code, hire_date
        from employee
        where 1=0);

CREATE TABLE emp_manager
as (select emp_id, emp_name, manager_id
    from employee
    where 1=0);
    
--부서코드가 D1인 사원들 사번, 이름 ,부서코드, 입사일, 사수사번
select emp_id, emp_name, dept_code, hire_date, manager_id
from employee
where dept_code = 'D1';
/*
[표현식]
insert all
into 테이블명1 values(컬럼, 컬럼, 컬럼...)
into 테이블명2 values(컬럼, 컬럼..)
서브쿼리;
*/

insert all
    into emp_dept values (emp_id, emp_name, dept_code, hire_date)
    into emp_manager values (emp_id, emp_name, manager_id)
        (select emp_id, emp_name, dept_code, hire_date, manager_id
        from employee
        where dept_code = 'D1');
        
SELECT
    * FROM
    emp_dept;
    
select * from emp_manager;
-------------------------------------------------
/*
    3. update 
    테이블에 기록되어 있는 기존의 데이터를 수정하는 구문
    [표현법]
    update 테이블명
    set 컬럼 = 값,
        컬럼 = 값,
        ... --and로 연결이 아닌, 그냥','로 연결한다.
[where 조건] --> 생략시 전체 모든 행의 데이터가 변경
*없데이트 시에도 제약조건 잘 확인해야 한다.
*/

create table dept_table
as (select * from department);

select*from dept_table; 
-- d9 부서의 부서명을 '전략기획팀'으로 변경
update dept_table
set dept_title = '전략기획팀'
where dept_id = 'D9';

create table emp_salary
as (select emp_id, emp_name, dept_code, salary, bonus
    from employee);

-- emp_salary 테이블에서 변경
-- 노옹철 사원의 급여를 100만원으로 변경
update emp_salary
set salary = 1000000
where emp_name = '노옹철';

select*from emp_salary
where emp_name = '노옹철';
-- 선동일 사원의 급여를 700만원으로 보너스 0.2
update emp_salary
set salary = 7000000,
    bonus = 0.2
where emp_name = '선동일';    

-- 전체사원의 급여를 기존 급여에 10% 인상된 금액으로

update emp_salary
set salary = salary * 101;
  
SELECT
    * FROM emp_salary;
    
/*
update 테이블명
set 컬럼명 = (서브쿼리)
where 조건
*/
--방명수 사원의 급여와 보너스 값을 유재식 사원의 급여와 보너스 값으로 변경
update emp_salary
set salary = (select salary
                from emp_salary
                where emp_name = '유재식')
     bonus = (select bonus
                from emp_salary
                where emp_name = '유재식')
where emp_name = '방명수';                

SELECT
    * FROM emp_salary
where emp_name = '방명수' or emp_name = '유재식';    

--다중열
update emp_salary
    set (salary, bonus) = (select salary, bonus
                from emp_salary
                where emp_name = '유재식')
where emp_name = '방명수';          

--asia 지역에 근무하는 사원들의 보너스 값을 0.3으로 변경
/*update emp_salary
    set (salary, bonus ) = (select salary, bonus *0.3
                from emp_salary
                where asia1, asia2, asia3 )
where local_name = asia1, asia2, asia3 ; */

--asia 지역
select emp_id, emp_name
from emp_salary
join department on (dept_code = dept_id)
join location on (location_id= local_code)
where local_name like 'ASIA%';


--해당 사원들 보너스 값 0.3
update emp_salary
set bonus = 0.3
where emp_id in (select emp_id
                    from emp_salary
                    join department on (dept_code = dept_id
                    join location on (location_id = local_code)
                    where local_name like 'ASIA&');
                    
COMMIT;
------------
/*
4. delete
테이블에 기록된 데이터를 삭제하는 구문( 한 행 단위로 삭제가 된다)

[표현식]
delete from 테이블명
[where 조건]--> where 절 제시 안하면 전체 행 삭제됨


*/

delete from employee;

SELECT
    * FROM employee;
    rollback;
    
    delete from employee
    where emp_name = '이소근';
 
 delete from employee
    where emp_id = '901';    
    
    commit;
    
DELETE FROM department
where dept_id = 'D1';
--D1의 값을 가져다 쓰는 자식데이터가 있기 때문에 삭제가 되지 않는다.

