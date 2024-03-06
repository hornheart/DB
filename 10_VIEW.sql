/*
<view>
select�� (������)�� ������ �� �� �ִ� ��ü
(���� ����ϴ� select���� �����صθ� �� select���� �Ź� �ٽ� ��� �� �ʿ䰡 ����.)
�ӽ� ���̺� ���� ���� (���� �����Ͱ� ����ִ� �� �ƴ� => ������ ���̺�)
*/

-- �ѱ����� �ٹ��ϴ� ��� ���, �̸�, �μ���, �޿�, �ٹ�������
select emp_id, emp_name, dept_title, salary, national_name
FROM employee
join department on (dept_code = dept_id)
join location on (location_id = local_code)
join national USING (national_code)
where national_name = '�ѱ�';

-------------------------------
/*
1. view�������
[ǥ����]
create view���
as ��������
*/
--!! view���� table���� ������ ��Ȯ�� �����ؾ� �Ѵ�!!

--tb
--vw

create view vw_employee
as select emp_id, emp_name, dept_title, salary, national_name
    FROM employee
    join department on (dept_code = dept_id)
    join location on (location_id = local_code)
    join national USING (national_code);

grant CREATE VIEW to kh;

SELECT
    * FROM vw_employee;
    
    --���� ����Ǵ� ���� �Ʒ��� ���� ���������� ����ȴٰ� �� �� �ִ�.
    
SELECT
    * FROM (select emp_id, emp_name, dept_title, salary, national_name
    FROM employee
    join department on (dept_code = dept_id)
    join location on (location_id = local_code)
    join national USING (national_code));
    
--�ѱ����� �ٹ��ϴ� ��� ���, �̸�, �μ���, �޿�, �ٹ�����
SELECT
    * FROM vw_employee
where national_name = '�ѱ�';

SELECT
    * FROM vw_employee
where national_name = '�Ϻ�';


-----------
/*
create or replace
����ų�
*/

-----------
/*
*�� �÷��� ��Ī�ο�
���������� select���� �Լ����̳� ���������� ����Ǿ����� ��� �ݵ�� ��Ī ����
*/

CREATE or REPLACE view vw_emp_job
as select emp_id, emp_name, job_name,
        decode (substr (emp_no, 8, 1), '1', '��', '2', '��') as "����",
        extract (year from sysdate) - extract(year from hire_date) as "�ٹ����"
    from employee
    JOIN job using (job_code);
    
SELECT
    * FROM vw_emp_job;    
    
CREATE or REPLACE view vw_emp_job (���, �̸�, ���޸�, ����, �ٹ����)
as select emp_id, emp_name, job_name,
        decode (substr (emp_no, 8, 1), '1', '��', '2', '��'), 
        extract (year from sysdate) - extract(year from hire_date) 
    from employee
    JOIN job using (job_code);    
    
 SELECT
    * FROM vw_emp_job
 WHERE �ٹ���� >= 20;
 
 drop view vw_emp_job;
 
 ------------------------
 --������ �並 ���� dml(insert, update, delete)��밡��
 --�並 ���� �����ؼ� ���� �����Ͱ� ��� �ִ� ���̺� �ݿ�
 
 CREATE or REPLACE view vw_job
 as select job_code, job_name
 from job;
 
  SELECT
    * FROM vw_job;
    
  SELECT
    * FROM job;    
    
INSERT into vw_job VALUES('J8', '����');


UPDATE vw_job
set job_name = '�˹�'
where job_code = 'J8';
--select�� �ʹ� ������ ���? ��?
------------
/*
*dml��ɾ�� ������ �Ұ����� ���
1) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� not null���������� �����Ǿ� �ִ� ���
3) �������� �Ǵ� �Լ������� ���ǰ� �Ǿ��ִ� ���
4) �׷��Լ��� group by���� ���Ե� ���
5) distinct������ ���Ե� ���
6) join�� �̿��ؼ� �������̺��� ����

��κ� ��� ��ȸ�� ������!!
�׳� �並 ���� dml�� �Ⱦ��� ���� ����
Data Manipulation Language
�����͸� �����ϴ� ��ɾ�
*/
/*
view�ɼ�

[��ǥ��]
create [or replace] [force | noforce] view ���
as ��������
[with check option]
[with read only];

1) or replace : ������ ������ �䰡 ���� ��� ����, �������� ���� ��� ����
2) force | noforce
    > force : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǵ���
    > noforce : ���������� ����� ���̺��� �����ϴ� ���̺��̿��� �� �䰡 ����
3) with check option : dml�� ���������� ����� ���ǿ� ������ �����θ� dml�� �����ϵ���
4) with read only : �信 ���ؼ� ��ȸ �� �����ϵ���
*/
--2)force | noforce
 
 CREATE or REPLACE NOFORCE view vw_emp
 as select Tcode, Tname, Tcontent
 from TT;

 
 --���������� ��� �� ���̺��� �������� �ʾƵ� �䰡 �켱�� ����� �ȴ�
  CREATE or REPLACE FORCE view vw_emp
 as select Tcode, Tname, Tcontent
 from TT;
 
SELECT
    * FROM vw_emp;
/*    
CREATE 
 from TT;    
    
SELECT
    * FROM vw_emp;    
 
 */--������
 
 --3) with check option : ���������� ����� ���ǿ� �������� �ʴ� ������ ���� �� ���� �߻�
 CREATE or REPLACE view vw_emp
 as select *
    FROM employee
    where salary
    >= 3000000;
 
 SELECT
    * FROM vw_emp;   
    
    --200����� �޿� 200������ ����
UPDATE vw_emp
set salary = 2000000
where emp_id = 200;

ROLLBACK;

--4) with read only : �信 ���� ��ȸ �� �����ϵ���
create or REPLACE view vw_emp
as SELECT emp_id, emp_name, bonus
    from employee
    where bonus is not null
    WITH read only;
   
 SELECT
    * FROM vw_emp;   
    
delete
from vw_emp
where emp_id = 200;