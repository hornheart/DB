--������� ������鸸 EMP_NAME, EMP_NO ��ȸ

SELECT EMP_NAME, EMP_NO
FROM employee
WHERE SUBSTR (EMP_NO, 8, 1) = 2 OR SUBSTR (EMP_NO, 8, 4) = 4;

-- �����Ͽ��� �����, �̸���, ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1)
FROM employee;

---------0223
--EMPLOYEE���̺��� 'd6'�ڵ��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ, ���� ��ȸ 
select  emp_name, email, phone, hire_date, salary
from employee
where dept_code = 'D6';

--EMPLOYEE���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
select *
from employee
where 