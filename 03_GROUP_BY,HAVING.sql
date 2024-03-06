/*
<GROUT BY ��>
�׷������ ������ �� �ִ� ���� 
(�ش� �׷� ���غ��� ���� �׷����� ���� �� ����)
�������� ������ �ϳ��� �׷����� ��� ó���ϴ� �������� ���
*/

SELECT SUM(SALARY)
FROM employee; --��ü ����� �ϳ��� �׷����� ��� �� ���� ���� ���


--�� �μ��� �� �޿�
--�� �μ����� ���� �׷�
SELECT dept_code, SUM(SALARY)
FROM employee
GROUP BY dept_code;

-- �� �μ��� �����
SELECT dept_code, COUNT (*)
FROM employee
GROUP BY dept_code;

SELECT dept_code, COUNT (*), SUM(SALARY) -- 3.
FROM employee                      -------- 1.
GROUP BY dept_code                 -------- 2.
ORDER BY DEPT_CODE;                -------- 4. 

--�� ���޺� �� �����, ���ʽ��� �޴� �����, �޿���, ��ձ޿�, �����޿�, �ְ�޿� (���� : ���� ��������)

/*
SELECT JOB_code, COUNT (*), SUM( BONUS AND SALARY AS "�޿���"), SUM "�޿���" / AVG,   
FROM employee                      -------- 1.
GROUP BY dept_code                 -------- 2.
ORDER BY DEPT_CODE;   --ASC
*/

SELECT JOB_code, COUNT(*)
FROM employee     
GROUP BY JOB_CODE; --���޺� �������

SELECT JOB_code, COUNT(*) AS "�����", COUNT(BONUS) AS "���ʽ�",
       SUM(salary) AS "�޿�", ROUND (AVG (SALARY)) AS "�޿����"
       , MIN(SALARY) AS "�����޿�", MAX (SALARY)AS "�ְ�޿�"
FROM employee     
GROUP BY JOB_CODE
ORDER BY job_code; 
  
SELECT SUBSTR(EMP_NO, 8, 1), COUNT(*)
FROM employee
GROUP BY SUBSTR (emp_no, 8, 1);

-- GROUP BY ���� �Լ��� ��� ����
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'), COUNT(*)
FROM employee
GROUP BY SUBSTR (emp_no, 8, 1);

-- GROUP BY���� ���� �÷� ���
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code;

--=================
/*
[HAVING ��]

�׷쿡 ���� ������ ������ �� ���Ǵ� ����(�ַ� �׷��Լ����� ������ ������ ����))
*/

--�� �μ��� ��� �޿� ��ȸ(�μ��ڵ�, ��ձ޿�)
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY dept_code;

--�� �μ��� ��ձ޿��� 300�� �̻��� �μ��� �� ��ȸ (�μ��ڵ� ��ձ޿�
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY dept_code
WHERE AVG(SALARY)  >=3000000; --WHERE �Ұ�!!

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM employee
GROUP BY dept_code
HAVING AVG(SALARY)  >=3000000;
--WHERE�� �ະ�� **�׷����� ���� �־ ����� �� ����**
--HAVING �׷캰�� ������ �ͼ� �˻縦 �Ѵ�

--================
--���޺� �����ڵ�, �� �޿��� (��, ���޺� �޿����� 1000���� �̻��� ���� �� ��ȸ)
SELECT DEPT_CODE, SUM (SALARY)
FROM employee
GROUP BY dept_code
HAVING sUM(SALARY)  >=10000000;

-- �μ��� ���ʽ��� �޴� ����� ���� �μ��� �μ��ڵ�
SELECT DEPT_CODE 
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT (BONUS) = 0; 
--========
/*
 SELECT * |                                      -------- 5.
 ��ȸ�ϰ� ���� �÷� AS ��Ī | �Լ��� | ��������
 
 FROM                                            -------- 1.
 ��ȸ�ϰ��� �ϴ� ���̺� | DUAL
 
 WHERE                                           -------- 2.
 ���ǽ� (�����ڵ��� Ȱ���Ͽ� ���)
 
 GROUP BY                                        -------- 3.
 �׷������ �Ǵ� �÷� | �Լ���
 
 HAVING                                          -------- 4. 
 ���ǽ� (�׷��Լ��� ������ ���)
 
 ORDER  BY                                       -------- 6.
 �÷� | ��Ī | ���� [ ASC | DESC ] [ NULLS FIRST | NULLS LAST ]
 */
  
 -----------------------
 
 /*
 ���� ������ == set operation
 �������� �������� �ϳ��� ���������� ����� ������
 
 - union : or | ������ (�� ������ ������ ������� ���Ѵ�.)
 - intersect : and | ������ (�� �������� ������ ������� �ߺ� �� �����)
 - union all : ������ + ������ ( �ߺ��Ǵ°� 2�� ǥ���� �� �ִ�.)
 - minus : ������ ( ���������� ���������� �� ������)
 */
 
 -- 1. union
 -- �μ� �ڵ尡 d5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
 
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5' or salary > 3000000;
 
 -- �޿��� 300���� �ʰ��� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000;
  --�μ���  D5�� ������� ���, �̸�, �μ��ڵ�, �޿�
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
 
 --2. intersect(������)
 -- �μ��� D5, �޿� 300�� �ʰ�, ���, �̸�, �μ��ڵ�, �޿�
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 intersect
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000;
 -------------------------------------------------------------
 --���տ��� ���� **���ǻ���**
 
-- union
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 union
 select emp_id, email, dept_code, salary
 from employee
 where salary > 3000000;
 --colum�� ������ �����ؾ� �Ѵ�.**�ߺ��̵ȴ�**
  select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 union
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000;
 --colum�ڸ� ���� ������ type���� ����ؾ� �Ѵ�.
 --�����ϰ� �ʹٸ� order by�� �������� ���!!
 ---------------------------------------------------------
 --3. union all : �������� ���� ����� ������ �� ���ϴ� ������
  select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 union all
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000
 order by emp_id;--�ߺ� ������ ���
 
 --4. minus : ���� select������� ���� select����� �� ������(������)
 --�μ� �ڵ尡 D5�� ��� �� �޿� 300�� �ʰ� ��� ����
 select emp_id, emp_name, dept_code, salary
 from employee
 where dept_code = 'D5'
 minus
 select emp_id, emp_name, dept_code, salary
 from employee
 where salary > 3000000
 order by emp_id;
 
 
 
 
 





