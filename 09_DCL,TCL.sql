/*
<DCL : ������ ���>
�������� �ý��� ���� �Ǵ� ��ü���� ������ �ο��ϰų� ȸ���ϴ� ����
> �ý��� ���� : DB�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
> ��ü���ٱ��� : Ư�� ��ü���� ������ �� �ִ� ����

create user ������ identified by ��й�ȣ;
gract ���� (resource, connect) to ����;  
*/
--�������� �ݵ�� ���迡 ���´�!!

select * 
from role_sys_privs;

/*
<TCL : Ʈ����� ���>
*Ʈ�����
- ������ ���̽��� ���� �������
- �������� ������� (DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
  DML�� �Ѱ��� ������ �� Ʈ������� �������� �ʴ´ٸ� Ʈ������� ���� ����
                       Ʈ������� �����Ѵٸ� �ش� Ʈ����ǿ� ��� ó��
  commit�ϱ� ������ ������׵��� �ϳ��� Ʈ����ǿ� ��´�.                     
- Ʈ����ǿ� ����� �Ǵ� SQL : insert, update, delete

commit (Ʈ����� ���� ó�� �� Ȯ��)
rollback (Ʈ����� ���)
savepoint (�ӽ�����)

- commit  :  �� Ʈ����ǿ� ����ִ� ������׵��� ���� db�� �ݿ���Ű�ڴٴ� �ǹ�
- rollback : �� Ʈ����ǿ� ����ִ� ������׵��� ����(���) �� �� ������ commit �������� ���ư�
- savepoint ����Ʈ �� : ���� ������ �ش� ����Ʈ������ �ӽ������� �صδ� ��
*/

DROP TABLE emp_01;

CREATE TABLE emp_01
as (select emp_id, emp_name, dept_title
    from employee
    join department on (dept_code = dept_id));
    
SELECT
    * FROM emp_01;
    
--���200�� ����
delete from emp_01
where emp_id=200;

delete from emp_01
where emp_id=201;

ROLLBACK;

SELECT * FROM emp_01;

--��� 200,201����
delete from emp_01
where emp_id=200;

delete from emp_01
where emp_id=201;
commit;

ROLLBACK;
SELECT * FROM emp_01;

--------------------------
/*
db�� ���ư���
������ ���� ������ �ȵ�
*/
--------------------------

--217,216,214��� ����
delete from emp_01
where emp_id in (217, 216, 214);

SELECT * FROM emp_01;

SAVEPOINT sp;

insert INTO emp_01
VALUES(801, '�踻��', '���������');

delete from emp_01
where emp_id = 210;

SELECT * FROM emp_01;

ROLLBACK to sp;
--------------------------
delete from emp_01
where emp_id = 210;

create TABLE test(
    tid NUMBER
); 

rollback;
--------------------------
--DDL�� (create, alter, drop)�� �����ϴ� ���� ���� Ʈ����ǿ� �ִ� ������׵��� 
--������ commit�� �ȴ� (���� db�ݿ��� �ȴ�.)
--��, ddl�� ������ ������׵��� �ִٸ� ��Ȯ�ϰ� �Ƚ��ϰ� �ض�!
