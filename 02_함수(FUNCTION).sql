
 select emp_id, emp_name, salary -----------(3)
 from employee -----------------------------(1)
 where dept_code is null; ------------------(2)
 
  /*
  
  <order by 절>
  select 문 중에 가장 마지막 줄게 작성,
  실행순서 또한 가장 마지막에 실행한다.
  
  [표현법]
  select  조회할 컬럼...
  from    조회할 테이블
  where   조건식
  order by 정렬기중이 될 컬럼명 | 별칭 | 컬럼순번 [asc | desc] [null first | null last]
  **!!'[ ]'!!** 대괄호 생략 가능
  - asc : 오름차순
  - desc : 내림차순
  
  -- null은 기본적으로 가장 큰 값으로 분류 후 정렬 
  - nulls fitst : 정렬하고 싶은 컬럼 값에 null이 있을 경우 해당 데이터 가장 앞에 배치 
  (desc일 때 기본값)
  - nulls last : 정렬하고 싶은 컬럼 값에 null이 있을 경우 해당 데이터 가장 마지막에 배치
  (asc일 때 기본 값)
  */
  
  select *
  from employee --(';'가능 단, 이후에 조건이 無 일때)
 -- ORDER BY bonus; (기본값이 오름차순)
  ORDER BY bonus asc;
 --  ORDER BY bonus asc nulls first; (desc일때)
  order by bonus desc, salary asc; --nulls first;
  --정렬기준에 컬럼 값이 동일할 경우 그 다음 차순을 위해 여러개를 제시할 수 있다.
  
  -- 전 사원의 사원명, 연봉(보너스 제외) 조회( 이 때에 연봉별 내림차순 정렬)
  select emp_name, salary * 12 -- (as "연봉")
  from employee
--  order by salary * 12 desc;
  --order by 연봉 desc;
  order by 2 desc;
  
  -- =====================
  /*
  <함수 FUNCTION>
   전달된 컬럼 값을 읽어들여 함수를 실행 한 결과를 반환
   
   - 단일행 : n개의 값을 읽어들여 n개의 결과 값을 리턴 (매 행마다 함수 실행결과를 반환)
   - 그룹함후 : n개의 값을 읽어들여 1개의 결과 값을 리턴 (그룹을 지어 그룹별로 함수 실행결과를 반환)
  
  >> select 절에 단일행 함수랑 그룹함수를 함께 사용하지 못함!!!
  WHY?
  (group function의 결과 값은 1줄)
  결과 행의 갯수가 다르다.
    
  >> 함수식을 기술할 수 있는 위치 : select절 where절 order by절 group by절 having절
  */
  
  --=================================<단일행 함수>==============================
  /* 
  <문자 처리 함수>
   * length( 컬럼 | '문자열') : 해당 문자열의 글자수를 반환
   * lengthb( 컬럼 | '문자열') : 해당 문자열의 바이트수를 반환
   
   '최', '나', 'ㄱ' 한글은 글자 당 3byte
   영문자, 숫자, 특수문자 당 1byte
   */
   
   select LENGTH('오라클'), lengthb('오라클')
   from dual;
   
   select length('ORACLE'), lengthb('ORACLE')
    from dual;
    
   select emp_name, length(emp_name), lengthb(emp_name), email, length(email), lengthb(email)
   from employee;
   
   ---------------------------------------
   /*
   *instr
   문자열로부터 특정 문자의 시작위치를 찾아서 반환
   instr(컬럼 | '문자열', '찾고자하는 문자', ['찾을 위치의 시작값', 순번])
   */
   
   select instr('AABAACAABBAA', 'B')
   from dual;
   -- 앞쪽에 있는 첫 B는 3번째 위치에 있다고 나옴
   
   -- 찾을 위치 시작 값 : 1
   -- 순번 : 1 => 기본값
    select instr('AABAACAABBAA', 'B', 1)
   from dual;
   
   select instr('AABAACAABBAA', 'B', -1)
   from dual;
   -- 뒤에서 찾지만, 앞으로 읽고 알려준다.
   
   select instr('AABAACAABBAA', 'B', 1, 3)
   from dual;
   --overloading한거임
   
   select email, instr(email, '_', 1, 1) as "LOCATION", instr(email, '@') as "@위치"
   from employee;
   
   -----------------------------------------------------------
   /*
   
   *substr /***!!!자주 사용!!!***/
   문자열에서 특정 문자열을 추출해서 반환
   SUBSTR(string, position, [length])
   - string : 문자타입의 컬럼 | '문자열'
   - position : 문자열 추출할 시작 위치의 값
   - length : 추출 할 문자 갯수 (생략하면 끝까지)
   */
   
   select substr ('SHOWMETHEMONEY', 7) from dual; --7번째 위치부터 끝까지
   select substr ('SHOWMETHEMONEY', 5, 2) from dual;
   
   --SHOWME
   
   select substr ('SHOWMETHEMONEY', 1, 6) from dual;
   select substr ('SHOWMETHEMONEY', -8,3) from dual;
   
   select emp_name, emp_no
   from employee;
   
   select emp_name, emp_no, substr(emp_no, 8, 1) as "성별"
   from employee;
   
   --사원들 중 여사원들만 emp_name, emp_no
   select emp_name, emp_no
   from employee
   where substr (emp_no, 8, 1)= '2' or substr(emp_no, 8, 1)= '4';
    
   --사원들 중 ska사원들만 emp_name, emp_no
   select emp_name, emp_no
   from employee
   where substr (emp_no, 8, 1)= '1' or substr(emp_no, 8, 1)= '3'
   order by emp_name;
   
   -- 이메일 아이디 부분 만 추출
   select emp_name, email, substr(email, 1, instr(email, '@') -1)
   from employee;
    -- 사원 목록에서 사원명, 이메일, 아이디 조회
    -- 함수 중첩 사용 가능
    
---------------------------------------------------------------------------
/*
*lpad / rpad (**!!java!!**에도 있음)
문자열을 조회할 때 통일감 있게 조회 가능

 [표현법]
 lpad / rpad (string, 최종적으로 반환 할 문자의 길이 [덧붙이고자 하는 문자])
 문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 붙여서 최종 n길이 만큼의 문자열을 반환
*/
---------------------------------------------
--20만큼의 길이 중 email컬럼 값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채움
select emp_name, lpad(email, 20, '#')
from employee;
   
 select emp_name, rpad(email, 20, '#')
 from employee;  
 
 select rpad('910524-1', 14, '*')
 from dual;
 
 --사원들의 사원명, 주민등록번호 조회("910524-1******")
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
   문자열에서 특정 문자를 제거한 나머지를 반환
   ltrim / rtrim (string, [제거하고자 하는 문자들])
   
   문자열에서 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환
   */
   
   select ltrim('     K   H')--앞에서 부터 다른 문자가 나올 때 까지만 공백제거
   from dual;--(왼쪽 공백 제거라고 생각하면 편함)
   
    select ltrim('123123KH123', '123')
    from dual;
    
    select ltrim('ACABACCKH', 'ABC') --제거하고자 하는 문자는 문자열이 아닌 문자들
    from dual; --문자들!!
   
   select rtrim('574185KH123', '0123456789')
    from dual;
     select ltrim('574185KH123', '0123456789')
    from dual;--왼쪽 오른쪽 비교해보기!!!
    
    /*
    *trim
    문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    trim([leading | trailing | both] 제거하고자 하는 문자열 from 문자열)
    */
    
 select trim('     K     H   ') from dual; --양쪽에 공백 제거
  select trim('Z' FROM 'ZZZZKHZZZZZZZZ') from dual;--양쪽에 특정문자 제거
select trim(LEADING'Z' FROM 'ZZZZKHZZZZZZZZ') from dual;    
select trim(TRAILING'Z' FROM 'ZZZZKHZZZZZZZZ') from dual; 
    select trim(BOTH'Z' FROM 'ZZZZKHZZZZZZZZ') from dual; 
    ---------------------------------------------
/*
*lower / upper / initcap
lower : 소문자로 변경하는 문자열 반환
upper : 대문자로
initcap : 띄어쓰기 기준 첫 글자마다 대문자로 변경한 문자열 반환
*/

select lower('Welcome To My World') from dual; 
 select upper('Welcome To My World') from dual; 
  select INITCAP('welcome wo my world') from dual; 
  
---------------------------------
/*
*concat
문자열 2개 전달 받아 1개로 합친 후 반환
concat (string1, string2)
*/

--2개의 문자열 만 가능
select concat('가나다', 'ABC') from dual;
select '가나다' || 'ABC' from dual;
---------------

/*
*replace
특정 문자열에서 특정 부분을 다른 부분으로 교체
replace(문자열, 찾을 문자열, 변경 할 문자열)
*/

select email, replace(email, 'KH.or.kr', 'gmail.com') 
from employee;

------------------------------------------------------------------

/*
*abs
<숫자 처리 함수>
숫자의 절대값을 구하는 함수
*/

select abs(-10), abs(-6.3) 
from dual;

------------------------------

/*
*mod
두 수를 나눈 나머지 값을 반환
mod (number, number)
*/
select mod (10, 3) from dual;
select mod (10.9, 3) from dual;

-----------

/*
*round
반올림 한 결과를 반환
round(number, [위치])
*/
select round (123.456) from dual;--기본자리수는 소수점 첫번째 자리에서 반올림 : 0
select round (123.456, 1) from dual;--양수로 증가할 수록 소수점 뒤로 한칸씩 이동
select round (123.456, -1) from dual;--음수로 감소할 수록 소수점 앞자리로 이동

-------------------QUIZ------------
--검색하고자 하는 내용
--job_code가 j7이거나 j6이면서 salary값이 200만 이상
--bonus가 있고, 여자이며 이메일 주소는 _앞에 3글자 만 있는 사원의
--이름, 주민번호, 직급코드, 부서코드, 급여, 보너스를 조회하고 싶다.
--정상적으로 조회되면 결과가 2개

select emp_name, emp_no, job_code, dept_code, salary, bonus 
from employee
where (job_code = 'J7' or job_code = 'J6') and salary >= 2000000
      and email like '__\_%' escape '\' and bonus
      is not null and substr(emp_no, 8, 1) in ('2', '4');
      --위 sql문에서 실행 시, 원하는 결과가 나오지 않는다
      -- 어떤 문제가 있는지 원인을 서술하고, 조치한 코드를 작성하세요.

