

/*



여러줄
*/
/*
소문자 대문자 구분 안함!!
*/

SELECT
    * FROM DBA_USERS; --현재 모든 계정들에 대해 조회하는 명령문
    -- 명령문 한 구문 (';'이 중요!!) 왼쪽의 재생버튼 or CTRL + ENTER
    -- (관리자 계정 말고,) 일반 사용자 계정을 생성하는 구문 (오직 관리자 계정에서 만 할 수 있다.)
    -- [표현번] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
    CREATE USER KH IDENTIFIED BY KH;
     -- 위에서 생성된 일반 사용자 계정에 최소한의 권한 (접속, 데이터 관리)부여
     -- (권한을 주는 방법) [표현법] GREAT 권한1, 권한2... TO 계정명;
     -- ***계정의 비밀번호는 대/소문자 구분함!!!***
     
     GRANT RESOURCE, CONNECT TO KH;
     
    
     
