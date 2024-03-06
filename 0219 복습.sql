--사원들중 여사원들만 EMP_NAME, EMP_NO 조회

SELECT EMP_NAME, EMP_NO
FROM employee
WHERE SUBSTR (EMP_NO, 8, 1) = 2 OR SUBSTR (EMP_NO, 8, 4) = 4;

-- 사원목록에서 사원명, 이메일, 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1)
FROM employee;

---------0223
--EMPLOYEE테이블의 'd6'코드의 직원명, 이메일, 전화번호, 고용일 조회, 월급 조회 
select  emp_name, email, phone, hire_date, salary
from employee
where dept_code = 'D6';

--EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
select *
from employee
where 