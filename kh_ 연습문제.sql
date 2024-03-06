--------------KH_��������--------------

--1. JOB ���̺��� ��� ���� ��ȸ
SELECT *
FROM JOB;

--2. JOB ���̺��� ���� �̸� ��ȸ 
SELECT JOB_NAME
FROM JOB;

--3. DEPARTMENT ���̺��� ��� ���� ��ȸ 
SELECT *
FROM DEPARTMENT;

--4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--5. EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

--6. EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
/*
SELECT EMP_NAME, SALARY*12 ����, ((SALARY*12)*(BONUS*nvl( ,0 )+(SALARY*12) �Ѽ��ɾ�, ((SALARY*12)*BONUS)+(SALARY*12)-0.03*(SALARY*12)�Ǽ��ɾ�
FROM EMPLOYEE;
*/

SELECT EMP_NAME, SALARY*12 ����, ((SALARY+(SALARY*nvl(BONUS,0))*12,
((SALARY+(SALARY*nvl(BONUS,0)))*12) - (salary*12*0.03)) �Ѽ��ɾ�, ((SALARY*12)*BONUS)+(SALARY*12)-0.03*(SALARY*12)�Ǽ��ɾ�
FROM EMPLOYEE;

--7. EMPLOYEE���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
/*
select emp_name, salary, hire_date, phone
from employee
where  salary >= 6000000;
*/
select emp_name, salary, hire_date, phone
from employee
join sal_grade on (salary between min_sal and max_sal)
where  sal_level = 's1';

--8. EMPLOYEE���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
select emp_name, salary, 
-(SALARY*12*0.03))�Ǽ��ɾ�, hire_date
from employee
where (((SALARy+(salary*nvl(BONUS,0)))*12)-(SALARY*12*0.03)) >= 50000000;

--9. EMPLOYEE���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
select *
from employee
where salary >=4000000 and job_code = 'J2';

--10. EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� ��
 ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
select emp_name, dept_code, hire_date 
from employee
where dept_code = 'D9' or dept_code = 'D5' 
minus
select emp_name, dept_code, hire_date 
from employee
where hire_date > '02/01/01';
-- and + or �� ������ �ʿ� 
/*and hire_date <'02/01/01';*/

--11. EMPLOYEE���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
select *
from EMPLOYEE
where '90/01/01'<= hire_date and '01/01/01'>= hire_date;
--between �� ����

--12. EMPLOYEE���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
select emp_name
from EMPLOYEE
where emp_name like '__��';

--13. EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
select emp_name, phone
from EMPLOYEE
where phone not like '010%';

--14. EMPLOYEE���̺��� �����ּ� '_'�� ���� 4���̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
-- ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
select *
from employee
where email like '____\_%' escape '\'      --�����ּ� '_'�� ���� 4��
and (dept_code = 'D9' or dept_code = 'D6')
and hire_date between '90/01/01' and '00/12/01'
and salary >= 2700000; 
 
--15. EMPLOYEE���̺��� ��� ��� ������ �ֹι�ȣ�� �̿��Ͽ� ����, ����, ���� ��ȸ
select emp_name �����,
       substr(emp_no, 1, 2)����,
       substr(emp_no, 3, 2)����,
       substr(emp_no, 5, 2)����
from employee;       

--16. EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲٱ�)
--select emp_name, substr(emp_no, 1, 7) || '-*******' --**2���� ��� ���� ��**
select emp_name, rpad (substr(emp_no, 1, 7), 14, '*')
from employee;

--17. EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ**FLOOR������**
-- (��, �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ǵ��� �ϰ� ��� ����(����), ����� �ǵ��� ó��)

select emp_name,
       floor(abs(hire_date - sysdate)) as "�ٹ��ϼ�1",
       floor(abs(sysdate - hire_date)) as "�ٹ��ϼ�2"
       from employee;

--18. EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ **������**
select *
from employee
where mod (emp_id, 2)=1; -- �ڵ� ����ȯ
--where mod (to_number(emp_id), 2) = 1;

--19. EMPLOYEE���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ **������**
select *
from employee
where MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240;
-- WHERE ADD_MONTHS(HIRE_DATE, 240)

--20. EMPLOYEE ���̺��� �����, �޿� ��ȸ (��, �޿��� '\9,000,000' �������� ǥ��)
select EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
from employee;

--21. EMPLOYEE���̺��� ���� ��, �μ��ڵ�, �������, ����(��) ��ȸ
-- (��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
-- ���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���)
select EMP_NAME, DEPT_CODE, 
       SUBSTR(EMP_NO, 1, 2) || '��' || SUBSTR(EMP_NO, 3, 2) || '��' || SUBSTR(EMP_NO,5, 2) || '��' AS "����",
      -- (SYSDATE - TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YYMMDD')) / 365
      EXTRACT(YEAR FROM SYSDATE)-
      EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RRRR'))
from employee;

--22. EMPLOYEE���̺��� �μ��ڵ尡 D5, D6, D9�� ����� ��ȸ�ϵ� D5�� �ѹ���, D6�� ��ȹ��, D9�� �����η� ó��
-- (��, �μ��ڵ� ������������ ����) --CASE
select emp_id, EMP_NAME, dept_code,
    CASE 
     WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
     WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
     WHEN DEPT_CODE = 'D0' THEN '������'
    END
from employee
where dept_code IN ('D5', 'D6', 'D9')
ORDER BY dept_code;

--23. EMPLOYEE���̺��� ����� 201���� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�, 
-- �ֹι�ȣ ���ڸ��� ���ڸ��� �� ��ȸ
select EMP_NAME,
    SUBSTR(EMP_NO, 1, 6) AS ���ڸ�,
    SUBSTR(EMP_NO, 8) AS ���ڸ�,
    SUBSTR(EMP_NO, 1, 6) + SUBSTR(EMP_NO, 8)
    -- TO_NUMBER(EMP_NO, 1, 6) + SUBSTR(EMP_NO, 8) **��õ**
from employee
where emp_id = 201;

--24. EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �� 
select SUM((SALARY + (SALARY * NVL(BONUS,0)))*12)
from employee
where dept_code = 'D5';

--25. EMPLOYEE���̺��� �������� �Ի��Ϸκ��� �⵵�� ������ �� �⵵�� �Ի� �ο��� ��ȸ
-- ��ü ���� ��, 2001��, 2002��, 2003��, 2004 --GROUP BY�� ����
/*select COUNT (*),
     COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2001', 1))
from employee;
*/
select COUNT (*),
       COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2001', 1))AS "2001��",
        COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2002', 1))AS"2002��",
         COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2003', 1))AS"2003��",
          COUNT( DECODE(TO_CHAR (extracT(YEAR FROM HIRE_DATE)),'2004', 1))AS"2004��"
          
from employee;


