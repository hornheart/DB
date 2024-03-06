/*
<PL/SQl>
procedure language extecsion to sql
����Ŭ ��ü�� ���� �Ǿ��ִ� ������ ���
sql ���� ������ ������ ���� if����, for, while�ݺ� ���� �����Ͽ� sql������ ����

�ټ��� sql���� �ѹ��� ����

*PL/SQL����
-[�����] : declare�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
- ����� : begin���� ����, sql�� �Ǵ� ���(���ǹ�, �ݺ���)���� ������ ����ϴ� �κ�
- [����ó����] : exception���� ����, ���ܹ߻� �� �ذ��ϱ� ���� ����


*/

set SERVEROUTPUT on;

--hello oracle���
begin
--system.out.println("hello oarcle")�ڹ�
dbms_output.put_line('hello oracle');
end;
/

---------------------------------------------------------
/*
1. declare�����
���� �� ��� ���� �ϴ� ���� (���� ���ÿ� �ʱ�ȭ ����)

�Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, rowŸ�Ժ���

1_1) �Ϲ�Ÿ�� ���� ���� �� �ʱ�ȭ
[ǥ����] ������ [constact] �ڷ��� [:=��];
*/
--�ڹٶ��, �ʵ� or { }
DECLARE
--(����δ� ������ ����� ����)
    eid NUMBER;
    ename VARCHAR2(20);
    pi CONSTANT NUMBER := 3.14;
BEGIN
    eid := 800;
    ename := '����';
    
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('pi : ' || pi);      
end;
/

DECLARE
--(����δ� ������ ����� ����)
    eid NUMBER;
    ename VARCHAR2(20);
    pi CONSTANT NUMBER := 3.14;
BEGIN
    eid := &��ȣ;
    ename := '&�̸�';
    
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('pi : ' || pi);      
end;
/
---------------------------------------------------------
--1_2) ���۷���(=��������) Ÿ�� ���� ���� �� �ʱ�ȭ ( � ���̺��� � ������Ÿ���� �����ؼ� �� Ÿ������ ����)

DECLARE
    eid employee.emp_id%type;
    ename employee.emp_name%type;
    sal employee.salary%type ;
BEGIN
    --eid := 800;
    --ename := '����';
    --sal := 100000;
--���200�� ���, �����, �޿� ������ ����

    SELECT emp_id, emp_name, salary
    into eid, ename, sal
    from employee
    where emp_id=200;
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('sal : ' || sal);      
end;
/

DECLARE
    eid employee.emp_id%type;
    ename employee.emp_name%type;
    sal employee.salary%type ;
BEGIN
    --eid := 800;
    --ename := '����';
    --sal := 100000;
--���200�� ���, �����, �޿� ������ ����

    SELECT emp_id, emp_name, salary
    into eid, ename, sal
    from employee
    where emp_id=&���;
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('sal : ' || sal);      
end;
/
--------------------�ǽ�--------------------
/*
���۷���Ÿ�Ժ����� 
eid, ename, jcode, sal, dtitle�� ����
�� �ڷ��� employee (emp_id, emp_name, job_code, salary,
department(dept_title)�� ����
����ڰ� �Է��� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� ������ ��� ���
*/

DECLARE
    eid employee.emp_id%type;
    ename employee.emp_name%type;
    ecode employee.job_code%type;
    sal employee.salary%type ;
    dtitle department.dept_title%TYPE;
BEGIN
    SELECT emp_id, emp_name, job_code, salary, dept_title
    into eid, ename, ecode, sal, dtitle
    from employee
    join department on (dept_code = dept_id)
    where emp_id='&���';
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('ecode : ' || ecode);  
    dbms_output.put_line('sal : ' || sal);
    dbms_output.put_line('dtitle : ' || dtitle);
end;
/
----------------------------------------
/*
--1_3) rowŸ�� ���� ����
--    ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
--    [ǥ����] ������ ���̺��%rowtype;
*/
DECLARE
    e employee%rowtype;
   
BEGIN
    SELECT *
    into e
    from employee
    
    where emp_id='&���';
    dbms_output.put_line('����� : ' || e.emp_name);
    dbms_output.put_line('�޿� : ' || e.salary);
    dbms_output.put_line('���ʽ� : ' || nvl(e.bonus,0);
end;
/
----------------------------------------
/*
--2. begin�����
--<���ǹ�>
-- 1) if���ǽ� then ���೻�� end if;
(if�� �� �ܵ����� ���)
--�Է¹��� ����� �ش��ϴ� ���, �̸�, �޿�, ���ʽ� ���
--��, ���ʽ� ���� ���� ��� ���ʽ��� ��� �� '���ʽ��� ���޹��� ���� ����Դϴ�'���
*/

DECLARE
    eid employee.emp_id%type;
    ename employee.emp_name%type;
    
    sal employee.salary%type ;
    bonus employee_bonus%TYPE;
BEGIN
    SELECT emp_id, emp_name, salary, nvl(bonus,0)
    into eid, ename, sal, bonus
    from employee
   
    where emp_id=&���;
    dbms_output.put_line('��� : ' || eid);
    dbms_output.put_line('�̸� : ' || ename);
    dbms_output.put_line('�޿� : ' || sal);  
    if bonus = 0
        then dbms_output.put_line('���ʽ��� ���޹��� ���� ����Դϴ�.' );
    end if;
    dbms_output.put_line('���ʽ��� : ' || bonus);
end;
/

--2) if ���ǽ� then ���೻�� else ���೻�� end if; (if-else)
DECLARE
    eid employee.emp_id%type;
    ename employee.emp_name%type;
    
    sal employee.salary%type ;
    bonus employee_bonus%TYPE;
BEGIN
    SELECT emp_id, emp_name, salary, nvl(bonus,0)
    into eid, ename, sal, bonus
    from employee
   
    where emp_id=&���;
    dbms_output.put_line('��� : ' || eid);
    dbms_output.put_line('�̸� : ' || ename);
    dbms_output.put_line('�޿� : ' || sal);  
    if bonus = 0
        then dbms_output.put_line('���ʽ��� ���޹��� ���� ����Դϴ�.' );
    else
        dbms_output.put_line('���ʽ��� : ' ||( bonus*100||'%'));
    end if;
    dbms_output.put_line('���ʽ��� : ' || bonus);
end;
/

--------------------�ǽ�--------------------
--DECLARE
--���۷���Ÿ�Ժ��� (eid, ename, dtitle, ncode)
--�����÷�        (emp_id, emp_name, dept_title, national_code)
--�Ϲ�Ÿ�Ժ���(team���ڿ�) <==����, �ؿ� �и� �ؼ� ���� ����
--begin
--����ڰ� �Է��� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����
--
--ncode ���� ko�� ��� --> team --> '������' ����
-- �ƴϸ�, --> team --> '�ؿ���' ����
--
-- ���, �̸�, �μ�, �Ҽӿ� ���� ���
--end;
--/
DECLARE
    eid employee.emp_id%TYPE;
    ename employee.emp_name%TYPE;
    dtitle department.dept_title%TYPE;
    ncode national.national_code%TYPE ;
    team varchar2(10);
BEGIN
    SELECT emp_id, emp_name, dept_title, national_code
    into eid, ename, dtitle, ncode
    from employee
    join department on (dept_code = dept_id)
    join location on (location_id = local_code)
    where emp_id=&���;
    
    if ncode = 'KO'
        then team := '������';
    else
        then team := '�ؿ���';
    end if;    
        
    dbms_output.put_line('��� : ' || eid);
    dbms_output.put_line('�̸� : ' || ename);
    dbms_output.put_line('�μ� : ' || dtitle); 
    dbms_output.put_line('�Ҽ� : ' || team);
     
end;
/
----------------------------------------
/*
--3) else if ���ǽ�
if ���ǽ�1 then ���೻��1 else if ���ǽ�2 then ���೻��2...[else ���೻��] end if;
*/
DECLARE
    score number;
    grade varchar2(1);
BEGIN
    score := &����;
        
    if score >= 90 then grade := 'A';
    elsif score >= 80 then grade := 'B';
    elsif score >= 70 then grade := 'C';
    elsif score >= 60 then grade := 'D';
    else
        grade := 'F';
    end if;    
    
    dbms_output.put_line('����� ������ ' || score || '���̰�, ������ ' || grade ||'�����Դϴ�.');
     
end;
/

--------------------�ǽ�--------------------

--����ڿ��� �Է¹��� ����� ����޿� ��ȸsal ���� ����
--500�� �̻�'���'
--400�� �̻�'�߱�'
--300�� �̻�'�ʱ�'
--'�ش� ����� �޿������ XX�Դϴ�.'
/*
DECLARE
    salary number;
    grade varchar2(1);
BEGIN
    salary := &�޿�;
        
    if salary >= 5000000 then grade := '���';
    elsif salary >= 4000000 then grade := '�߱�';
    elsif salary >= 3000000 then grade := '�ʱ�';
   
    end if;    
    
    dbms_output.put_line('�ش� ����� �޿��� ' || salary || '���̰�, ����� ' || grade ||'�Դϴ�.');
     
end;
/
*/--�ٽ��ϱ�


----------------------------------------
/*
--4) case�񱳴���� when���� �񱳰�1 then ����� when �񱳰�2 then �����... else�����end;
DECLARE
    emp employee%rowtype;
    dname varchar2(30);
BEGIN
    SELECT *
    into eip
    from employee
    
    where emp_id=&���;
    dname := case emp.dept_code
        when 'D1' then '�λ���'
        when 'D2' then 'ȸ����'
        when 'D3' then '��������'    
        when 'D4' then '����������'
        when 'D9' then '�ѹ���'  
         else '�ؿܿ�����'
    end;     
    dbms_output.put_line(emp.emp_name||'�� ' || dname || '�Դϴ�.');
     
end;
/

--<�ݺ���>
/*
1) basic loop��
[ǥ����]
loop
�ݺ������� ������ ����;
*�ݺ����� �������� �� �ִ� ����
end loop;

(���� ���*breakó�� �ݺ����� �������� �� �ִ� ����)
1) if ���ǽ� then exit; end if;
2) exit when ���ǽ�;

*/

DECLARE
    I number := 1;
   
BEGIN
  loop
     dbms_output.put_line(I);
     I := I + 1;
     --if I = 6 then exit; end if;
     exit when I = 6;
  
    end loop;     
   
     
end;
/

-----------------------------------
/*
2) for loop�� (�ݺ�Ƚ���� �������� �� ���� ��)
[ǥ����]
for ���� in [reverse] �ʱⰪ... ������
loop
    �ݺ������� ������ ����;
end loop;

*/
BEGIN
  for I in 1..5
    loop
        dbms_output.put_line(I);
  
    end loop;     
   
     
end;
/
BEGIN
  for I in reverse 1..5
    loop
        dbms_output.put_line(I);
  
    end loop;     
   
     
end;
/

drop table test;

create table test (
    tno number primary key,
    tdate date
); 

create SEQUENCE seq_tno
start with 1
increment by 2
maxvalue 1000
nocycle
nocache;

begin
    for I in 1..100
    loop
        insert into test values (seq_tno.nextval, sysdate);
    end loop;
end;
/

select * from test;



--------------------------
/*
while loop��

[ ǥ����]
 while �ݺ����� ����� ����
 loop
    �ݺ������ϴ� ����
 end loop;
 
*/

DECLARE
    I number := 1;
   
BEGIN
  while I < 6
  loop
     dbms_output.put_line(I);
     I := I + 1; 
    end loop;     
    
end;
/

--------------------------
/*
3.����ó����
���� (exception) : ���� �� �����ϴ� ����

exception
    when ���ܸ�1 then ����ó������1;
    when ���ܸ�2 then ����ó������2;
    ...
    *�ý��� ���� (����Ŭ���� �̸� ������ ����)
    - no_data_found : select�� ����� �� �൵ ���� ��
    - too_many_rows : select�� ����� ������ �� ���
    - zero_divide : 0���� ���� ��
    - dup_var_on_ index : unique �������ǿ� ����� ���
    */
    
    --����ڰ� �Է��� ���� ������ ���� ��� ���
DECLARE
   result number;
BEGIN
     
   result := 10 / &����;
   dbms_output.put_line('��� : ' || result);
   
exception
  when zero_divide then dbms_output.put_line('������ ���� �� 0���� ���� �� ����');
    
    
end;
/   

--unique�������� ����
alter table employee add primary key (emp_id);

BEGIN
   update employee
     SET emp_id = '&�����һ��'  
    where emp_name = '���ö';
exception
    when dup_val_on_index then dbms_output.put_line('�̹� �����ϴ� ����Դϴ�.');
end;
/   
    
