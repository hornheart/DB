/*
 <SELECT>
 SELECT 가지고 오고 싶은 정보 FORM table;
 SELECT (*)또는 컬럼1, 컬럼2... FORM 테이블;
 */
 
  -- 모든 사원의 정보를 보여줘
  SELECT
      * FROM employee;
      
      -- 모든 사원의 이름, 주민번호, 핸드폰번호를 알고 싶어 
      SELECT EMP_NAME, EMP_NO, PHONE
          FROM EMPLOYEE;
          
------실습---------------
--JOB테이블 직급명 컬럼 만 조회
-- DEPARTMENT 테이블의 모든 컬럼 조회
-- DEPARTMENT 테이블의 부서코드, 부서명 조회
-- EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여조회

--SELECT JOB_NAME FROM job ;
--SELECT * FROM department;
--SELECT dept_id,dept_title FROM department;
--SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE,SALARY FROM EMPLOYEE; 

--<colum값을 통한 산술연산>
--SELECT절 컬럼명 작성부분에 산술연산을 할 수 있다.
--EMPOYEE테이블의 사원명, 사원의 연봉(SALARY * 12)을 조회

SELECT EMP_NAME, SALARY *12 FROM employee;

-- EMPLOYEE테이블의 사원명, 급여, 보너스, 연봉, 보너스 포함 연봉을 조회
--(급여 + (급여*보너스))*12
 SELECT EMP_NAME, SALARY, BONUS,SALARY*12, (SALARY+(salary*BONUS))*12 FROM employee;

--산술연산 과정 中 NULL데이터가 포함되어 있다면, 무조건 결과값은 NULL 
--(null = 값의 존재가 없어 0과는 다르나, 계산을 할 수 없음을 의미한다)

-- 사원명, 입사일, 근무일수를 조회
-- (현재시간) - (입사일) = (근무한 시간)
-- DATE - DATE => 결과값이 무조건 일로 표시된다.
-- 코드실행시 날짜를 표시해주는 상수 : SYSDATE[년/월/일/시/분/초]

SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE FROM employee;
--<별칭>지정도 가능

SELECT SYSDATE FROM DUAL; 
--**오라클의 빈 테이블=DUAL
--더블 클릭시, 값 보기를 통해 시간 테이블을 볼 수 있다.
-- DUAL : 오라클에서 제공하는 가상데이터 (더미데이터)

/*
<컬럼명에 별칭 지정하기>
산술연산을 하게 된다면, 
컬럼명이 지저분해진다.
이 때에 컬럼명을 별칭을 통해 
깔끔하게 새로 부여할 수 있다.
[표현법]
컬럼명 별칭 / 컬럼명 as 별칭 / 컬럼명 "별칭" / 컬럼명 as "별칭"
*/

SELECT EMP_NAME JEE FROM employee;
--컬럼명 별칭(=초록색, 'JEE')
SELECT EMP_NAME 사원명, SALARY AS 급여, BONUS "보너스", (SALARY*12)AS"연봉(원)",
(SALARY+(SALARY*BONUS))*12AS"총 소득" FROM employee;

/*
<리터럴>
임의로 지정한 문자열 (' ')
조회된 (RESULT SET=)결과의 모든 행에 반복적 출력 
*/

-- EMPLOYEE테이블의 사번, 사원명, 급여

SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위" 
FROM employee;


/*
<연결연산자 = ||>
여러 컬럼값들을 마치 하나의 컬럼 처럼 연결 할 수 있다.
*/
--사번, 이름, 급여를 하나의 컬럼으로 조회가능
SELECT EMP_ID || EMP_NAME || SALARY FROM employee;

-- EMPLOYEE테이블에서 모든 사원의 월급을 조회한다.
-- 다음과 같이 결과가 나오도록 출력하라
-- '00'의 월급은 '00'원입니다.

SELECT EMP_NAME || '의 월급은' || SALARY || '원입니다.' AS"급여"
FROM employee;


/*
<DISTINCT>
중복제거 - 컬럼에 표시된 값들을 한번씩 만 조회하고 싶을때 사용
*/

-- EMPLOYEE 직급코드 조회
SELECT DISTINCT JOB_CODE FROM employee;

-- employee부서코드를 조회(중복제거)
SELECT DISTINCT dept_code FROM employee;

--SELECT DISTINCT job_code, distinct dept_code
-- 위 처럼 사용하면 에러 발생 distinct는 한번 만 사용

SELECT DISTINCT job_code, dept_code
-- 위 처럼 사용시에는 (job_code, dept_code)묶어서 쌍으로 묶어 중복을 제거한 값을 보여준다.
FROM employee;

--==============================================================================
/*
<WHERE절>
조회하고자 하는 테이블로 부터 특정 조건에 만족하는 데이터 만을 조회할 때 사용한다.
조건식에서도 다양한 연산자 사용이 가능하다
[표현법]
(*조건 만으로 사용할 수 없다*)
select 컬럼, 컬럼, 컬럼연산
from 테이블
where 조건;
/*
>>비교연산자<<
>,<,>=,<= ===> 대소비교
=(동등비교)===> 양쪽이 같다
!=, ^=, <>, ===> 양쪽이 다르다
 */
 
-- employee에서 부서 코드가 'd9'인 사원들 만 조회( 모든컬럼)
select * from employee where dept_code = 'D9';
-- 문법 만 대/소문자 구분을 안한다!!! (=명령어) 'D9'(=데이터)
-- 반드시!!! ***대/소문자 확인 후*** 기입이 必

-- employee에서 부서 코드가 'D1'인 사원들의 사원명, 급여, 부서코드 조회
--(my)select * from employee where dept_code = 'D1'; 
SELECT emp_name, salary, dept_code from employee 
where dept_code != 'D1';

-- 월급이 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT emp_name, dept_code, salary
from employee
where salary >= 4000000;

-------------------------실습---------------------------------------
--1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(별칭-> 연봉) 조회
select emp_name, salary, hire_date, salary*12 연봉
from employee
where salary >= 3000000; 

--2. 연봉이 5천만원 이상인 사원들의 사원명, 급여, 연봉(별칭-> 연봉), 부서코드 조회
select emp_name, salary, salary*12 연봉, dept_code
from employee
where salary *12 >= 50000000;
-- where 연봉 >=50000000; -> 에러가 발생
-- 이유 : 실행순서가 from -> where -> select
-- where조건에 대한 부분이기 때문에 조건문 만 올 수 있다

--3. 직급코드가  'J3'가 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
select emp_id, emp_name, job_code, ent_yn
from employee
where job_code != 'J3';

--4. 급여가 350만원 이상 600만원 이하 인 모든 사원의 사원명, 사번, 급여조회
select emp_name, emp_id, salary
FROM employee
where  salary >= 3500000 AND salary <= 6000000;
--중간에 and, or로 조건을 연결할 수 있다.



/*

<and, or 연산자>

조건을 여러개 연결할 때 사용
[표현법]
(조건 A) and (조건 b) -> 조건 a와 조건 b 모두 만족하는 값 만 가지고 온다.
(조건 A) or (조건 b) ->  조건 a와 조건 b 중 하나라도 만족하는 값은 가지고 온다.

[표현법] 
비교 대상 컬럼 between 하안값 and 상한값
*/
-- 급여가 350만 이상 600만 이하인 사원명, 사번, 급여
select emp_name, emp_id, salary
from employee
--where salary >= 3500000 and salary <=6000000
 where salary between 3500000 and 6000000;
 */
 --급여가 350만 미만 600만 초과 사원명, 사번, 급여
select emp_name, emp_id, salary
from employee
where salary < 3500000 or salary > 6000000;
-- where not salary between 3500000 and 6000000;
-- not : 논리 부정 연산자
-- 컬럼명 앞 또는 beetween 앞에 선언 가능

-- 입사일이 '90/01/01' ~ '01/01/01' 사원을 전체 조회
select *
from empliyee
where hire_date >= '90/01/01' and hire_date <='01/01/01';
-- date타입도 비교연산이 가능
--where hire_date between '90/01/01' and '01/01/01';
--=========================

/* 
<like>
비교하고자 하는 컬럼 값이 제시한 특정 패턴에 만족 할 경우에 조회

[표현법]
비교할 대상 컬럼 like '특정패턴';

특정 패턴을 제시할 때 와일드카드라는 특정패턴이 정의되어있다.
'%' : 포함 문자 검색 (0글자이상 전부 조회)
ex) 비교 할 대상 컬럼 값 like '문자%' : 비교대상컬럼값 중에서 해당 문자로 시작하는 값들 만 조회
    비교 할 대상 컬럼 like '%문자' : 비교대상컬럼값 중에서 해당 문자로 끝나는 값들 만 조회
    비교 할 대상 컬럼 like '%문자%' : 비교대상컬럼값 중에서 해당 문자로 포함된 값 조회
'_' : 1글자를 대체하는 검색
예 ) 비교할 대상 컬럼 like '___문자' : 비교대상 컬럼 값 문자 앞에 아무 글자나 n글자('_'만큼)가 있는 값을 조회
     비교할 대상 컬럼 like '문자_' : 비교대상 컬럼 값 문자 뒤에 아무 글자나 n글자('_'만큼)가 있는 값을 조회
     비교할 대상 컬럼 like '_문자_' : 비교대상 컬럼 값 문자 앞/뒤에 아무 글자나 n글자('_'만큼)가 있는 값을 조회


*/

-- 사원들 중 성이 '전'씨인 사원들의 사원명, 급여, 입사일
select emp_name, salary, hire_date
from employee
where emp_name like '전%';

-- 사원들 중 성이 '하'라는 글자가 포함 된 사원들의 사원명, 전화번호 목록
select emp_name, phone
from employee
where emp_name like '%하%';

--사원들 중에서 이름에 중간 글자가 '하'인 사원이름, 전화번호 조회시
select emp_name, phone
from employee
where emp_name like '_하_';

-- 전화번호의 3번째 번호가 1인 사원의 사번, 사원명, 전화번호
select emp_id, emp_name, phone
from employee
where phone like '__1%';

--***!!!주의!!!***
-- 이메일 中 _앞글자가 3글자 인 사원의 사번, 이름, 이메일
select emp_id, emp_name, email
from employee
-- where email like '___%'; ==> 와일드카드('%','_')문자 때문에 정상출력 불가
-- 와일드카드 문자와 일반문자의 구분이 必
-- 데이터 값을 취급하고 싶은 와일드카드 문자 앞에 나만의 탈출문자를 제시
-- escape option을 등록해서 사용 (** '%'나 '$' 등 어떤 문자도 가능함**)
where email like '___\_%' escape '\';
-- 위 사원들이 아닌 이외의 사원들 조회시
select emp_id, emp_name, email
from employee
where not email like '___\_%' escape '\';   

--==================실습
-- 1. 이름이 '연'으로 끝나는 사원명, 입사일
select emp_name, hire_date
from employee
where emp_name like '__연';

-- 2. 전화번호 앞 3자리 010이 아닌 사원명, 전화번호
select emp_name, phone
from employee
where not phone like '010%';

-- 3. 이름에 '하'가 포함되어 급여가 240 이상인 사원명, 급여
select emp_name, salary 
from employee
where emp_name like '%하%' and salary >= 2400000;

-- 4. 부서테이블에서 해외영업부서 수서코드, 부서명
select dept_id, dept_title
from department
where dept_title like '해외%';


/*
select dept_id, emp_name, job_code, ent_yn
from employee
where job_code != 'J3';
*/
--==========================================================================

/* 
<in> 절
where절에서 비교대상 컬럼 값이 제시한 목록 중 일치하는지

[표현법]
비교대상컬럼 in ('값1', '값2'...)
*/

-- 부서코드가 d6이거나 d8이거나 d5인 부서원 이름, 부서코드, 급여
select emp_name, dept_code, salary 
from employee
--where dept_code = 'D6' or dept_code = 'D8' or dept_code = 'D5';
 where dept_code in ('D6', 'D8', 'D5');
 
 --=======================
 /*
 <is null & is not null>
 컬럼 값에 null이 있을 경우 null값을 비교하기 위해 연산자를 사용
 */
 
select emp_id, emp_name, salary, bonus
from employee
where bonus is null;


select emp_id, emp_name, salary, bonus
from employee
where bonus is not null;

-- 사수가 없는 사원들의 사원명, 사수사번, 부서코드
select emp_name, manager_id, dept_code
from employee
where manager_id is null;
-- 부서 배치를 받지 않고 보너스를 받은 사원 이름, 보너스, 부서코드
select emp_name, bonus, dept_code
from employee
where dept_code is null and bonus is not null;

--===============================
/*
연산 中에 '()'괄호를 잘!!! 사용해야 함

<연산자 우선순위>
1. 산술연산자
2. 연결연산자
3. 비교연산자
4. is null / like / in
5. between a and b
6. not
7. and
8. or
*/

-- 직급 코드가 j7이거나 j2인 사원 中 급여가 200만 이상 사원 모든 컬럼 조회
select *
from employee
where job_code = 'J7' or job_code = 'J2' and salary >= 2000000;
-- 우선 순위가 중요하다 **!!주의必!!**
--where (job_code = 'J7' or job_code = 'J2') and salary >= 2000000;

--=========================exercise=============
-- 1. 사수가 없고 부서배지도 아직 인 사원명, 사번, 부서코드
select emp_name, emp_id, dept_code
from employee
where manager_id is null and dept_code is null;
  
-- 2. 연봉(보너스 미포함) 3천 이상, 보너스 받지 않는 사번, 사원명, 급여, 보너스
select emp_id, emp_name, salary, bonus
from employee
where (salary * 12) >= 30000000 and bonus is null;

-- 3. 입사일 '95/01/01'이상 부서배치 받지 않은 사번, 사원명, 입사일, 부서코드
select emp_id, emp_name, hire_date, dept_code
from employee
where hire_date >= '95/01/01' and dept_code is null;

-- 4. 급여 200만 이상 500만 이하 사원 中 입사일이 '01/01/01'이상 보너스 받지 않은 사번, 사원명, 입사일, 보너스
select emp_id, emp_name, salary, hire_date, bonus
from employee
where salary between 2000000 and 5000000 and (hire_date >= '01/01/01') and bonus is null;

/*
select emp_id, emp_name, hire_date, bonus
from employee
where salary >= 2000000 and salary <= 5000000 and hire_date >= '01/01/01 ;
*/

-- 5. 보너스를 포함 연봉 null아니고 이른에 '하'가 포함된 사번, 사원명, 급여, 보너스 포함 연봉
/*
select emp_id, emp_name, salary, bonus, salary *12
from employee
where ;
*/
select emp_id, emp_name, salary, (salary + (salary * bonus))*12
from employee
where (salary + (salary * bonus))*12 is not null and emp_name like '%하%';