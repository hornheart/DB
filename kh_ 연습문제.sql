--------------KH_연습문제--------------

--1. JOB 테이블의 모든 정보 조회
SELECT *
FROM JOB;

--2. JOB 테이블의 직급 이름 조회 
SELECT JOB_NAME
FROM JOB;

--3. DEPARTMENT 테이블의 모든 정보 조회 
SELECT *
FROM DEPARTMENT;

--4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

--6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
/*
SELECT EMP_NAME, SALARY*12 연봉, ((SALARY*12)*(BONUS*nvl( ,0 )+(SALARY*12) 총수령액, ((SALARY*12)*BONUS)+(SALARY*12)-0.03*(SALARY*12)실수령액
FROM EMPLOYEE;
*/

SELECT EMP_NAME, SALARY*12 연봉, ((SALARY+(SALARY*nvl(BONUS,0))*12,
((SALARY+(SALARY*nvl(BONUS,0)))*12) - (salary*12*0.03)) 총수령액, ((SALARY*12)*BONUS)+(SALARY*12)-0.03*(SALARY*12)실수령액
FROM EMPLOYEE;

--7. EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
/*
select emp_name, salary, hire_date, phone
from employee
where  salary >= 6000000;
*/
select emp_name, salary, hire_date, phone
from employee
join sal_grade on (salary between min_sal and max_sal)
where  sal_level = 's1';

--8. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
select emp_name, salary, 
-(SALARY*12*0.03))실수령액, hire_date
from employee
where (((SALARy+(salary*nvl(BONUS,0)))*12)-(SALARY*12*0.03)) >= 50000000;

--9. EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
select *
from employee
where salary >=4000000 and job_code = 'J2';

--10. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중
 고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
select emp_name, dept_code, hire_date 
from employee
where dept_code = 'D9' or dept_code = 'D5' 
minus
select emp_name, dept_code, hire_date 
from employee
where hire_date > '02/01/01';
-- and + or 도 연습이 필요 
/*and hire_date <'02/01/01';*/

--11. EMPLOYEE테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
select *
from EMPLOYEE
where '90/01/01'<= hire_date and '01/01/01'>= hire_date;
--between 도 연습

--12. EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
select emp_name
from EMPLOYEE
where emp_name like '__연';

--13. EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
select emp_name, phone
from EMPLOYEE
where phone not like '010%';

--14. EMPLOYEE테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고
-- 고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
select *
from employee
where email like '____\_%' escape '\'      --메일주소 '_'의 앞이 4자
and (dept_code = 'D9' or dept_code = 'D6')
and hire_date between '90/01/01' and '00/12/01'
and salary >= 2700000; 
 
--15. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
select emp_name 사원명,
       substr(emp_no, 1, 2)생년,
       substr(emp_no, 3, 2)생월,
       substr(emp_no, 5, 2)생일
from employee;       

--16. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
--select emp_name, substr(emp_no, 1, 7) || '-*******' --**2가지 모두 복습 必**
select emp_name, rpad (substr(emp_no, 1, 7), 14, '*')
from employee;

--17. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회**FLOOR복습必**
-- (단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)

select emp_name,
       floor(abs(hire_date - sysdate)) as "근무일수1",
       floor(abs(sysdate - hire_date)) as "근무일수2"
       from employee;

--18. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회 **복습必**
select *
from employee
where mod (emp_id, 2)=1; -- 자동 형변환
--where mod (to_number(emp_id), 2) = 1;

--19. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회 **복습必**
select *
from employee
where MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240;
-- WHERE ADD_MONTHS(HIRE_DATE, 240)

--20. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000' 형식으로 표시)
select EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
from employee;

--21. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이(만) 조회
-- (단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며
-- 나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
select EMP_NAME, DEPT_CODE, 
       SUBSTR(EMP_NO, 1, 2) || '년' || SUBSTR(EMP_NO, 3, 2) || '월' || SUBSTR(EMP_NO,5, 2) || '일' AS "생일",
      -- (SYSDATE - TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YYMMDD')) / 365
      EXTRACT(YEAR FROM SYSDATE)-
      EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RRRR'))
from employee;

--22. EMPLOYEE테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 D5면 총무부, D6면 기획부, D9면 영업부로 처리
-- (단, 부서코드 오름차순으로 정렬) --CASE
select emp_id, EMP_NAME, dept_code,
    CASE 
     WHEN DEPT_CODE = 'D5' THEN '총무부'
     WHEN DEPT_CODE = 'D6' THEN '기획부'
     WHEN DEPT_CODE = 'D0' THEN '영업부'
    END
from employee
where dept_code IN ('D5', 'D6', 'D9')
ORDER BY dept_code;

--23. EMPLOYEE테이블에서 사번이 201번인 사원명, 주민번호 앞자리, 주민번호 뒷자리, 
-- 주민번호 앞자리와 뒷자리의 합 조회
select EMP_NAME,
    SUBSTR(EMP_NO, 1, 6) AS 앞자리,
    SUBSTR(EMP_NO, 8) AS 뒷자리,
    SUBSTR(EMP_NO, 1, 6) + SUBSTR(EMP_NO, 8)
    -- TO_NUMBER(EMP_NO, 1, 6) + SUBSTR(EMP_NO, 8) **추천**
from employee
where emp_id = 201;

--24. EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 
select SUM((SALARY + (SALARY * NVL(BONUS,0)))*12)
from employee
where dept_code = 'D5';

--25. EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
-- 전체 직원 수, 2001년, 2002년, 2003년, 2004 --GROUP BY도 가능
/*select COUNT (*),
     COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2001', 1))
from employee;
*/
select COUNT (*),
       COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2001', 1))AS "2001년",
        COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2002', 1))AS"2002년",
         COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2003', 1))AS"2003년",
          COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2004', 1))AS"2004년"
          
from employee;


