/*
<트리거>
내가 지정한 테이블에 insert, update, delete등 dml문에 의해 변경사항이 생길 때
(테이블에 이벤트가 발생했을 때)
자동으로 매번 실행 할 내용을 미리 정의할 수 있다.
예)
회원 탈퇴 시 기존의 회원 테이블에 데이터 delete후 곧 바로 탈퇴한 회원들 만 따로 보관
자동으로 insert시켜야 한다.
신고 횟수가 일정 수를 넘으면 묵시적으로 해당 회원을 블랙 리스트로 처리

입출고에 대한 데이터가 기록(insert) 될 때마다 해당 상품에 대한 재고수향을 수정(upsate)해야한다.

*트리거 종류
- sql문의 실행시기에 따른 분류

>before trigger : 지정한 테이블에 이벤트가 발생되기 전에 트리거 실행
>after trigger : 지정한 테이블에 이벤트가 발생된 후 트리거 실행

-sql문에 의해 영향을 받는 각 행에 따른 분류
>문장트리서 : 이벤트가 발생한 sql문에 대해 딱 한번 만 트리거 실행
>행트리서 : 해당 sql문 실행 할 때마다 매번 트리거 실행
            (for each row옵션 기술해야 함)
            > :OLE-BEFORE UPDATE(수정전자료)
            > :NEW-after insert(추가된자료), after update(수정 후 자료)
*트리거 생성 구문

[표현식]
create [or replace] trigger 트리거명
before | after          insert | update | delete on 테이블
[for each row]
[declare 변수선언]
begin
    실행내용 ( 해당 위의 지정 된 이벤트 발생 시 묵시적(=자동)으로 실행 할 구문)
[exception 예외처리]
end;
/
 */
 -- employee 테이블에 새로운 행이 insert 될 때마다 자동으로 출력되는 트리거 정의
 create or replace trigger trg_01
 after insert on employee
 begin 
  dbms_output.put_line('신입사원님 환영합니다.');
 end;
 /
 
 insert into employee(emp_id, emp_name, emp_no, dept_code, job_code, hire_date)
 VALUES(500, '이순신', '111111-1111111', 'D7', 'D7', sysdate); 
 
 insert into employee(emp_id, emp_name, emp_no, dept_code, job_code, hire_date)
 VALUES(501, '김유신', '111111-1111111', 'D8', 'D7', sysdate);
 
 ----------------------------------
 
 --상품입고 및 출고 관련예시
 --> 필요한 테이블 및 시퀀스 생성
  --1. 상품에 대한 데이터를 보관할 테이블 (TB_PRODUCT)
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

--샘플데이터 추가
insert into tb_product values (seq_pcode.nextval, '갤럭시24', '샘송', 1400000, default);
insert into tb_product values (seq_pcode.nextval, '아이폰15', '사과', 1300000, 10);
insert into tb_product values (seq_pcode.nextval, '대륙폰', '샤우미', 700000, 20);
 
commit;

--2. 상품 입출고 상세 이력 테이블생성(tb_prodetail)
--어떤 상품이 어떤 날짜에 몇개가 입고 되어 출고가 되는지 데이터를 기록하는 테이블
create table tb_prodetail(
    dcode number primary key, -- 이력번호
    pcode number references tb_product,             -- 상품번호
    pdate date not null,      -- 입 /출고입
    amount number not null,   -- 입 / 출고 수량
    status char(6)check (status in ('입고', '출고'))     -- 상태(입고, 출고)
 );
 
-- 이력번호 매번 새로운 번호를 발생시켜 들어갈 수 있게 도와 줄 시퀀스 생성
create sequence seq_decode
nocache;

--200번 상품이 오늘날짜로 10개 입고
insert into tb_prodetail
values(seq_decode.nextval, 200, sysdate, 10, '입고');

update tb_product
set stock = stock + 10
where pcode = 200;
commit;
insert into tb_prodetail
values(seq_decode.nextval, 205, sysdate, 20, '입고');

update tb_product
set stock = stock + 20
where pcode = 205;

update tb_product
set stock = stock + 5
where pcode = 210;
commit;

insert into tb_prodetail
values(seq_decode.nextval, 210, sysdate, 5, '입고');
--tb_prodetail테이블에 insert이벤트 발생시
--tb_product테이블에 매번 자동으로 재고수량 update되게 트리거 작성

/*
-상품이 입고된 경우 -> 해당 상품을 찾아서 재고 수량 증가  update
update tb_product
set stock = stock + 현재 입고 된 수량 (insert 된 자료의 amount)
where pcode = 입고된 상품번호 (insert된 자료의 pcode);

-상품이 출고된 경우 -> 해당 상품을 찾아서 재고 수량 감소  update
update tb_product
set stock = stock + 현재 출고 된 수량 (insert 된 자료의 amount)
where pcode = 출고된 상품번호 (insert된 자료의 pcode);

*/

create or replace trigger trg_02
after insert on tb_prodetail
for each row 
begin
    if ( :new.status ='입고')
        then update tb_product
        set stock = stock + :NEW.amount
        where pcode =:NEW.pcode;
    enD if;
    
    if(:new.status = '출고')
     then update tb_product
        set stock = stock - :NEW.amount
        where pcode =:NEW.pcode;
    end if;
end;
/

insert into tb_prodetail
values(seq_decode.nextval, 210, sysdate, 7, '출고');

insert into tb_prodetail
values(seq_decode.nextval, 200, sysdate, 100, '입고');