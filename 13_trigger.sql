/*
<Ʈ����>
���� ������ ���̺� insert, update, delete�� dml���� ���� ��������� ���� ��
(���̺� �̺�Ʈ�� �߻����� ��)
�ڵ����� �Ź� ���� �� ������ �̸� ������ �� �ִ�.
��)
ȸ�� Ż�� �� ������ ȸ�� ���̺� ������ delete�� �� �ٷ� Ż���� ȸ���� �� ���� ����
�ڵ����� insert���Ѿ� �Ѵ�.
�Ű� Ƚ���� ���� ���� ������ ���������� �ش� ȸ���� �� ����Ʈ�� ó��

����� ���� �����Ͱ� ���(insert) �� ������ �ش� ��ǰ�� ���� �������� ����(upsate)�ؾ��Ѵ�.

*Ʈ���� ����
- sql���� ����ñ⿡ ���� �з�

>before trigger : ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
>after trigger : ������ ���̺� �̺�Ʈ�� �߻��� �� Ʈ���� ����

-sql���� ���� ������ �޴� �� �࿡ ���� �з�
>����Ʈ���� : �̺�Ʈ�� �߻��� sql���� ���� �� �ѹ� �� Ʈ���� ����
>��Ʈ���� : �ش� sql�� ���� �� ������ �Ź� Ʈ���� ����
            (for each row�ɼ� ����ؾ� ��)
            > :OLE-BEFORE UPDATE(�������ڷ�)
            > :NEW-after insert(�߰����ڷ�), after update(���� �� �ڷ�)
*Ʈ���� ���� ����

[ǥ����]
create [or replace] trigger Ʈ���Ÿ�
before | after          insert | update | delete on ���̺�
[for each row]
[declare ��������]
begin
    ���೻�� ( �ش� ���� ���� �� �̺�Ʈ �߻� �� ������(=�ڵ�)���� ���� �� ����)
[exception ����ó��]
end;
/
 */
 -- employee ���̺� ���ο� ���� insert �� ������ �ڵ����� ��µǴ� Ʈ���� ����
 create or replace trigger trg_01
 after insert on employee
 begin 
  dbms_output.put_line('���Ի���� ȯ���մϴ�.');
 end;
 /
 
 insert into employee(emp_id, emp_name, emp_no, dept_code, job_code, hire_date)
 VALUES(500, '�̼���', '111111-1111111', 'D7', 'D7', sysdate); 
 
 insert into employee(emp_id, emp_name, emp_no, dept_code, job_code, hire_date)
 VALUES(501, '������', '111111-1111111', 'D8', 'D7', sysdate);
 
 ----------------------------------
 
 --��ǰ�԰� �� ��� ���ÿ���
 --> �ʿ��� ���̺� �� ������ ����
  --1. ��ǰ�� ���� �����͸� ������ ���̺� (TB_PRODUCT)
drop table tb_product;
create table tb_product(
 pcode NUMBER PRIMARY key,
 pname VARCHAR2(30) not null,
 brand VARCHAR2 (30) not null,
 price NUMBER,
 stock NUMBER DEFAULT 0
); 

create SEQUENCE seq_pcode
start with 200
increment by 5
nocache;

--���õ����� �߰�
insert into tb_product values (seq_pcode.nextval, '������24', '����', 1400000, default);
insert into tb_product values (seq_pcode.nextval, '������15', '���', 1300000, 10);
insert into tb_product values (seq_pcode.nextval, '�����', '�����', 700000, 20);
 
commit;

--2. ��ǰ ����� �� �̷� ���̺����(tb_prodetail)
--� ��ǰ�� � ��¥�� ��� �԰� �Ǿ� ��� �Ǵ��� �����͸� ����ϴ� ���̺�
create table tb_prodetail(
    dcode number primary key, -- �̷¹�ȣ
    pcode number references tb_product,             -- ��ǰ��ȣ
    pdate date not null,      -- �� /�����
    amount number not null,   -- �� / ��� ����
    status char(6)check (status in ('�԰�', '���'))     -- ����(�԰�, ���)
 );
 
-- �̷¹�ȣ �Ź� ���ο� ��ȣ�� �߻����� �� �� �ְ� ���� �� ������ ����
create sequence seq_decode
nocache;

--200�� ��ǰ�� ���ó�¥�� 10�� �԰�
insert into tb_prodetail
values(seq_decode.nextval, 200, sysdate, 10, '�԰�');

update tb_product
set stock = stock + 10
where pcode = 200;
commit;
insert into tb_prodetail
values(seq_decode.nextval, 205, sysdate, 20, '�԰�');

update tb_product
set stock = stock + 20
where pcode = 205;

update tb_product
set stock = stock + 5
where pcode = 210;
commit;

insert into tb_prodetail
values(seq_decode.nextval, 210, sysdate, 5, '�԰�');
--tb_prodetail���̺� insert�̺�Ʈ �߻���
--tb_product���̺� �Ź� �ڵ����� ������ update�ǰ� Ʈ���� �ۼ�

/*
-��ǰ�� �԰�� ��� -> �ش� ��ǰ�� ã�Ƽ� ��� ���� ����  update
update tb_product
set stock = stock + ���� �԰� �� ���� (insert �� �ڷ��� amount)
where pcode = �԰�� ��ǰ��ȣ (insert�� �ڷ��� pcode);

-��ǰ�� ���� ��� -> �ش� ��ǰ�� ã�Ƽ� ��� ���� ����  update
update tb_product
set stock = stock + ���� ��� �� ���� (insert �� �ڷ��� amount)
where pcode = ���� ��ǰ��ȣ (insert�� �ڷ��� pcode);

*/

create or replace trigger trg_02
after insert on tb_prodetail
for each row 
begin
    if ( :new.status ='�԰�')
        then update tb_product
        set stock = stock + :NEW.amount
        where pcode =:NEW.pcode;
    enD if;
    
    if(:new.status = '���')
     then update tb_product
        set stock = stock - :NEW.amount
        where pcode =:NEW.pcode;
    end if;
end;
/

insert into tb_prodetail
values(seq_decode.nextval, 210, sysdate, 7, '���');

insert into tb_prodetail
values(seq_decode.nextval, 200, sysdate, 100, '�԰�');