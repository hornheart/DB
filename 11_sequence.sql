/*
<시퀀스 sequence>
자동으로 번호를 발행하는 객체
적수값을 순차적을 일정값 씩 증가

ex )  회원번호, 사원번호, 게시글번호..

[표현식]
create sequence 시퀀스명
[start with 시작숫자] --> 처음 발생시킬 시작 값 지정 [기본값1]
[increment by 숫자] --> 몇 씩 증가시킬 건지 [기본값1]
[maxvalue 숫자] --> 최댓값 지정 [기본값 매우 큰수]
[minvalue 숫자] --> 최솟값 지정 [기본값1]
[cycle | nocycle] --> 값의 순환여부를 지정한다 [기본값 nocycle]
[nocache | cache 바이트크기] --> 캐시메모리 할당 (기본값 cache 20)


*캐시메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간
            매번 호출 시에 새로 번호를 생성하는게 아닌
            캐시 메모리 공간에 (미리)생성된 값들을 가져다 쓰기 때문에 속도가 빠름
            
테이블명 : tb_
뷰명 : vw_
시퀀스 : SEQ_
트리거 : TRG_

*/
create SEQUENCE seq_test;
--[참고] 현재 계정이 소유하고 있는 시퀀스 구조 볼때
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
2.시퀀스 사용
시퀀스명. currval : 현재 시퀀스 값 (마지막으로 성공한 nextval의 값)
시퀀스명. nextval : 시퀀스값에 일정값을 증가시켜 발생한 값
                    현재 시퀀스 값에서 increment by값 만큼 증가

*/
SELECT
    * FROM user_sequences;

SELECT SEQ_EMPNO.currval
     FROM dual;--에러
     
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
**nextval을 더 많이 사용**
currval 외부키 사용으로 인해 방금 생성된 것을 사용도가 낮음
*/

/*

3. 시퀀스의 구조변경

alter sequence 시퀀스명

(**시작숫자 바꾸는 것은 의미가 없다!!**
=>불가!![start with 시작숫자] --> 처음 발생시킬 시작 값 지정 [기본값1])

[increment by 숫자] --> 몇 씩 증가시킬 건지 [기본값1]
[maxvalue 숫자] --> 최댓값 지정 [기본값 매우 큰수]
[minvalue 숫자] --> 최솟값 지정 [기본값1] **순환** 수정 가능!!
[cycle | nocycle] --> 값의 순환여부를 지정한다 [기본값 nocycle]
[nocache | cache 바이트크기] --> 캐시메모리 할당 (기본값 cache 20)

(**시작값 만 변경이 불가!!**start with)

*/
alter sequence SEQ_EMPNO
increment by 10
maxvalue 400;
SELECT SEQ_EMPNO.nextval
     FROM dual;
     
     
     --4.sequence삭제
drop SEQUENCE seq_empno;

-----------------------------------------------------------
create SEQUENCE seq_eid
start WITH 400
nocache;

insert into employee (emp_id, emp_name, emp_no, job_code, hire_date)
    values (seq_eid.nextval, '김말똥', '111111-2222222', 'J6', sysdate);
    
    insert into employee (emp_id, emp_name, emp_no, job_code, hire_date)
    values (seq_eid.nextval, '김새똥', '111111-2222222', 'J6', sysdate);
 
SELECT
    * FROM employee;    