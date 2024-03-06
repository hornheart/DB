drop table member;
drop table test;
create table test(
    TNO number,
    Tname VARCHAR2 (20),
    Tdate date
);

SELECT
    * FROM test;
    
create table MEMBER(
    userno number PRIMARY key,
    userid VARCHAR2 (15) not null UNIQUE,
    userpwd VARCHAR2 (15) NOT NULL,
    username VARCHAR2 (20) not null,
    gender char (1) check(gender in ('M', 'F')),
    age NUMBER,
    email VARCHAR2 (30),
    phone CHAR (11),
    address VARCHAR2 (100),
    hobby VARCHAR2 (50),
    enrolldate date DEFAULT sysdate not null
);

DROP SEQUENCE seq_userno;
CREATE SEQUENCE SEQ_USERNO
NOCACHE;

INSERT into member
VALUES (SEQ_USERNO.nextval, 'admin', '1234', '관리자', 'M', 45, 'admin@iei.or.kr', '01012345678', '서울', null, '2021-07-27');

INSERT into member
VALUES (SEQ_USERNO.nextval, 'user01', 'pass01', '홍길동', null, 23, 'user01@iei.or.kr', '01011111111', '부산', '등산, 영화보기',
'2021-08-27');
    
    