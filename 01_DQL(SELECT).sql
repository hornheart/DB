/*
 <SELECT>
 SELECT ������ ���� ���� ���� FORM table;
 SELECT (*)�Ǵ� �÷�1, �÷�2... FORM ���̺�;
 */
 
  -- ��� ����� ������ ������
  SELECT
      * FROM employee;
      
      -- ��� ����� �̸�, �ֹι�ȣ, �ڵ�����ȣ�� �˰� �;� 
      SELECT EMP_NAME, EMP_NO, PHONE
          FROM EMPLOYEE;
          
------�ǽ�---------------
--JOB���̺� ���޸� �÷� �� ��ȸ
-- DEPARTMENT ���̺��� ��� �÷� ��ȸ
-- DEPARTMENT ���̺��� �μ��ڵ�, �μ��� ��ȸ
-- EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿���ȸ

--SELECT JOB_NAME FROM job ;
--SELECT * FROM department;
--SELECT dept_id,dept_title FROM department;
--SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE,SALARY FROM EMPLOYEE; 

--<colum���� ���� �������>
--SELECT�� �÷��� �ۼ��κп� ��������� �� �� �ִ�.
--EMPOYEE���̺��� �����, ����� ����(SALARY * 12)�� ��ȸ

SELECT EMP_NAME, SALARY *12 FROM employee;

-- EMPLOYEE���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ������ ��ȸ
--(�޿� + (�޿�*���ʽ�))*12
 SELECT EMP_NAME, SALARY, BONUS,SALARY*12, (SALARY+(salary*BONUS))*12 FROM employee;

--������� ���� �� NULL�����Ͱ� ���ԵǾ� �ִٸ�, ������ ������� NULL 
--(null = ���� ���簡 ���� 0���� �ٸ���, ����� �� �� ������ �ǹ��Ѵ�)

-- �����, �Ի���, �ٹ��ϼ��� ��ȸ
-- (����ð�) - (�Ի���) = (�ٹ��� �ð�)
-- DATE - DATE => ������� ������ �Ϸ� ǥ�õȴ�.
-- �ڵ����� ��¥�� ǥ�����ִ� ��� : SYSDATE[��/��/��/��/��/��]

SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE FROM employee;
--<��Ī>������ ����

SELECT SYSDATE FROM DUAL; 
--**����Ŭ�� �� ���̺�=DUAL
--���� Ŭ����, �� ���⸦ ���� �ð� ���̺��� �� �� �ִ�.
-- DUAL : ����Ŭ���� �����ϴ� �������� (���̵�����)

/*
<�÷��� ��Ī �����ϱ�>
��������� �ϰ� �ȴٸ�, 
�÷����� ������������.
�� ���� �÷����� ��Ī�� ���� 
����ϰ� ���� �ο��� �� �ִ�.
[ǥ����]
�÷��� ��Ī / �÷��� as ��Ī / �÷��� "��Ī" / �÷��� as "��Ī"
*/

SELECT EMP_NAME JEE FROM employee;
--�÷��� ��Ī(=�ʷϻ�, 'JEE')
SELECT EMP_NAME �����, SALARY AS �޿�, BONUS "���ʽ�", (SALARY*12)AS"����(��)",
(SALARY+(SALARY*BONUS))*12AS"�� �ҵ�" FROM employee;

/*
<���ͷ�>
���Ƿ� ������ ���ڿ� (' ')
��ȸ�� (RESULT SET=)����� ��� �࿡ �ݺ��� ��� 
*/

-- EMPLOYEE���̺��� ���, �����, �޿�

SELECT EMP_ID, EMP_NAME, SALARY, '��' AS "����" 
FROM employee;


/*
<���Ῥ���� = ||>
���� �÷������� ��ġ �ϳ��� �÷� ó�� ���� �� �� �ִ�.
*/
--���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ����
SELECT EMP_ID || EMP_NAME || SALARY FROM employee;

-- EMPLOYEE���̺��� ��� ����� ������ ��ȸ�Ѵ�.
-- ������ ���� ����� �������� ����϶�
-- '00'�� ������ '00'���Դϴ�.

SELECT EMP_NAME || '�� ������' || SALARY || '���Դϴ�.' AS"�޿�"
FROM employee;


/*
<DISTINCT>
�ߺ����� - �÷��� ǥ�õ� ������ �ѹ��� �� ��ȸ�ϰ� ������ ���
*/

-- EMPLOYEE �����ڵ� ��ȸ
SELECT DISTINCT JOB_CODE FROM employee;

-- employee�μ��ڵ带 ��ȸ(�ߺ�����)
SELECT DISTINCT dept_code FROM employee;

--SELECT DISTINCT job_code, distinct dept_code
-- �� ó�� ����ϸ� ���� �߻� distinct�� �ѹ� �� ���

SELECT DISTINCT job_code, dept_code
-- �� ó�� ���ÿ��� (job_code, dept_code)��� ������ ���� �ߺ��� ������ ���� �����ش�.
FROM employee;

--==============================================================================
/*
<WHERE��>
��ȸ�ϰ��� �ϴ� ���̺�� ���� Ư�� ���ǿ� �����ϴ� ������ ���� ��ȸ�� �� ����Ѵ�.
���ǽĿ����� �پ��� ������ ����� �����ϴ�
[ǥ����]
(*���� ������ ����� �� ����*)
select �÷�, �÷�, �÷�����
from ���̺�
where ����;
/*
>>�񱳿�����<<
>,<,>=,<= ===> ��Һ�
=(�����)===> ������ ����
!=, ^=, <>, ===> ������ �ٸ���
 */
 
-- employee���� �μ� �ڵ尡 'd9'�� ����� �� ��ȸ( ����÷�)
select * from employee where dept_code = 'D9';
-- ���� �� ��/�ҹ��� ������ ���Ѵ�!!! (=��ɾ�) 'D9'(=������)
-- �ݵ��!!! ***��/�ҹ��� Ȯ�� ��*** ������ ��

-- employee���� �μ� �ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ� ��ȸ
--(my)select * from employee where dept_code = 'D1'; 
SELECT emp_name, salary, dept_code from employee 
where dept_code != 'D1';

-- ������ 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT emp_name, dept_code, salary
from employee
where salary >= 4000000;

-------------------------�ǽ�---------------------------------------
--1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ����(��Ī-> ����) ��ȸ
select emp_name, salary, hire_date, salary*12 ����
from employee
where salary >= 3000000; 

--2. ������ 5õ���� �̻��� ������� �����, �޿�, ����(��Ī-> ����), �μ��ڵ� ��ȸ
select emp_name, salary, salary*12 ����, dept_code
from employee
where salary *12 >= 50000000;
-- where ���� >=50000000; -> ������ �߻�
-- ���� : ��������� from -> where -> select
-- where���ǿ� ���� �κ��̱� ������ ���ǹ� �� �� �� �ִ�

--3. �����ڵ尡  'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
select emp_id, emp_name, job_code, ent_yn
from employee
where job_code != 'J3';

--4. �޿��� 350���� �̻� 600���� ���� �� ��� ����� �����, ���, �޿���ȸ
select emp_name, emp_id, salary
FROM employee
where  salary >= 3500000 AND salary <= 6000000;
--�߰��� and, or�� ������ ������ �� �ִ�.



/*

<and, or ������>

������ ������ ������ �� ���
[ǥ����]
(���� A) and (���� b) -> ���� a�� ���� b ��� �����ϴ� �� �� ������ �´�.
(���� A) or (���� b) ->  ���� a�� ���� b �� �ϳ��� �����ϴ� ���� ������ �´�.

[ǥ����] 
�� ��� �÷� between �ϾȰ� and ���Ѱ�
*/
-- �޿��� 350�� �̻� 600�� ������ �����, ���, �޿�
select emp_name, emp_id, salary
from employee
--where salary >= 3500000 and salary <=6000000
 where salary between 3500000 and 6000000;
 */
 --�޿��� 350�� �̸� 600�� �ʰ� �����, ���, �޿�
select emp_name, emp_id, salary
from employee
where salary < 3500000 or salary > 6000000;
-- where not salary between 3500000 and 6000000;
-- not : �� ���� ������
-- �÷��� �� �Ǵ� beetween �տ� ���� ����

-- �Ի����� '90/01/01' ~ '01/01/01' ����� ��ü ��ȸ
select *
from empliyee
where hire_date >= '90/01/01' and hire_date <='01/01/01';
-- dateŸ�Ե� �񱳿����� ����
--where hire_date between '90/01/01' and '01/01/01';
--=========================

/* 
<like>
���ϰ��� �ϴ� �÷� ���� ������ Ư�� ���Ͽ� ���� �� ��쿡 ��ȸ

[ǥ����]
���� ��� �÷� like 'Ư������';

Ư�� ������ ������ �� ���ϵ�ī���� Ư�������� ���ǵǾ��ִ�.
'%' : ���� ���� �˻� (0�����̻� ���� ��ȸ)
ex) �� �� ��� �÷� �� like '����%' : �񱳴���÷��� �߿��� �ش� ���ڷ� �����ϴ� ���� �� ��ȸ
    �� �� ��� �÷� like '%����' : �񱳴���÷��� �߿��� �ش� ���ڷ� ������ ���� �� ��ȸ
    �� �� ��� �÷� like '%����%' : �񱳴���÷��� �߿��� �ش� ���ڷ� ���Ե� �� ��ȸ
'_' : 1���ڸ� ��ü�ϴ� �˻�
�� ) ���� ��� �÷� like '___����' : �񱳴�� �÷� �� ���� �տ� �ƹ� ���ڳ� n����('_'��ŭ)�� �ִ� ���� ��ȸ
     ���� ��� �÷� like '����_' : �񱳴�� �÷� �� ���� �ڿ� �ƹ� ���ڳ� n����('_'��ŭ)�� �ִ� ���� ��ȸ
     ���� ��� �÷� like '_����_' : �񱳴�� �÷� �� ���� ��/�ڿ� �ƹ� ���ڳ� n����('_'��ŭ)�� �ִ� ���� ��ȸ


*/

-- ����� �� ���� '��'���� ������� �����, �޿�, �Ի���
select emp_name, salary, hire_date
from employee
where emp_name like '��%';

-- ����� �� ���� '��'��� ���ڰ� ���� �� ������� �����, ��ȭ��ȣ ���
select emp_name, phone
from employee
where emp_name like '%��%';

--����� �߿��� �̸��� �߰� ���ڰ� '��'�� ����̸�, ��ȭ��ȣ ��ȸ��
select emp_name, phone
from employee
where emp_name like '_��_';

-- ��ȭ��ȣ�� 3��° ��ȣ�� 1�� ����� ���, �����, ��ȭ��ȣ
select emp_id, emp_name, phone
from employee
where phone like '__1%';

--***!!!����!!!***
-- �̸��� �� _�ձ��ڰ� 3���� �� ����� ���, �̸�, �̸���
select emp_id, emp_name, email
from employee
-- where email like '___%'; ==> ���ϵ�ī��('%','_')���� ������ ������� �Ұ�
-- ���ϵ�ī�� ���ڿ� �Ϲݹ����� ������ ��
-- ������ ���� ����ϰ� ���� ���ϵ�ī�� ���� �տ� ������ Ż�⹮�ڸ� ����
-- escape option�� ����ؼ� ��� (** '%'�� '$' �� � ���ڵ� ������**)
where email like '___\_%' escape '\';
-- �� ������� �ƴ� �̿��� ����� ��ȸ��
select emp_id, emp_name, email
from employee
where not email like '___\_%' escape '\';   

--==================�ǽ�
-- 1. �̸��� '��'���� ������ �����, �Ի���
select emp_name, hire_date
from employee
where emp_name like '__��';

-- 2. ��ȭ��ȣ �� 3�ڸ� 010�� �ƴ� �����, ��ȭ��ȣ
select emp_name, phone
from employee
where not phone like '010%';

-- 3. �̸��� '��'�� ���ԵǾ� �޿��� 240 �̻��� �����, �޿�
select emp_name, salary 
from employee
where emp_name like '%��%' and salary >= 2400000;

-- 4. �μ����̺��� �ؿܿ����μ� �����ڵ�, �μ���
select dept_id, dept_title
from department
where dept_title like '�ؿ�%';


/*
select dept_id, emp_name, job_code, ent_yn
from employee
where job_code != 'J3';
*/
--==========================================================================

/* 
<in> ��
where������ �񱳴�� �÷� ���� ������ ��� �� ��ġ�ϴ���

[ǥ����]
�񱳴���÷� in ('��1', '��2'...)
*/

-- �μ��ڵ尡 d6�̰ų� d8�̰ų� d5�� �μ��� �̸�, �μ��ڵ�, �޿�
select emp_name, dept_code, salary 
from employee
--where dept_code = 'D6' or dept_code = 'D8' or dept_code = 'D5';
 where dept_code in ('D6', 'D8', 'D5');
 
 --=======================
 /*
 <is null & is not null>
 �÷� ���� null�� ���� ��� null���� ���ϱ� ���� �����ڸ� ���
 */
 
select emp_id, emp_name, salary, bonus
from employee
where bonus is null;


select emp_id, emp_name, salary, bonus
from employee
where bonus is not null;

-- ����� ���� ������� �����, ������, �μ��ڵ�
select emp_name, manager_id, dept_code
from employee
where manager_id is null;
-- �μ� ��ġ�� ���� �ʰ� ���ʽ��� ���� ��� �̸�, ���ʽ�, �μ��ڵ�
select emp_name, bonus, dept_code
from employee
where dept_code is null and bonus is not null;

--===============================
/*
���� �鿡 '()'��ȣ�� ��!!! ����ؾ� ��

<������ �켱����>
1. ���������
2. ���Ῥ����
3. �񱳿�����
4. is null / like / in
5. between a and b
6. not
7. and
8. or
*/

-- ���� �ڵ尡 j7�̰ų� j2�� ��� �� �޿��� 200�� �̻� ��� ��� �÷� ��ȸ
select *
from employee
where job_code = 'J7' or job_code = 'J2' and salary >= 2000000;
-- �켱 ������ �߿��ϴ� **!!������!!**
--where (job_code = 'J7' or job_code = 'J2') and salary >= 2000000;

--=========================exercise=============
-- 1. ����� ���� �μ������� ���� �� �����, ���, �μ��ڵ�
select emp_name, emp_id, dept_code
from employee
where manager_id is null and dept_code is null;
  
-- 2. ����(���ʽ� ������) 3õ �̻�, ���ʽ� ���� �ʴ� ���, �����, �޿�, ���ʽ�
select emp_id, emp_name, salary, bonus
from employee
where (salary * 12) >= 30000000 and bonus is null;

-- 3. �Ի��� '95/01/01'�̻� �μ���ġ ���� ���� ���, �����, �Ի���, �μ��ڵ�
select emp_id, emp_name, hire_date, dept_code
from employee
where hire_date >= '95/01/01' and dept_code is null;

-- 4. �޿� 200�� �̻� 500�� ���� ��� �� �Ի����� '01/01/01'�̻� ���ʽ� ���� ���� ���, �����, �Ի���, ���ʽ�
select emp_id, emp_name, salary, hire_date, bonus
from employee
where salary between 2000000 and 5000000 and (hire_date >= '01/01/01') and bonus is null;

/*
select emp_id, emp_name, hire_date, bonus
from employee
where salary >= 2000000 and salary <= 5000000 and hire_date >= '01/01/01 ;
*/

-- 5. ���ʽ��� ���� ���� null�ƴϰ� �̸��� '��'�� ���Ե� ���, �����, �޿�, ���ʽ� ���� ����
/*
select emp_id, emp_name, salary, bonus, salary *12
from employee
where ;
*/
select emp_id, emp_name, salary, (salary + (salary * bonus))*12
from employee
where (salary + (salary * bonus))*12 is not null and emp_name like '%��%';