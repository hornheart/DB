/*
<DCL : 데이터 제어문>
계정에게 시스템 권한 또는 객체접근 권한을 부여하거나 회수하는 구문
> 시스템 권한 : DB에 접근하는 권한, 객체를 생성할 수 있는 권한
> 객체접근권한 : 특정 객체들을 조작할 수 있는 권한

create user 계정명 identified by 비밀번호;
gract 권한 (resource, connect) to 계정;  
*/
--계정생성 반드시 시험에 나온다!!

select * 
from role_sys_privs;

/*
<TCL : 트랜잭션 제어문>
*트랜잭션
- 데이터 베이스의 논리적 연산단위
- 데이터의 변경사항 (DML)등을 하나의 트랜잭션에 묶어서 처리
  DML문 한개를 수행할 때 트랜잭션이 존재하지 않는다면 트랜잭션을 만들어서 묶음
                       트랜잭션이 존재한다면 해당 트랜잭션에 묶어서 처리
  commit하기 전까지 변경사항들을 하나의 트랜잭션에 담는다.                     
- 트랜잭션에 대상이 되는 SQL : insert, update, delete

commit (트랜잭션 종료 처리 후 확정)
rollback (트랜잭션 취소)
savepoint (임시저장)

- commit  :  한 트랜잭션에 담겨있는 변경사항들을 실제 db에 반영시키겠다는 의미
- rollback : 한 트랜잭션에 담겨있는 변경사항들을 삭제(취소) 한 후 마지막 commit 시점으로 돌아감
- savepoint 포인트 명 : 현재 시점에 해당 포인트명으로 임시저장을 해두는 것
*/

DROP TABLE emp_01;

CREATE TABLE emp_01
as (select emp_id, emp_name, dept_title
    from employee
    join department on (dept_code = dept_id));
    
SELECT
    * FROM emp_01;
    
--사번200번 삭제
delete from emp_01
where emp_id=200;

delete from emp_01
where emp_id=201;

ROLLBACK;

SELECT * FROM emp_01;

--사번 200,201삭제
delete from emp_01
where emp_id=200;

delete from emp_01
where emp_id=201;
commit;

ROLLBACK;
SELECT * FROM emp_01;

--------------------------
/*
db에 돌아가서
삭제된 것이 복원이 안됨
*/
--------------------------

--217,216,214사원 삭제
delete from emp_01
where emp_id in (217, 216, 214);

SELECT * FROM emp_01;

SAVEPOINT sp;

insert INTO emp_01
VALUES(801, '김말똥', '기술지원부');

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
--DDL문 (create, alter, drop)을 수행하는 순간 기존 트랜잭션에 있던 변경사항들은 
--무조건 commit이 된다 (실제 db반영이 된다.)
--즉, ddl문 수행전 변경사항들이 있다면 정확하게 픽스하고 해라!
