/*
<JOIN>
2개 이상의 TABLE에서 데이터를 조회
조회 결과는 하나의 결과물 (RESULT SET)로 나옴

관계형 데이터베이스에서는 최소한의 데이터를 각각의 테이블에 담고 있믐
(중복저장을 최소화하기 위해 최대로 자르고 관리)

=> 관계형 데이터베이스에서 SQL문을 이용한 테이블 간 "관계"를 맺는 방법
(무작정 다 조회해서 오는게 아닌 테이블 별 연결고기(외래키)를 통해 데이터를 매칭

JOIN은 크게 "오라클 전용 구문"과 "ANSI 구문" (ANSI == 미국국립표준협회)

[용어정리]

오라클 전용구문              | ANSI구문
------------------------------------------------
등가조인                    | 내부조인
(EQUAL JOIN)               | ( INNER JOIN ) => JOIN USING / ON
-------------------------------------------------
포괄조인                    | 왼쪽 외부 조인 (LEET OUTER JOIN)
(LEET OUTER)               | 오른쪽 외부 조인 (RIGHT OUTER JOIN)
(RIGHT OUTER)              | 전체 외부 조인 (FULL OUTER JOIN)
-------------------------------------------------
자체조인 (SELF JOIN)                | JOIN ON
비등가 조인 (NON EAUAL JOIN)
--------------------------------------------------
*/

--전체 사원들의 사번, 사원명, 부서코드, 부서명
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

--부서명
SELECT DEPT_ID, DEPT_TITLE
FROM department;

--전체 사원들의 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT job_code, JOB_NAME
FROM JOB;

/*
1. 등가조인(EQUAL JOIN) /  내부조인(INNER JOIN)
연결시키는 컬럼값의 일치하는 행 조회
*/

--> 오라클 전용구문
-- FROM절에 조회하는 테이블 나열 (,로 구분)
-- WHERE절에 매칭시킬 컬럽에 대한 조건을 제시
--1) 연결할 2 COLUM명이 다른 경우(EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
--전체 사원 사번, 사원명, 부서코드, 부서명
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- NULL, D3, D4, D7데이터는 한 쪽 테이블에서 만 존재하기 때문에 제외된 것 알 수 있다.
-- 일치하는 값이 없는 행은 조회에서 제외된 것을 확인할 수 있다.

-- 2) 연결할 2개의 COLUM명이 같은 경우 ( EMPLOYEE : JOB_CODE / JOB : JOB_CODE)
--전체 사원들 사번, 사원명, 직급코드, 직급명

SELECT EMP_ID, EMP_NAME, J.JOB_CODE, job_name
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = j.job_code;

-------->ANSI구문
--FROM 절에 기준이 되는 테이블 하나 기술
--JOIN절에 같이 조인하고자 하는 테이블 기술 + 매칭시킬 컬럼에 대한 조건도 기술
--JOIN USING / JOIN ON

-- 1. 연결할 2 컬럼명 다를 때 (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
-- JOIN ON
-- 전체 사원 中 사번, 사원명, 부서코드, 부서명
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN department ON (DEPT_CODE = DEPT_ID);

-- 2. 연결할 2 컬럼명 같은 경우 (EMPLOYEE : JOB_CODE / JOB : JOB_CODE)
-- 전체 사원 中 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--JOIN USING같은 경우 연결하는 컬럼명 같을 때만

--추가적인 조건제시 가능
--직급이 대리 사번, 사원명, 직급명, 급여
--오라클 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J -- 조건이 까다로울 수 있음!!
WHERE E.JOB_CODE = j.job_code AND JOB_NAME = '대리';

--ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리';

--------------------------문제------------------------
--1. 부서가 인사관리 부 사번, 이름, 보너스
--> 오라클
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D --JOIN의 (POINT)
WHERE E.DEPT_CODE = d.dept_id AND d.dept_title = '인사관리부';

--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE  --ORACLE과 동일
JOIN department ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

--2. DEPARTMENT와 LOCATION 테이블 참고 부서코드, 부서명, 지역코드, 지역명
--> 오라클
SELECT DEPT_ID, DEPT_TITLE, location_id, LOCAL_NAME --부서코드, 부서명, 지역코드, 지역명
FROM DEPARTMENT, LOCATION                       --LOCATION_ID = LOCAL_CODE
WHERE LOCATION_ID = LOCAL_CODE;                 --LOCATION_ID = LOCAL_CODE
--> ANSI
SELECT DEPT_ID, DEPT_TITLE, location_id, LOCAL_NAME --위와 동일
FROM DEPARTMENT
JOIN location ON (location_ID = LOCAL_CODE);


3. 보너스 받는 사원 사번, 사원명, 보너스, 부서명
--> 오라클
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE 
FROM employee E, department D                       
WHERE E.DEPT_CODE = D.DEPT_ID 
AND BONUS IS NOT NULL;
--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE 
FROM employee  
JOIN department ON (DEPT_CODE = DEPT_ID) 
AND BONUS IS NOT NULL;

--4. 총무부가 아닌 사원명, 급여
--> 오라클
SELECT EMP_NAME, SALARY
FROM employee, department
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '총무부';
--> ANSI
SELECT EMP_NAME, SALARY
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE !='총무부';

--------------------------------------------------------
/*

2. 포괄조인 / 외부조인(OUTER JOIN)
 두 테이블 간의 JOIN시 일치하지 않는 행도 포함하여 조회가능
 
 단, 반드시 LEFT / RIGHT를 지정해야 함 (기준이 必)

*/
--사원명, 부서명, 급여, 연봉
--내부 조인시 부서 배치를 받지 않은 2명의 사원정보가 누락된다.
SELECT *
FROM employee  
JOIN department ON (DEPT_CODE = DEPT_ID);

-- 1) LEET JOIN : 두 테이블 중 왼편에 기술 된 테이블을 기준으로 JOIN
-- 오라클
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
--ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee --기준
LEFT JOIN department ON (DEPT_CODE = DEPT_ID);--조건절이지만 JOIN을 만듦

-- 2) RIGHT JOIN : 두 테이블 중 오른편에 기술된 테이블을 기준으로 JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;
 
--ANSI 구문
--SELECT 


-- 3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회(오라클X)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-----------------
/*
3. 비등가 조인 (NON EQUAL JOIN)

매칭시킬 컬럼에 대한 조건 작성시 '='을 사용하지 않는 조인문
ANSI구문으로 JOIN ON
*/

-- 사원명, 급여, 급여레벨
-- 오라클 => 정보를 입력하기 위해서 고유한 데이터를 활용하기 때문에 필드에서 사용도가 떨어짐
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

--ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY >= MIN_SAL AND SALARY <= MAX_SAL);

------------------------------------------
--**사용도가 높음**--
/*
4. 자제조인(SELF JOIN)
같은 테이블을 다시 조인
*/

--전체 사원 中 사번, 사원명, 부서코드     --->EMPLOYEE E
--         사수사번, 사수명, 사수부서코드  -->EMPLOYEE M
SELECT E.EMP_ID AS "사원사번", E.EMP_NAME AS "사원명", E.DEPT_CODE,
M.EMP_ID"사수사번", M.EMP_NAME"사수명", M.DEPT_CODE
FROM employee E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-->ANSI
SELECT E.EMP_ID AS "사원사번", E.EMP_NAME AS "사원명", E.DEPT_CODE,
M.EMP_ID"사수사번", M.EMP_NAME"사수명", M.DEPT_CODE
FROM employee E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

------------------------------------------------------------------
/*
다중조인*/
--사번, 사원명(EM), 부서명(DE), 직급명(JO)
--ORACLE
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;
--ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN department ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);

--사번, 사원명, 부서명, 지역명
SELECT * FROM employee;--DEPT_CODE
SELECT * FROM department; --DEPT_ID         LOCATION_ID
SELECT * FROM LOCATION; --                  LOCATION_CODE

SELECT emp_id, emp_name, dept_TITLE, LOCAL_NAME
FROM employee, DEPARTMENT, LOCATION 
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

--ANSI
SELECT emp_id, emp_name, dept_TITLE, LOCAL_NAME
FROM employee
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-------------묶어서 생각할 때 주의하자-------------

--1. 사번, 사원명, 부서명, 지역명, 국가명 조회
--(EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL)
SELECT emp_id, emp_name, dept_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE;

--
SELECT emp_id, emp_name, dept_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);

--2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회
--(EMPLOYEE, DEPARTMENT, JOB, LOCATION, NATIONAL, SAL_GTADE)
SELECT emp_id, emp_name, dept_TITLE, JOB_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID
AND E. JOB_CODE = J.JOB_CODE
AND D. LOCATION_ID = L.LOCAL_CODE
AND L. NATIONAL_CODE = N.NATIONAL_CODE
AND E. SALARY BETWEEN S. MIN_SAL AND S.MAX_SAL;
--
SELECT emp_id, emp_name, dept_TITLE, JOB_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
JOIN SAL_GRADE 0N (SALARY BETWEEN MIN_SAL AND MAX_SAL);