
 select emp_id, emp_name, salary -----------(3)
 from employee -----------------------------(1)
 where dept_code is null; ------------------(2)
 
  /*
  
  <order by ��>
  select �� �߿� ���� ������ �ٰ� �ۼ�,
  ������� ���� ���� �������� �����Ѵ�.
  
  [ǥ����]
  select  ��ȸ�� �÷�...
  from    ��ȸ�� ���̺�
  where   ���ǽ�
  order by ���ı����� �� �÷��� | ��Ī | �÷����� [asc | desc] [null first | null last]
  **!!'[ ]'!!** ���ȣ ���� ����
  - asc : ��������
  - desc : ��������
  
  -- null�� �⺻������ ���� ū ������ �з� �� ���� 
  - nulls fitst : �����ϰ� ���� �÷� ���� null�� ���� ��� �ش� ������ ���� �տ� ��ġ 
  (desc�� �� �⺻��)
  - nulls last : �����ϰ� ���� �÷� ���� null�� ���� ��� �ش� ������ ���� �������� ��ġ
  (asc�� �� �⺻ ��)
  */
  
  select *
  from employee --(';'���� ��, ���Ŀ� ������ �� �϶�)
 -- ORDER BY bonus; (�⺻���� ��������)
  ORDER BY bonus asc;
 --  ORDER BY bonus asc nulls first; (desc�϶�)
  order by bonus desc, salary asc; --nulls first;
  --���ı��ؿ� �÷� ���� ������ ��� �� ���� ������ ���� �������� ������ �� �ִ�.
  
  -- �� ����� �����, ����(���ʽ� ����) ��ȸ( �� ���� ������ �������� ����)
  select emp_name, salary * 12 -- (as "����")
  from employee
--  order by salary * 12 desc;
  --order by ���� desc;
  order by 2 desc;
  
  -- =====================
  /*
  <�Լ� FUNCTION>
   ���޵� �÷� ���� �о�鿩 �Լ��� ���� �� ����� ��ȯ
   
   - ������ : n���� ���� �о�鿩 n���� ��� ���� ���� (�� �ึ�� �Լ� �������� ��ȯ)
   - �׷����� : n���� ���� �о�鿩 1���� ��� ���� ���� (�׷��� ���� �׷캰�� �Լ� �������� ��ȯ)
  
  >> select ���� ������ �Լ��� �׷��Լ��� �Բ� ������� ����!!!
  WHY?
  (group function�� ��� ���� 1��)
  ��� ���� ������ �ٸ���.
    
  >> �Լ����� ����� �� �ִ� ��ġ : select�� where�� order by�� group by�� having��
  */
  
  --=================================<������ �Լ�>==============================
  /* 
  <���� ó�� �Լ�>
   * length( �÷� | '���ڿ�') : �ش� ���ڿ��� ���ڼ��� ��ȯ
   * lengthb( �÷� | '���ڿ�') : �ش� ���ڿ��� ����Ʈ���� ��ȯ
   
   '��', '��', '��' �ѱ��� ���� �� 3byte
   ������, ����, Ư������ �� 1byte
   */
   
   select LENGTH('����Ŭ'), lengthb('����Ŭ')
   from dual;
   
   select length('ORACLE'), lengthb('ORACLE')
    from dual;
    
   select emp_name, length(emp_name), lengthb(emp_name), email, length(email), lengthb(email)
   from employee;
   
   ---------------------------------------
   /*
   *instr
   ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
   instr(�÷� | '���ڿ�', 'ã�����ϴ� ����', ['ã�� ��ġ�� ���۰�', ����])
   */
   
   select instr('AABAACAABBAA', 'B')
   from dual;
   -- ���ʿ� �ִ� ù B�� 3��° ��ġ�� �ִٰ� ����
   
   -- ã�� ��ġ ���� �� : 1
   -- ���� : 1 => �⺻��
    select instr('AABAACAABBAA', 'B', 1)
   from dual;
   
   select instr('AABAACAABBAA', 'B', -1)
   from dual;
   -- �ڿ��� ã����, ������ �а� �˷��ش�.
   
   select instr('AABAACAABBAA', 'B', 1, 3)
   from dual;
   --overloading�Ѱ���
   
   select email, instr(email, '_', 1, 1) as "LOCATION", instr(email, '@') as "@��ġ"
   from employee;
   
   -----------------------------------------------------------
   /*
   
   *substr /***!!!���� ���!!!***/
   ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
   SUBSTR(string, position, [length])
   - string : ����Ÿ���� �÷� | '���ڿ�'
   - position : ���ڿ� ������ ���� ��ġ�� ��
   - length : ���� �� ���� ���� (�����ϸ� ������)
   */
   
   select substr ('SHOWMETHEMONEY', 7) from dual; --7��° ��ġ���� ������
   select substr ('SHOWMETHEMONEY', 5, 2) from dual;
   
   --SHOWME
   
   select substr ('SHOWMETHEMONEY', 1, 6) from dual;
   select substr ('SHOWMETHEMONEY', -8,3) from dual;
   
   select emp_name, emp_no
   from employee;
   
   select emp_name, emp_no, substr(emp_no, 8, 1) as "����"
   from employee;
   
   --����� �� ������鸸 emp_name, emp_no
   select emp_name, emp_no
   from employee
   where substr (emp_no, 8, 1)= '2' or substr(emp_no, 8, 1)= '4';
    
   --����� �� ska����鸸 emp_name, emp_no
   select emp_name, emp_no
   from employee
   where substr (emp_no, 8, 1)= '1' or substr(emp_no, 8, 1)= '3'
   order by emp_name;
   
   -- �̸��� ���̵� �κ� �� ����
   select emp_name, email, substr(email, 1, instr(email, '@') -1)
   from employee;
    -- ��� ��Ͽ��� �����, �̸���, ���̵� ��ȸ
    -- �Լ� ��ø ��� ����
    
---------------------------------------------------------------------------
/*
*lpad / rpad (**!!java!!**���� ����)
���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ ����

 [ǥ����]
 lpad / rpad (string, ���������� ��ȯ �� ������ ���� [�����̰��� �ϴ� ����])
 ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���� n���� ��ŭ�� ���ڿ��� ��ȯ
*/
---------------------------------------------
--20��ŭ�� ���� �� email�÷� ���� ���������� �����ϰ� ������ �κ��� �������� ä��
select emp_name, lpad(email, 20, '#')
from employee;
   
 select emp_name, rpad(email, 20, '#')
 from employee;  
 
 select rpad('910524-1', 14, '*')
 from dual;
 
 --������� �����, �ֹε�Ϲ�ȣ ��ȸ("910524-1******")
 /*
 elect substr (emp_no, 1, 8)
 lpad (emp_no, 14, '*')
 from employee;
 */
 select emp_name, substr(emp_no, 1, 8) ||'******'
 from employee ;
 
 select emp_name, rpad(substr(emp_no, 1, 8), 14, '*')
 from employee ;
 
  ---------------
  /*
   * ltrim / rtrim
   ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
   ltrim / rtrim (string, [�����ϰ��� �ϴ� ���ڵ�])
   
   ���ڿ����� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
   */
   
   select ltrim('     K   H')--�տ��� ���� �ٸ� ���ڰ� ���� �� ������ ��������
   from dual;--(���� ���� ���Ŷ�� �����ϸ� ����)
   
    select ltrim('123123KH123', '123')
    from dual;
    
    select ltrim('ACABACCKH', 'ABC') --�����ϰ��� �ϴ� ���ڴ� ���ڿ��� �ƴ� ���ڵ�
    from dual; --���ڵ�!!
   
   select rtrim('574185KH123', '0123456789')
    from dual;
     select ltrim('574185KH123', '0123456789')
    from dual;--���� ������ ���غ���!!!
    
    /*
    *trim
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    trim([leading | trailing | both] �����ϰ��� �ϴ� ���ڿ� from ���ڿ�)
    */
    
 select trim('     K     H   ') from dual; --���ʿ� ���� ����
  select trim('Z' FROM 'ZZZZKHZZZZZZZZ') from dual;--���ʿ� Ư������ ����
select trim(LEADING'Z' FROM 'ZZZZKHZZZZZZZZ') from dual;    
select trim(TRAILING'Z' FROM 'ZZZZKHZZZZZZZZ') from dual; 
    select trim(BOTH'Z' FROM 'ZZZZKHZZZZZZZZ') from dual; 
    ---------------------------------------------
/*
*lower / upper / initcap
lower : �ҹ��ڷ� �����ϴ� ���ڿ� ��ȯ
upper : �빮�ڷ�
initcap : ���� ���� ù ���ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
*/

select lower('Welcome To My World') from dual; 
 select upper('Welcome To My World') from dual; 
  select INITCAP('welcome wo my world') from dual; 
  
---------------------------------
/*
*concat
���ڿ� 2�� ���� �޾� 1���� ��ģ �� ��ȯ
concat (string1, string2)
*/

--2���� ���ڿ� �� ����
select concat('������', 'ABC') from dual;
select '������' || 'ABC' from dual;
---------------

/*
*replace
Ư�� ���ڿ����� Ư�� �κ��� �ٸ� �κ����� ��ü
replace(���ڿ�, ã�� ���ڿ�, ���� �� ���ڿ�)
*/

select email, replace(email, 'KH.or.kr', 'gmail.com') 
from employee;

------------------------------------------------------------------

/*
*abs
<���� ó�� �Լ�>
������ ���밪�� ���ϴ� �Լ�
*/

select abs(-10), abs(-6.3) 
from dual;

------------------------------

/*
*mod
�� ���� ���� ������ ���� ��ȯ
mod (number, number)
*/
select mod (10, 3) from dual;
select mod (10.9, 3) from dual;

-----------

/*
*round
�ݿø� �� ����� ��ȯ
round(number, [��ġ])
*/
select round (123.456) from dual;--�⺻�ڸ����� �Ҽ��� ù��° �ڸ����� �ݿø� : 0
select round (123.456, 1) from dual;--����� ������ ���� �Ҽ��� �ڷ� ��ĭ�� �̵�
select round (123.456, -1) from dual;--������ ������ ���� �Ҽ��� ���ڸ��� �̵�

-------------------QUIZ------------
--�˻��ϰ��� �ϴ� ����
--job_code�� j7�̰ų� j6�̸鼭 salary���� 200�� �̻�
--bonus�� �ְ�, �����̸� �̸��� �ּҴ� _�տ� 3���� �� �ִ� �����
--�̸�, �ֹι�ȣ, �����ڵ�, �μ��ڵ�, �޿�, ���ʽ��� ��ȸ�ϰ� �ʹ�.
--���������� ��ȸ�Ǹ� ����� 2��

select emp_name, emp_no, job_code, dept_code, salary, bonus 
from employee
where (job_code = 'J7' or job_code = 'J6') and salary >= 2000000
      and email like '__\_%' escape '\' and bonus
      is not null and substr(emp_no, 8, 1) in ('2', '4');
      --�� sql������ ���� ��, ���ϴ� ����� ������ �ʴ´�
      -- � ������ �ִ��� ������ �����ϰ�, ��ġ�� �ڵ带 �ۼ��ϼ���.

