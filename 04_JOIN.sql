/*
<JOIN>
2�� �̻��� TABLE���� �����͸� ��ȸ
��ȸ ����� �ϳ��� ����� (RESULT SET)�� ����

������ �����ͺ��̽������� �ּ����� �����͸� ������ ���̺� ��� �ֹ�
(�ߺ������� �ּ�ȭ�ϱ� ���� �ִ�� �ڸ��� ����)

=> ������ �����ͺ��̽����� SQL���� �̿��� ���̺� �� "����"�� �δ� ���
(������ �� ��ȸ�ؼ� ���°� �ƴ� ���̺� �� ������(�ܷ�Ű)�� ���� �����͸� ��Ī

JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����" (ANSI == �̱�����ǥ����ȸ)

[�������]

����Ŭ ���뱸��              | ANSI����
------------------------------------------------
�����                    | ��������
(EQUAL JOIN)               | ( INNER JOIN ) => JOIN USING / ON
-------------------------------------------------
��������                    | ���� �ܺ� ���� (LEET OUTER JOIN)
(LEET OUTER)               | ������ �ܺ� ���� (RIGHT OUTER JOIN)
(RIGHT OUTER)              | ��ü �ܺ� ���� (FULL OUTER JOIN)
-------------------------------------------------
��ü���� (SELF JOIN)                | JOIN ON
�� ���� (NON EAUAL JOIN)
--------------------------------------------------
*/

--��ü ������� ���, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

--�μ���
SELECT DEPT_ID, DEPT_TITLE
FROM department;

--��ü ������� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT job_code, JOB_NAME
FROM JOB;

/*
1. �����(EQUAL JOIN) /  ��������(INNER JOIN)
�����Ű�� �÷����� ��ġ�ϴ� �� ��ȸ
*/

--> ����Ŭ ���뱸��
-- FROM���� ��ȸ�ϴ� ���̺� ���� (,�� ����)
-- WHERE���� ��Ī��ų �÷��� ���� ������ ����
--1) ������ 2 COLUM���� �ٸ� ���(EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
--��ü ��� ���, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- NULL, D3, D4, D7�����ʹ� �� �� ���̺��� �� �����ϱ� ������ ���ܵ� �� �� �� �ִ�.
-- ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵ� ���� Ȯ���� �� �ִ�.

-- 2) ������ 2���� COLUM���� ���� ��� ( EMPLOYEE : JOB_CODE / JOB : JOB_CODE)
--��ü ����� ���, �����, �����ڵ�, ���޸�

SELECT EMP_ID, EMP_NAME, J.JOB_CODE, job_name
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = j.job_code;

-------->ANSI����
--FROM ���� ������ �Ǵ� ���̺� �ϳ� ���
--JOIN���� ���� �����ϰ��� �ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ���ǵ� ���
--JOIN USING / JOIN ON

-- 1. ������ 2 �÷��� �ٸ� �� (EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
-- JOIN ON
-- ��ü ��� �� ���, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN department ON (DEPT_CODE = DEPT_ID);

-- 2. ������ 2 �÷��� ���� ��� (EMPLOYEE : JOB_CODE / JOB : JOB_CODE)
-- ��ü ��� �� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);

--JOIN USING���� ��� �����ϴ� �÷��� ���� ����

--�߰����� �������� ����
--������ �븮 ���, �����, ���޸�, �޿�
--����Ŭ ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J -- ������ ��ٷο� �� ����!!
WHERE E.JOB_CODE = j.job_code AND JOB_NAME = '�븮';

--ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮';

--------------------------����------------------------
--1. �μ��� �λ���� �� ���, �̸�, ���ʽ�
--> ����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D --JOIN�� (POINT)
WHERE E.DEPT_CODE = d.dept_id AND d.dept_title = '�λ������';

--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE  --ORACLE�� ����
JOIN department ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

--2. DEPARTMENT�� LOCATION ���̺� ���� �μ��ڵ�, �μ���, �����ڵ�, ������
--> ����Ŭ
SELECT DEPT_ID, DEPT_TITLE, location_id, LOCAL_NAME --�μ��ڵ�, �μ���, �����ڵ�, ������
FROM DEPARTMENT, LOCATION                       --LOCATION_ID = LOCAL_CODE
WHERE LOCATION_ID = LOCAL_CODE;                 --LOCATION_ID = LOCAL_CODE
--> ANSI
SELECT DEPT_ID, DEPT_TITLE, location_id, LOCAL_NAME --���� ����
FROM DEPARTMENT
JOIN location ON (location_ID = LOCAL_CODE);


3. ���ʽ� �޴� ��� ���, �����, ���ʽ�, �μ���
--> ����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE 
FROM employee E, department D                       
WHERE E.DEPT_CODE = D.DEPT_ID 
AND BONUS IS NOT NULL;
--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE 
FROM employee  
JOIN department ON (DEPT_CODE = DEPT_ID) 
AND BONUS IS NOT NULL;

--4. �ѹ��ΰ� �ƴ� �����, �޿�
--> ����Ŭ
SELECT EMP_NAME, SALARY
FROM employee, department
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '�ѹ���';
--> ANSI
SELECT EMP_NAME, SALARY
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE !='�ѹ���';

--------------------------------------------------------
/*

2. �������� / �ܺ�����(OUTER JOIN)
 �� ���̺� ���� JOIN�� ��ġ���� �ʴ� �൵ �����Ͽ� ��ȸ����
 
 ��, �ݵ�� LEFT / RIGHT�� �����ؾ� �� (������ ��)

*/
--�����, �μ���, �޿�, ����
--���� ���ν� �μ� ��ġ�� ���� ���� 2���� ��������� �����ȴ�.
SELECT *
FROM employee  
JOIN department ON (DEPT_CODE = DEPT_ID);

-- 1) LEET JOIN : �� ���̺� �� ���� ��� �� ���̺��� �������� JOIN
-- ����Ŭ
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
--ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee --����
LEFT JOIN department ON (DEPT_CODE = DEPT_ID);--������������ JOIN�� ����

-- 2) RIGHT JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;
 
--ANSI ����
--SELECT 


-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ(����ŬX)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM employee
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-----------------
/*
3. �� ���� (NON EQUAL JOIN)

��Ī��ų �÷��� ���� ���� �ۼ��� '='�� ������� �ʴ� ���ι�
ANSI�������� JOIN ON
*/

-- �����, �޿�, �޿�����
-- ����Ŭ => ������ �Է��ϱ� ���ؼ� ������ �����͸� Ȱ���ϱ� ������ �ʵ忡�� ��뵵�� ������
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

--ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY >= MIN_SAL AND SALARY <= MAX_SAL);

------------------------------------------
--**��뵵�� ����**--
/*
4. ��������(SELF JOIN)
���� ���̺��� �ٽ� ����
*/

--��ü ��� �� ���, �����, �μ��ڵ�     --->EMPLOYEE E
--         ������, �����, ����μ��ڵ�  -->EMPLOYEE M
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE,
M.EMP_ID"������", M.EMP_NAME"�����", M.DEPT_CODE
FROM employee E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-->ANSI
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE,
M.EMP_ID"������", M.EMP_NAME"�����", M.DEPT_CODE
FROM employee E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

------------------------------------------------------------------
/*
��������*/
--���, �����(EM), �μ���(DE), ���޸�(JO)
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

--���, �����, �μ���, ������
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

-------------��� ������ �� ��������-------------

--1. ���, �����, �μ���, ������, ������ ��ȸ
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

--2. ���, �����, �μ���, ���޸�, ������, ������, �޿���� ��ȸ
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