/*
DQL(QUWRY ������ ���Ǿ�) : SELECT
DML (MAINPULATION ������ ���۾�) : insert, update, delete
DDl (DEFINITION ������ ����): CRTATE, ALTER, DROP
DCL (CONTROL ������ ����) : GRANT, REVOKE
TCL (TRANSACTION Ʈ����� ����): COMMIT, ROLLBACK

<DML> ������ ���� ���
���̺� ���� ���� <insert>�ϰų�, ����<update>�ϰų� ����<delete>�ϴ� ����
*/

-- crud 4������ ���� �߿�

/*
1. insert
���̺� ���ο� ���� �߰��ϴ� ����
[ǥ����]
1) insert into ���̺�� values(��,��,��..)
���̺��� ��� �÷��� ���� ���� ���� �����ؼ� �� ���� insert�ϰ��� �� ��
�÷��� ������ ���Ѽ� values�� ���� �����ؾ� ��

�����ϰ� ���� ������ ���  -> not enough values����
���� �� ���� ������ ��� -> too many values
*/

 select * from employee;
 insert into employee
 values (900, '�̼ұ�', '880914-1456789', 'SG8809@naver.com', 01075966990',
        'D7', 'J5', '4000000, 0.2, 200, SYSDATE, NULL, 'N');
        
        /*
**�ݵ�� �˾ƾ���** 2) insert into ���̺� �� (�÷�, �÷�, �÷�) values (��, ��, ��)
        ���̺� ���� ������ �÷��� ���� ���� insert �� �� ���
        �׷��� �� �� ���� �߰�, ���� �� �� �÷� �⺻������ null�� ��
        =>
        
        */
        
insert into employee (emp_id, emp_name, emp_no, job_code, hire_date)
values (901, '������', '440701-1234567', 'J7', sysdate); 

select*from employee;

insert
    into employee
    ( emp_id,
     emp_name,
     emp_no,
     job_code,
     hire_date)
values
    (902,
    '�谳��',
    '870105-224510',
    'J7',
    sysdate
);
---------------------------------------------------------------
/*
3) insert into ���̺�� (��������);
values�� ���� ���� ����ϴ� �� ���
���������� ��ȸ �� ������� ��ä�� insert����
*/
---------------
--���̺� ���� �����
create table emp_01(
    emp_id number,
    emp_name varchar2(20),
    dept_title varchar2(20)
    );
    
select * from emp_01;
insert into emp_01 (select emp_id, emp_name, dept_title
                    from employee
                    left join department on (dept_code = dept_id));

--------------------------------

/*
2. insert all
�� �� �̻��� ���̺� ���� insert�� ��
�� �� ���Ǵ� ���������� ������ ���
*/
CREATE TABLE emp_dept
as (select emp_id, emp_name, dept_code, hire_date
        from employee
        where 1=0);

CREATE TABLE emp_manager
as (select emp_id, emp_name, manager_id
    from employee
    where 1=0);
    
--�μ��ڵ尡 D1�� ����� ���, �̸� ,�μ��ڵ�, �Ի���, ������
select emp_id, emp_name, dept_code, hire_date, manager_id
from employee
where dept_code = 'D1';
/*
[ǥ����]
insert all
into ���̺��1 values(�÷�, �÷�, �÷�...)
into ���̺��2 values(�÷�, �÷�..)
��������;
*/

insert all
    into emp_dept values (emp_id, emp_name, dept_code, hire_date)
    into emp_manager values (emp_id, emp_name, manager_id)
        (select emp_id, emp_name, dept_code, hire_date, manager_id
        from employee
        where dept_code = 'D1');
        
SELECT
    * FROM
    emp_dept;
    
select * from emp_manager;
-------------------------------------------------
/*
    3. update 
    ���̺� ��ϵǾ� �ִ� ������ �����͸� �����ϴ� ����
    [ǥ����]
    update ���̺��
    set �÷� = ��,
        �÷� = ��,
        ... --and�� ������ �ƴ�, �׳�','�� �����Ѵ�.
[where ����] --> ������ ��ü ��� ���� �����Ͱ� ����
*������Ʈ �ÿ��� �������� �� Ȯ���ؾ� �Ѵ�.
*/

create table dept_table
as (select * from department);

select*from dept_table; 
-- d9 �μ��� �μ����� '������ȹ��'���� ����
update dept_table
set dept_title = '������ȹ��'
where dept_id = 'D9';

create table emp_salary
as (select emp_id, emp_name, dept_code, salary, bonus
    from employee);

-- emp_salary ���̺��� ����
-- ���ö ����� �޿��� 100�������� ����
update emp_salary
set salary = 1000000
where emp_name = '���ö';

select*from emp_salary
where emp_name = '���ö';
-- ������ ����� �޿��� 700�������� ���ʽ� 0.2
update emp_salary
set salary = 7000000,
    bonus = 0.2
where emp_name = '������';    

-- ��ü����� �޿��� ���� �޿��� 10% �λ�� �ݾ�����

update emp_salary
set salary = salary * 101;
  
SELECT
    * FROM emp_salary;
    
/*
update ���̺��
set �÷��� = (��������)
where ����
*/
--���� ����� �޿��� ���ʽ� ���� ����� ����� �޿��� ���ʽ� ������ ����
update emp_salary
set salary = (select salary
                from emp_salary
                where emp_name = '�����')
     bonus = (select bonus
                from emp_salary
                where emp_name = '�����')
where emp_name = '����';                

SELECT
    * FROM emp_salary
where emp_name = '����' or emp_name = '�����';    

--���߿�
update emp_salary
    set (salary, bonus) = (select salary, bonus
                from emp_salary
                where emp_name = '�����')
where emp_name = '����';          

--asia ������ �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� ����
/*update emp_salary
    set (salary, bonus ) = (select salary, bonus *0.3
                from emp_salary
                where asia1, asia2, asia3 )
where local_name = asia1, asia2, asia3 ; */

--asia ����
select emp_id, emp_name
from emp_salary
join department on (dept_code = dept_id)
join location on (location_id= local_code)
where local_name like 'ASIA%';


--�ش� ����� ���ʽ� �� 0.3
update emp_salary
set bonus = 0.3
where emp_id in (select emp_id
                    from emp_salary
                    join department on (dept_code = dept_id
                    join location on (location_id = local_code)
                    where local_name like 'ASIA&');
                    
COMMIT;
------------
/*
4. delete
���̺� ��ϵ� �����͸� �����ϴ� ����( �� �� ������ ������ �ȴ�)

[ǥ����]
delete from ���̺��
[where ����]--> where �� ���� ���ϸ� ��ü �� ������


*/

delete from employee;

SELECT
    * FROM employee;
    rollback;
    
    delete from employee
    where emp_name = '�̼ұ�';
 
 delete from employee
    where emp_id = '901';    
    
    commit;
    
DELETE FROM department
where dept_id = 'D1';
--D1�� ���� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ ������ ���� �ʴ´�.

