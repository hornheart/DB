/*
<PL/SQl>
procedure language extecsion to sql
오라클 자체에 내장 되어있는 절차적 언어
sql 문장 내에서 변수의 정의 if조건, for, while반복 등을 지원하여 sql단점을 보완

다수의 sql문을 한번에 실행

*PL/SQL구조
-[선언부] : declare로 시작, 변수나 상수를 선언 및 초기화하는 부분
- 실행부 : begin으로 시작, sql문 또는 제어문(조건문, 반복문)등의 로직을 기술하는 부분
- [예외처리부] : exception으로 시작, 예외발생 시 해결하기 위한 구문


*/

set SERVEROUTPUT on;

--hello oracle출력
begin
--system.out.println("hello oarcle")자바
dbms_output.put_line('hello oracle');
end;
/

---------------------------------------------------------
/*
1. declare선언부
변수 및 상수 선언 하는 공간 (선언 동시에 초기화 가능)

일반타입변수, 레퍼런스타입변수, row타입변수

1_1) 일반타입 변수 선언 및 초기화
[표현식] 변수명 [constact] 자료형 [:=값];
*/
--자바라면, 필드 or { }
DECLARE
--(선언부는 변수를 만들기 위해)
    eid NUMBER;
    ename VARCHAR2(20);
    pi CONSTANT NUMBER := 3.14;
BEGIN
    eid := 800;
    ename := '지은';
    
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('pi : ' || pi);      
end;
/

DECLARE
--(선언부는 변수를 만들기 위해)
    eid NUMBER;
    ename VARCHAR2(20);
    pi CONSTANT NUMBER := 3.14;
BEGIN
    eid := &번호;
    ename := '&이름';
    
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('pi : ' || pi);      
end;
/
---------------------------------------------------------
--1_2) 레퍼런스(=참조변수) 타입 변수 선언 및 초기화 ( 어떤 테이블의 어떤 데이터타입을 참조해서 그 타입으로 지정)

DECLARE
    eid employee.emp_id%type;
    ename employee.emp_name%type;
    sal employee.salary%type ;
BEGIN
    --eid := 800;
    --ename := '지은';
    --sal := 100000;
--사번200번 사번, 사원명, 급여 변수에 대입

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
    --ename := '지은';
    --sal := 100000;
--사번200번 사번, 사원명, 급여 변수에 대입

    SELECT emp_id, emp_name, salary
    into eid, ename, sal
    from employee
    where emp_id=&사번;
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('sal : ' || sal);      
end;
/
--------------------실습--------------------
/*
레퍼런스타입변수로 
eid, ename, jcode, sal, dtitle을 선언
각 자료형 employee (emp_id, emp_name, job_code, salary,
department(dept_title)을 참조
사용자가 입력한 사번의 사번, 사원명, 직급코드, 급여, 부서명 조회 후 변수에 담아 출력
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
    where emp_id='&사번';
    dbms_output.put_line('eid : ' || eid);
    dbms_output.put_line('ename : ' || ename);
    dbms_output.put_line('ecode : ' || ecode);  
    dbms_output.put_line('sal : ' || sal);
    dbms_output.put_line('dtitle : ' || dtitle);
end;
/
----------------------------------------
/*
--1_3) row타입 변수 선언
--    테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
--    [표현식] 변수명 테이블명%rowtype;
*/
DECLARE
    e employee%rowtype;
   
BEGIN
    SELECT *
    into e
    from employee
    
    where emp_id='&사번';
    dbms_output.put_line('사원명 : ' || e.emp_name);
    dbms_output.put_line('급여 : ' || e.salary);
    dbms_output.put_line('보너스 : ' || nvl(e.bonus,0);
end;
/
----------------------------------------
/*
--2. begin실행부
--<조건문>
-- 1) if조건식 then 실행내용 end if;
(if문 만 단독으로 사용)
--입력받은 사번의 해당하는 사번, 이름, 급여, 보너스 출력
--단, 보너스 받지 않은 사원 보너스율 출력 전 '보너스를 지급받지 않은 사원입니다'출력
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
   
    where emp_id=&사번;
    dbms_output.put_line('사번 : ' || eid);
    dbms_output.put_line('이름 : ' || ename);
    dbms_output.put_line('급여 : ' || sal);  
    if bonus = 0
        then dbms_output.put_line('보너스를 지급받지 않은 사웝입니다.' );
    end if;
    dbms_output.put_line('보너스율 : ' || bonus);
end;
/

--2) if 조건식 then 실행내용 else 실행내용 end if; (if-else)
DECLARE
    eid employee.emp_id%type;
    ename employee.emp_name%type;
    
    sal employee.salary%type ;
    bonus employee_bonus%TYPE;
BEGIN
    SELECT emp_id, emp_name, salary, nvl(bonus,0)
    into eid, ename, sal, bonus
    from employee
   
    where emp_id=&사번;
    dbms_output.put_line('사번 : ' || eid);
    dbms_output.put_line('이름 : ' || ename);
    dbms_output.put_line('급여 : ' || sal);  
    if bonus = 0
        then dbms_output.put_line('보너스를 지급받지 않은 사웝입니다.' );
    else
        dbms_output.put_line('보너스율 : ' ||( bonus*100||'%'));
    end if;
    dbms_output.put_line('보너스율 : ' || bonus);
end;
/

--------------------실습--------------------
--DECLARE
--레퍼런스타입변수 (eid, ename, dtitle, ncode)
--참조컬럼        (emp_id, emp_name, dept_title, national_code)
--일반타입변수(team문자열) <==국내, 해외 분리 해서 담을 예정
--begin
--사용자가 입력한 사번, 이름, 부서명, 근무국가코드 조회 후 각 변수에 대입
--
--ncode 값이 ko일 경우 --> team --> '국내팀' 대입
-- 아니면, --> team --> '해외팀' 대입
--
-- 사번, 이름, 부서, 소속에 대해 출력
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
    where emp_id=&사번;
    
    if ncode = 'KO'
        then team := '국내팀';
    else
        then team := '해외팀';
    end if;    
        
    dbms_output.put_line('사번 : ' || eid);
    dbms_output.put_line('이름 : ' || ename);
    dbms_output.put_line('부서 : ' || dtitle); 
    dbms_output.put_line('소속 : ' || team);
     
end;
/
----------------------------------------
/*
--3) else if 조건식
if 조건식1 then 실행내용1 else if 조건식2 then 실행내용2...[else 실행내용] end if;
*/
DECLARE
    score number;
    grade varchar2(1);
BEGIN
    score := &점수;
        
    if score >= 90 then grade := 'A';
    elsif score >= 80 then grade := 'B';
    elsif score >= 70 then grade := 'C';
    elsif score >= 60 then grade := 'D';
    else
        grade := 'F';
    end if;    
    
    dbms_output.put_line('당신의 점수는 ' || score || '점이고, 학점은 ' || grade ||'학점입니다.');
     
end;
/

--------------------실습--------------------

--사용자에게 입력받은 사번의 사원급여 조회sal 변수 대입
--500만 이상'고급'
--400만 이상'중급'
--300만 이상'초급'
--'해당 사원의 급여등급은 XX입니다.'
/*
DECLARE
    salary number;
    grade varchar2(1);
BEGIN
    salary := &급여;
        
    if salary >= 5000000 then grade := '고급';
    elsif salary >= 4000000 then grade := '중급';
    elsif salary >= 3000000 then grade := '초급';
   
    end if;    
    
    dbms_output.put_line('해당 사원의 급여는 ' || salary || '원이고, 듭급은 ' || grade ||'입니다.');
     
end;
/
*/--다시하기


----------------------------------------
/*
--4) case비교대상자 when동등 비교값1 then 결과값 when 비교값2 then 결과값... else결과값end;
DECLARE
    emp employee%rowtype;
    dname varchar2(30);
BEGIN
    SELECT *
    into eip
    from employee
    
    where emp_id=&사번;
    dname := case emp.dept_code
        when 'D1' then '인사팀'
        when 'D2' then '회계팀'
        when 'D3' then '마케팅팀'    
        when 'D4' then '국내영업팀'
        when 'D9' then '총무팀'  
         else '해외영업팀'
    end;     
    dbms_output.put_line(emp.emp_name||'은 ' || dname || '입니다.');
     
end;
/

--<반복문>
/*
1) basic loop문
[표현식]
loop
반복적으로 실행할 구문;
*반복문을 빠져나갈 수 있는 구문
end loop;

(예를 들면*break처럼 반복문을 빠져나갈 수 있는 구문)
1) if 조건식 then exit; end if;
2) exit when 조건식;

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
2) for loop문 (반복횟수나 빠져나올 수 있을 때)
[표현식]
for 변수 in [reverse] 초기값... 최종값
loop
    반복적으로 실행할 문장;
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
while loop문

[ 표현식]
 while 반복문이 수행될 조건
 loop
    반복수행하는 문자
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
3.예외처리부
예외 (exception) : 실행 중 발행하는 오류

exception
    when 예외명1 then 예외처리구문1;
    when 예외명2 then 예외처리구문2;
    ...
    *시스템 예외 (오라클에서 미리 정의한 예외)
    - no_data_found : select한 결과가 한 행도 없을 때
    - too_many_rows : select한 결과가 여러행 일 경우
    - zero_divide : 0으로 나눌 때
    - dup_var_on_ index : unique 제약조건에 위배된 경우
    */
    
    --사용자가 입력한 수로 나눗셈 연산 결과 출력
DECLARE
   result number;
BEGIN
     
   result := 10 / &숫자;
   dbms_output.put_line('결과 : ' || result);
   
exception
  when zero_divide then dbms_output.put_line('나누기 연산 시 0으로 나눌 수 없다');
    
    
end;
/   

--unique제약조건 위배
alter table employee add primary key (emp_id);

BEGIN
   update employee
     SET emp_id = '&변경할사번'  
    where emp_name = '노옹철';
exception
    when dup_val_on_index then dbms_output.put_line('이미 존재하는 사번입니다.');
end;
/   
    
