/*
<GROUT BY 절>
그룹기준을 제시할 수 있는 구문 
(해당 그룹 기준별로 여러 그룹으로 묶을 수 있음)
여러개의 값들을 하나의 그룹으로 묶어서 처리하는 목적으로 사용
*/

SELECT SUM(SALARY)
FROM employee; --전체 사원을 하나의 그룹으로 묶어서 총 합을 구한 결과


--각 부서별 총 급여
--각 부서들이 전부 그룹
SELECT dept_code, SUM(SALARY)
FROM employee
GROUP BY dept_code;

-- 각 부서별 사원수
SELECT dept_code, COUNT (*)
FROM employee
GROUP BY dept_code;

SELECT dept_code, COUNT (*), SUM(SALARY) -- 3.
FROM employee                      -------- 1.
GROUP BY dept_code                 -------- 2.
ORDER BY DEPT_CODE;                -------- 4. 

--각 직급별 총 사원수, 보너스를 받는 사원수, 급여합, 평균급여, 최저급여, 최고급여 (정렬 : 지급 오름차순)

/*
SELECT JOB_code, COUNT (*), SUM( BONUS AND SALARY AS "급여합"), SUM "급여합" / AVG,   
FROM employee                      -------- 1.
GROUP BY dept_code                 -------- 2.
ORDER BY DEPT_CODE;   --ASC
*/

SELECT JOB_code, COUNT(*)
FROM employee     
GROUP BY JOB_CODE; --직급별 몇명인지

SELECT JOB_code, COUNT(*) AS "사원수", COUNT(BONUS) AS "보너스",
       SUM(salary) AS "급여", ROUND (AVG (SALARY)) AS "급여평균"
       , MIN(SALARY) AS "최저급여", MAX (SALARY)AS "최고급여"
FROM employee     
GROUP BY JOB_CODE
ORDER BY job_code; 
  
SELECT SUBSTR(EMP_NO, 8, 1), COUNT(*)
FROM employee
GROUP BY SUBSTR (emp_no, 8, 1);

-- GROUP BY 절에 함수식 사용 가능
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'), COUNT(*)
FROM employee
GROUP BY SUBSTR (emp_no, 8, 1);

-- GROUP BY절에 여러 컬럼 기술
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code;

--=================
/*
[HAVING 절]

그룹에 대한 조건을 제시할 때 사용되는 구문(주로 그룹함수식을 가지고 조건을 만듦))
*/

--각 부서별 평균 급여 조회(부서코드, 평균급여)
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY dept_code;

--각 부서별 평균급여가 300만 이상이 부서들 만 조회 (부서코드 평균급여
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY dept_code
WHERE AVG(SALARY)  >=3000000; --WHERE 불가!!

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY dept_code
HAVING AVG(SALARY)  >=3000000;
--WHERE는 행별로 **그룹으로 묶여 있어서 사용할 수 없다**
--HAVING 그룹별로 가지고 와서 검사를 한다

--================
--직급별 직급코드, 총 급여합 (단, 직급별 급여합이 1000만원 이상인 직급 만 조회)
SELECT DEPT_CODE, SUM (SALARY)
FROM employee
GROUP BY dept_code
HAVING sUM(SALARY)  >=10000000;

-- 부서별 보너스를 받는 사원이 없는 부서의 부서코드
SELECT DEPT_CODE 
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT (BONUS) = 0; 
--========
/*
 SELECT * |                                      -------- 5.
 조회하고 싶은 컬럼 AS 별칭 | 함수식 | 산술연산식
 
 FROM                                            -------- 1.
 조회하고자 하는 테이블 | DUAL
 
 WHERE                                           -------- 2.
 조건식 (연산자들을 활용하여 기술)
 
 GROUP BY                                        -------- 3.
 그룹기준이 되는 컬럼 | 함수식
 
 HAVING                                          -------- 4. 
 조건식 (그룹함수를 가지고 기술)
 
 ORDER  BY                                       -------- 6.
 컬럼 | 별칭 | 순서 [ ASC | DESC ] [ NULLS FIRST | NULLS LAST ]
 */
  
 -----------------------
 
 /*
 집합 연산자 == set operation
 여러개의 퀴리문을 하나의 퀴리문으로 만드는 연산자
 
 - union : or | 합집합 (두 쿼리문 수행한 결과값을 더한다.)
 - intersect : and | 교집합 (두 쿼리문을 수행한 결과값에 중복 된 결과값)
 - union all : 합집합 + 교집합 ( 중복되는게 2번 표현될 수 있다.)
 - minus : 차집합 ( 선행결과값에 후행결과값을 뺀 나머지)
 */
 
 -- 1. union
 -- 부서 코드가 d5인 사원 또는 급여가 300만원 초과인 사원들의 사번, 이름, 부서코드, 급여 조회
 
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5' or salary > 3000000;
 
 -- 급여가 300만원 초과인 사원들의 사번, 이름, 부서코드, 급여 조회
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000;
  --부서가  D5인 사원들의 사번, 이름, 부서코드, 급여
  /* select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5' or salary > 3000000;
*/

-- union
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 union
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000;
 
 --2. intersect(교집합)
 -- 부서가 D5, 급여 300만 초과, 사번, 이름, 부서코드, 급여
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 intersect
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000;
 -------------------------------------------------------------
 --집합연산 시의 **주의사항**
 
-- union
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 union
 select emp_id, email, dept_code, salary
 from employee
 where salary > 3000000;
 --colum의 갯수가 동일해야 한다.**중복이된다**
  select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 union
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000;
 --colum자리 마다 동일한 type으로 기술해야 한다.
 --정렬하고 싶다면 order by는 마지막에 기술!!
 ---------------------------------------------------------
 --3. union all : 여러개의 쿼리 결과를 무조건 다 더하는 연산자
  select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 union all
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000
 order by emp_id;--중복 값까지 출력
 
 --4. minus : 선행 select결과에서 후행 select결과를 뺀 나머지(차집합)
 --부서 코드가 D5인 사원 中 급여 300만 초과 사원 제외
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 minus
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000
 order by emp_id;
 
 
 
 
 





