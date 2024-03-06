/*
<������ sequence>
�ڵ����� ��ȣ�� �����ϴ� ��ü
�������� �������� ������ �� ����

ex )  ȸ����ȣ, �����ȣ, �Խñ۹�ȣ..

[ǥ����]
create sequence ��������
[start with ���ۼ���] --> ó�� �߻���ų ���� �� ���� [�⺻��1]
[increment by ����] --> �� �� ������ų ���� [�⺻��1]
[maxvalue ����] --> �ִ� ���� [�⺻�� �ſ� ū��]
[minvalue ����] --> �ּڰ� ���� [�⺻��1]
[cycle | nocycle] --> ���� ��ȯ���θ� �����Ѵ� [�⺻�� nocycle]
[nocache | cache ����Ʈũ��] --> ĳ�ø޸� �Ҵ� (�⺻�� cache 20)


*ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ����
            �Ź� ȣ�� �ÿ� ���� ��ȣ�� �����ϴ°� �ƴ�
            ĳ�� �޸� ������ (�̸�)������ ������ ������ ���� ������ �ӵ��� ����
            
���̺�� : tb_
��� : vw_
������ : SEQ_
Ʈ���� : TRG_

*/
create SEQUENCE seq_test;
--[����] ���� ������ �����ϰ� �ִ� ������ ���� ����
SELECT
    * FROM user_sequences;
    /*
create SEQUENCE seq_empno    
start with 300
increment by 5
maxvalue 310
nocycle
nocache;
*/
/*
2.������ ���
��������. currval : ���� ������ �� (���������� ������ nextval�� ��)
��������. nextval : ���������� �������� �������� �߻��� ��
                    ���� ������ ������ increment by�� ��ŭ ����

*/
SELECT
    * FROM user_sequences;

SELECT SEQ_EMPNO.currval
     FROM dual;--����
     
SELECT SEQ_EMPNO.nextval
     FROM dual;     
     
SELECT SEQ_EMPNO.nextval
     FROM dual;     

SELECT SEQ_EMPNO.nextval
     FROM dual; 

SELECT SEQ_EMPNO.nextval
     FROM dual; 

SELECT
    * FROM user_sequences;

SELECT SEQ_EMPNO.nextval
     FROM dual; 
     
/*
**nextval�� �� ���� ���**
currval �ܺ�Ű ������� ���� ��� ������ ���� ��뵵�� ����
*/

/*

3. �������� ��������

alter sequence ��������

(**���ۼ��� �ٲٴ� ���� �ǹ̰� ����!!**
=>�Ұ�!![start with ���ۼ���] --> ó�� �߻���ų ���� �� ���� [�⺻��1])

[increment by ����] --> �� �� ������ų ���� [�⺻��1]
[maxvalue ����] --> �ִ� ���� [�⺻�� �ſ� ū��]
[minvalue ����] --> �ּڰ� ���� [�⺻��1] **��ȯ** ���� ����!!
[cycle | nocycle] --> ���� ��ȯ���θ� �����Ѵ� [�⺻�� nocycle]
[nocache | cache ����Ʈũ��] --> ĳ�ø޸� �Ҵ� (�⺻�� cache 20)

(**���۰� �� ������ �Ұ�!!**start with)

*/
alter sequence SEQ_EMPNO
increment by 10
maxvalue 400;
SELECT SEQ_EMPNO.nextval
     FROM dual;
     
     
     --4.sequence����
drop SEQUENCE seq_empno;

-----------------------------------------------------------
create SEQUENCE seq_eid
start WITH 400
nocache;

insert into employee (emp_id, emp_name, emp_no, job_code, hire_date)
    values (seq_eid.nextval, '�踻��', '111111-2222222', 'J6', sysdate);
    
    insert into employee (emp_id, emp_name, emp_no, job_code, hire_date)
    values (seq_eid.nextval, '�����', '111111-2222222', 'J6', sysdate);
 
SELECT
    * FROM employee;    