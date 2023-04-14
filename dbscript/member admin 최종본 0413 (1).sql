--<drop the table>
/*
drop table BANNER cascade constraints purge
/

drop table QNA cascade constraints purge
/

drop table FAQ cascade constraints purge
/

drop table NOTICE cascade constraints purge
/

drop table EVENT cascade constraints purge
/

drop table QUIT cascade constraints purge
/

drop table LOG cascade constraints purge
/

drop table MEMBER cascade constraints purge
/


--drop the sequence


drop sequence SEQ_BANNER
/

drop sequence SEQ_QNA
/

drop sequence SEQ_FAQ
/

drop sequence SEQ_NOTICE
/

drop sequence SEQ_EVENT
/


*/

/* ------------------------------------------------------------- */




/* MEMBER(회원정보 기본사항테이블) */
CREATE TABLE MEMBER
(
    USER_ID            VARCHAR2(50),
    USER_PW            VARCHAR2(500)           NOT NULL,
    USER_NAME          VARCHAR2(30)            NOT NULL,
    USER_NICKNAME      VARCHAR2(30)            NOT NULL,
    PHONE              VARCHAR2(30)            NOT NULL,
    BIRTH              DATE                    NOT NULL,
    GENDER             CHAR(1)                 NOT NULL,
    EMAIL              VARCHAR2(100)           NOT NULL,
    ADMIN_CK           CHAR(1) DEFAULT 'N',
    PROFILE_ORIGINFILE VARCHAR2(200 BYTE),
    PROFILE_RENAMEFILE VARCHAR2(200 BYTE),
    JOIN_DATE          DATE    DEFAULT SYSDATE NOT NULL,
    LOGIN_OK           CHAR(1) DEFAULT 'Y'     NOT NULL,

    CONSTRAINT PK_USER_ID PRIMARY KEY (USER_ID),
    CONSTRAINT UQ_USER_NN UNIQUE (USER_NICKNAME),
    CONSTRAINT UQ_PHONE UNIQUE (PHONE),
    CONSTRAINT CK_GENDER CHECK (GENDER IN ('M', 'F')),
    CONSTRAINT UQ_EMAIL UNIQUE (EMAIL),
    CONSTRAINT CK_ADMIN CHECK (ADMIN_CK IN ('Y', 'N')), /* 관리자인 경우 : Y , 회원인 경우 : N */
    CONSTRAINT CK_LOGIN_OK CHECK (LOGIN_OK IN ('Y', 'N')) /* 로그인 가능한 경우 : Y , 로그인 불가인 경우 : N */
);


insert into MEMBER values ('admin', 'admin', '김철수', '관리자', '01030230530', '1995/06/21' ,'M', 'ADMIN@ca.gov', 'Y', DEFAULT, DEFAULT, DEFAULT, DEFAULT);
insert into MEMBER values ('user01', 'user01', '박나래', '난유저야', '01030230531', '1988/10/18', 'F', 'admin02@ca.gov', 'N', DEFAULT, DEFAULT, DEFAULT, DEFAULT);



/* 코멘트 */
COMMENT ON TABLE MEMBER IS '회원정보 기본사항테이블';

COMMENT ON COLUMN MEMBER.USER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.USER_PW IS '회원패스워드';
COMMENT ON COLUMN MEMBER.USER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.USER_NICKNAME IS '회원닉네임';
COMMENT ON COLUMN MEMBER.PHONE IS '회원전화번호';
COMMENT ON COLUMN MEMBER.BIRTH IS '회원생일';
COMMENT ON COLUMN MEMBER.GENDER IS '회원성별';
COMMENT ON COLUMN MEMBER.EMAIL IS '회원이메일';
COMMENT ON COLUMN MEMBER.ADMIN_CK IS '관리자여부';
COMMENT ON COLUMN MEMBER.PROFILE_ORIGINFILE IS '프로필원본파일';
COMMENT ON COLUMN MEMBER.PROFILE_RENAMEFILE IS '프로필수정파일';
COMMENT ON COLUMN MEMBER.JOIN_DATE IS '회원가입일';
COMMENT ON COLUMN MEMBER.LOGIN_OK IS '로그인가능여부';


/* BANNER(관리자배너테이블) */
CREATE TABLE BANNER
(
    BANNER_NO             NUMBER,
    USER_ID               VARCHAR2(50)  NOT NULL,
    BANNER_POST_DATE      DATE          NOT NULL,
    BANNER_LAST_POST_DATE DATE          NOT NULL,
    BANNER_TITLE          VARCHAR2(200) NOT NULL,
    BANNER_ITEM           CHAR(1)       NOT NULL,
    BANNER_LINK_ADRRESS   VARCHAR2(200) NOT NULL,
    BANNER_IMG            VARCHAR2(200),

    CONSTRAINT PK_BANNER_NO PRIMARY KEY (BANNER_NO),
    CONSTRAINT FK_BANNER_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER,
    CONSTRAINT CK_BANNER_ITEM CHECK (BANNER_ITEM IN ('Y', 'A'))
);

/* 코멘트 */
COMMENT ON TABLE BANNER IS '관리자배너테이블';

COMMENT ON COLUMN BANNER.BANNER_NO IS '배너번호';
COMMENT ON COLUMN BANNER.USER_ID IS '관리자';
COMMENT ON COLUMN BANNER.BANNER_POST_DATE IS '배너등록일';
COMMENT ON COLUMN BANNER.BANNER_LAST_POST_DATE IS '배너게시종료일';
COMMENT ON COLUMN BANNER.BANNER_TITLE IS '배너제목';
COMMENT ON COLUMN BANNER.BANNER_ITEM IS '배너항목';
COMMENT ON COLUMN BANNER.BANNER_LINK_ADRRESS IS '배너주소';
COMMENT ON COLUMN BANNER.BANNER_IMG IS '배너이미지';

/* 시퀀스 */
CREATE SEQUENCE SEQ_BANNER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* -------------------------------------------------------------------------------- */

/* QNA(고객센터 1:1문의테이블) */
CREATE TABLE QNA
(
    QNA_NO         NUMBER,
    QNA_TITLE      VARCHAR2(200)       NOT NULL,
    USER_ID        VARCHAR2(50)        NOT NULL,
    QNA_POST_DATE  DATE                NOT NULL,
    QNA_VIEWS      NUMBER  DEFAULT 0,
    QNA_CONTENT    VARCHAR2(4000)      NOT NULL,
    QNA_ORIGINFILE VARCHAR2(200),
    QNA_RENAMEFILE VARCHAR2(200),
    QNA_PRIVATE    CHAR(1) DEFAULT 'Y' NOT NULL,
    QNA_REF        NUMBER  DEFAULT 1,
    QNA_SEQ        NUMBER  DEFAULT 1,
    QNA_LEV        NUMBER  DEFAULT 1,
    QNA_REPLY_REF  NUMBER,

    CONSTRAINT PK_QNA_NO PRIMARY KEY (QNA_NO),
    CONSTRAINT FK_QNA_WRITER FOREIGN KEY (USER_ID) REFERENCES MEMBER,
    CONSTRAINT CK_QNA_PRIVATE CHECK (QNA_PRIVATE IN ('Y', 'N'))
);

/* 코멘트 */
COMMENT ON TABLE QNA IS '고객센터 1대1문의테이블';

COMMENT ON COLUMN QNA.QNA_NO IS 'QNA번호';
COMMENT ON COLUMN QNA.QNA_TITLE IS 'QNA제목';
COMMENT ON COLUMN QNA.USER_ID IS 'QNA작성자';
COMMENT ON COLUMN QNA.QNA_POST_DATE IS 'QNA작성일';
COMMENT ON COLUMN QNA.QNA_VIEWS IS 'QNA조회수';
COMMENT ON COLUMN QNA.QNA_CONTENT IS 'QNA내용';
COMMENT ON COLUMN QNA.QNA_ORIGINFILE IS 'QNA원본파일';
COMMENT ON COLUMN QNA.QNA_RENAMEFILE IS 'QNA수정파일';
COMMENT ON COLUMN QNA.QNA_PRIVATE IS 'QNA공개여부';
COMMENT ON COLUMN QNA.QNA_REF IS 'QNA원글번호';
COMMENT ON COLUMN QNA.QNA_SEQ IS 'QNA답글순번';
COMMENT ON COLUMN QNA.QNA_LEV IS 'QNA답글단계';
COMMENT ON COLUMN QNA.QNA_REPLY_REF IS 'QNA답글번호';

/* 시퀀스 */
CREATE SEQUENCE SEQ_QNA
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* -------------------------------------------------------------------------------- */

/* FAQ(고객센터 FAQ테이블) */
CREATE TABLE FAQ
(
    FAQ_NO        NUMBER,
    FAQ_TITLE     VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID       VARCHAR2(50 BYTE)   NOT NULL,
    FAQ_POST_DATE DATE                NOT NULL,
    FAQ_VIEWS     NUMBER DEFAULT 0,
    FAQ_CONTENT   VARCHAR2(4000 BYTE) NOT NULL,
    FAQ_CAT       VARCHAR2(50 BYTE)   NOT NULL,

    CONSTRAINT PK_FAQ_NO PRIMARY KEY (FAQ_NO),
    CONSTRAINT FK_FAQ_WRITER FOREIGN KEY (USER_ID) REFERENCES MEMBER
);

/* 코멘트 */
COMMENT ON TABLE FAQ IS '고객센터 FAQ테이블';

COMMENT ON COLUMN FAQ.FAQ_NO IS 'FAQ번호';
COMMENT ON COLUMN FAQ.FAQ_TITLE IS 'FAQ제목';
COMMENT ON COLUMN FAQ.USER_ID IS 'FAQ관리자';
COMMENT ON COLUMN FAQ.FAQ_POST_DATE IS 'FAQ작성일';
COMMENT ON COLUMN FAQ.FAQ_VIEWS IS 'FAQ조회수';
COMMENT ON COLUMN FAQ.FAQ_CONTENT IS 'FAQ내용';
COMMENT ON COLUMN FAQ.FAQ_CAT IS 'FAQ카테고리';

/* 시퀀스 */
CREATE SEQUENCE SEQ_FAQ
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* -------------------------------------------------------------------------------- */

/* NOTICE(공지사항 테이블) */
CREATE TABLE NOTICE
(
    NOTICE_NO         NUMBER,
    NOTICE_TITLE      VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID           VARCHAR2(50 BYTE)   NOT NULL,
    WRITE_NOTICE_DATE DATE   DEFAULT SYSDATE,
    NOTICE_VIEWS      NUMBER DEFAULT 0,
    NOTICE_CONTENT    VARCHAR2(4000 BYTE) NOT NULL,
    NOTICE_ORIGINFILE VARCHAR2(200 BYTE),
    NOTICE_RENAMEFILE VARCHAR2(200 BYTE),

    CONSTRAINT PK_NOTICE_NO PRIMARY KEY (NOTICE_NO),
    CONSTRAINT FK_NOTICE_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER
);

/* 코멘트 */
COMMENT ON TABLE NOTICE IS '공지사항 테이블';
COMMENT ON COLUMN NOTICE.NOTICE_NO IS '공지사항글번호';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '공지사항제목';
COMMENT ON COLUMN NOTICE.USER_ID IS '공지사항작성자';
COMMENT ON COLUMN NOTICE.WRITE_NOTICE_DATE IS '공지사항작성일';
COMMENT ON COLUMN NOTICE.NOTICE_VIEWS IS '공지사항조회수';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '공지사항글내용';
COMMENT ON COLUMN NOTICE.NOTICE_ORIGINFILE IS '공지사항원본파일';
COMMENT ON COLUMN NOTICE.NOTICE_RENAMEFILE IS '공지사항수정파일';

/* 시퀀스 */
CREATE SEQUENCE SEQ_NOTICE
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* -------------------------------------------------------------------------------- */

/* EVENT(이벤트 테이블) */
CREATE TABLE EVENT
(
    EVENT_NO         NUMBER              NOT NULL,
    EVENT_TITLE      VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID          VARCHAR2(50 BYTE)   NOT NULL,
    WRITE_EVENT_DATE DATE   DEFAULT SYSDATE,
    EVENT_VIEWS      NUMBER DEFAULT 0,
    EVENT_CONTENT    VARCHAR2(4000 BYTE) NOT NULL,
    EVENT_ORIGINFILE VARCHAR2(200 BYTE),
    EVENT_RENAMEFILE VARCHAR2(200 BYTE),

    CONSTRAINT PK_EVENT_NO PRIMARY KEY (EVENT_NO),
    CONSTRAINT FK_EVENT_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER
);

/* 코멘트 */
COMMENT ON TABLE EVENT IS '이벤트 테이블';
COMMENT ON COLUMN EVENT.EVENT_NO IS '이벤트글번호';
COMMENT ON COLUMN EVENT.EVENT_TITLE IS '이벤트제목';
COMMENT ON COLUMN EVENT.USER_ID IS '이벤트작성자';
COMMENT ON COLUMN EVENT.WRITE_EVENT_DATE IS '이벤트작성일';
COMMENT ON COLUMN EVENT.EVENT_VIEWS IS '이벤트조회수';
COMMENT ON COLUMN EVENT.EVENT_CONTENT IS '이벤트글내용';
COMMENT ON COLUMN EVENT.EVENT_ORIGINFILE IS '이벤트원본파일';
COMMENT ON COLUMN EVENT.EVENT_RENAMEFILE IS '이벤트수정파일';

/* 시퀀스 */
CREATE SEQUENCE SEQ_EVENT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* QUIT(회원탈퇴 테이블) */
CREATE TABLE QUIT
(
    QUIT_USER_ID       VARCHAR2(50),
    QUIT_USER_PW       VARCHAR2(500),
    QUIT_USER_NAME     VARCHAR2(30),
    QUIT_USER_NICKNAME VARCHAR2(30),
    QUIT_PHONE         VARCHAR2(30),
    QUIT_BIRTH         DATE,
    QUIT_GENDER        CHAR(1),
    QUIT_EMAIL         VARCHAR2(100),
    QUIT_ADMIN_CK      CHAR(1), /* 관리자인 경우 : Y , 회원인 경우 : N */

    CONSTRAINT FK_QUIT_USER_ID FOREIGN KEY (QUIT_USER_ID) REFERENCES MEMBER
);


/* 코멘트 */
COMMENT ON TABLE QUIT IS '회원탈퇴 테이블';

COMMENT ON COLUMN QUIT.QUIT_USER_ID IS '탈퇴회원아이디';
COMMENT ON COLUMN QUIT.QUIT_USER_PW IS '탈퇴회원패스워드';
COMMENT ON COLUMN QUIT.QUIT_USER_NAME IS '탈퇴회원이름';
COMMENT ON COLUMN QUIT.QUIT_USER_NICKNAME IS '탈퇴회원닉네임';
COMMENT ON COLUMN QUIT.QUIT_PHONE IS '탈퇴회원전화번호';
COMMENT ON COLUMN QUIT.QUIT_BIRTH IS '탈퇴회원생일';
COMMENT ON COLUMN QUIT.QUIT_GENDER IS '탈퇴회원성별';
COMMENT ON COLUMN QUIT.QUIT_EMAIL IS '탈퇴회원이메일';
COMMENT ON COLUMN QUIT.QUIT_ADMIN_CK IS '탈퇴관리자여부';


/* LOG(로그테이블) */
CREATE TABLE LOG
(
    USER_ID    VARCHAR2(50),
    VISIT_IP   VARCHAR2(20),
    VISIT_TIME DATE,

    CONSTRAINT FK_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER
);


/* 코멘트 */
COMMENT ON TABLE LOG IS '로그테이블';

COMMENT ON COLUMN LOG.USER_ID IS '접속자수';
COMMENT ON COLUMN LOG.VISIT_IP IS '아이피주소';
COMMENT ON COLUMN LOG.VISIT_TIME IS '접속시간';

/* -------------------------------------------------------------------------------- */


/* ---------------------------------- 샘플데이터 ----------------------------------*/

/* 배너 */

truncate table banner;

/* 유튜브 */
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브01', 'Y', 'https://www.youtube.com/embed/yyjOhsNEqtE',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브02', 'Y', 'https://www.youtube.com/embed/CYcLODSeC-c',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브03', 'Y', 'https://www.youtube.com/embed/zSJYAyoojdw',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브04', 'Y', 'https://www.youtube.com/embed/lDsJi3_EW-Y',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브05', 'Y', 'https://www.youtube.com/embed/gMaB-fG4u4g',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브06', 'Y', 'https://www.youtube.com/embed/niSkbOuQG9I',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브07', 'Y', 'https://www.youtube.com/embed/SwlS857LjVc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브08', 'Y', 'https://www.youtube.com/embed/N-15wUPnqpc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브09', 'Y', 'https://www.youtube.com/embed/VtadZPVaglY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브10', 'Y', 'https://www.youtube.com/embed/n8zGSCTd1bA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브11', 'Y', 'https://www.youtube.com/embed/MMswNnLdHso',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브12', 'Y', 'https://www.youtube.com/embed/xG6epreSCek',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브13', 'Y', 'https://www.youtube.com/embed/FFWklphDy8A',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브14', 'Y', 'https://www.youtube.com/embed/TV3545H1wqw',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브15', 'Y', 'https://www.youtube.com/embed/0iqP6WP2ET4',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브16', 'Y', 'https://www.youtube.com/embed/hJ4_prZ9kB4',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브17', 'Y', 'https://www.youtube.com/embed/eOx7LQhXX_c',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브18', 'Y', 'https://www.youtube.com/embed/VNQpP6C1fJg',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브19', 'Y', 'https://www.youtube.com/embed/4AU4kY4CAio',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브20', 'Y', 'https://www.youtube.com/embed/DJPBglSOC88',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브21', 'Y', 'https://www.youtube.com/embed/Z0Z8_lVFkjk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브22', 'Y', 'https://www.youtube.com/embed/eQvBIvishmc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브23', 'Y', 'https://www.youtube.com/embed/sTX0C08SYBM',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브24', 'Y', 'https://www.youtube.com/embed/IU8wnFpbh2c',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브25', 'Y', 'https://www.youtube.com/embed/IgsyvlKKFzM',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브26', 'Y', 'https://www.youtube.com/embed/tE5WqR-IDiM',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브27', 'Y', 'https://www.youtube.com/embed/N3Hhhk74N3U',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브28', 'Y', 'https://www.youtube.com/embed/W4SpM2gxGdE',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브29', 'Y', 'https://www.youtube.com/embed/n5-Crk5mX-M',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브30', 'Y', 'https://www.youtube.com/embed/rSBOuArsz1k',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브31', 'Y', 'https://www.youtube.com/embed/nu8kTZZNbdk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브32', 'Y', 'https://www.youtube.com/embed/YVvfCKfokis',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브33', 'Y', 'https://www.youtube.com/embed/fp72Xfzud0s',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브34', 'Y', 'https://www.youtube.com/embed/v0mxhnfD2z8',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브35', 'Y', 'https://www.youtube.com/embed/kep-E_blfYg',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브36', 'Y', 'https://www.youtube.com/embed/_AH7u-q7V3M',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브37', 'Y', 'https://www.youtube.com/embed/WbxQdRI-YbQ',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브38', 'Y', 'https://www.youtube.com/embed/FGBdoLxzKOE',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브39', 'Y', 'https://www.youtube.com/embed/_JZeAYqQeII',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브40', 'Y', 'https://www.youtube.com/embed/eRZ3eFU1Pr8',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브41', 'Y', 'https://www.youtube.com/embed/mL4YteK8ANc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브42', 'Y', 'https://www.youtube.com/embed/46vQnzaZ6aU',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브43', 'Y', 'https://www.youtube.com/embed/JoyBhen4Zsg',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브44', 'Y', 'https://www.youtube.com/embed/1W9gMxLoW6Q',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브45', 'Y', 'https://www.youtube.com/embed/CnLZUXQofiI',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브46', 'Y', 'https://www.youtube.com/embed/vMLYQm2Q_q0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브47', 'Y', 'https://www.youtube.com/embed/KCAwey51gUc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브48', 'Y', 'https://www.youtube.com/embed/l4THcKL-sPM',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브49', 'Y', 'https://www.youtube.com/embed/pXzEw2D8bds',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브50', 'Y', 'https://www.youtube.com/embed/d60DyrNZpMA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브51', 'Y', 'https://www.youtube.com/embed/X2s3RZR8lPI',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브52', 'Y', 'https://www.youtube.com/embed/6_LYz_XxD-g',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브53', 'Y', 'https://www.youtube.com/embed/50WCSpZtdmA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브54', 'Y', 'https://www.youtube.com/embed/FMOISIlhLEY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브55', 'Y', 'https://www.youtube.com/embed/tZEZNsuDkLY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브56', 'Y', 'https://www.youtube.com/embed/VVn5IUM8sms',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브57', 'Y', 'https://www.youtube.com/embed/sLe6jgHoYtk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브58', 'Y', 'https://www.youtube.com/embed/4TwQwVFLi4Q',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브59', 'Y', 'https://www.youtube.com/embed/Q-C_NUKQr9g',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브60', 'Y', 'https://www.youtube.com/embed/q2jEHE7Ir3A',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브61', 'Y', 'https://www.youtube.com/embed/5J2a4uUrY2U',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브62', 'Y', 'https://www.youtube.com/embed/mUnSpfItRf0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브63', 'Y', 'https://www.youtube.com/embed/pc_hXPTLirA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브64', 'Y', 'https://www.youtube.com/embed/U6nnxml9GRs',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브65', 'Y', 'https://www.youtube.com/embed/Q6RQq32SNN4',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브66', 'Y', 'https://www.youtube.com/embed/8VtkpMGw0hw',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브67', 'Y', 'https://www.youtube.com/embed/iCndwkvhcmY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브68', 'Y', 'https://www.youtube.com/embed/aGF5A74zLVU',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브69', 'Y', 'https://www.youtube.com/embed/x2IWl3wT8Zc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브70', 'Y', 'https://www.youtube.com/embed/XdFhIyu_7Vw',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브71', 'Y', 'https://www.youtube.com/embed/aTcbqto_Tg0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브72', 'Y', 'https://www.youtube.com/embed/5DcdUr5hhhU',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브73', 'Y', 'https://www.youtube.com/embed/onGxALM_FI0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브74', 'Y', 'https://www.youtube.com/embed/y7f3QXwI2JY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브75', 'Y', 'https://www.youtube.com/embed/XVBSOujrJ6A',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브76', 'Y', 'https://www.youtube.com/embed/62uuqixUpso',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브77', 'Y', 'https://www.youtube.com/embed/qo-7v55SuCE',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브78', 'Y', 'https://www.youtube.com/embed/h8KbXLAS-xo',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브79', 'Y', 'https://www.youtube.com/embed/XmtnlvvqBHI',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브80', 'Y', 'https://www.youtube.com/embed/ONNdFtRaP5M',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브81', 'Y', 'https://www.youtube.com/embed/LjupwhdpvdQ',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브82', 'Y', 'https://www.youtube.com/embed/s4T6xDvGSJ0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브83', 'Y', 'https://www.youtube.com/embed/UcK8B_UWiVc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브84', 'Y', 'https://www.youtube.com/embed/ZgBfmJfE1Sk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브85', 'Y', 'https://www.youtube.com/embed/ZZbeRBCG6UY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브86', 'Y', 'https://www.youtube.com/embed/7Vqv5SmSKHY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브87', 'Y', 'https://www.youtube.com/embed/Ko9qLcABzmA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브88', 'Y', 'https://www.youtube.com/embed/TMpaMZ-Sa-o',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브89', 'Y', 'https://www.youtube.com/embed/tW2oRlPqGsU',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브90', 'Y', 'https://www.youtube.com/embed/KNxy25OnlNA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브91', 'Y', 'https://www.youtube.com/embed/nxLL_HjaAak',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브92', 'Y', 'https://www.youtube.com/embed/YKLdBhAVNxk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브93', 'Y', 'https://www.youtube.com/embed/AwdVp00S9SA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브94', 'Y', 'https://www.youtube.com/embed/AZzu826WFyc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브95', 'Y', 'https://www.youtube.com/embed/NlMjP_uaIW8',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브96', 'Y', 'https://www.youtube.com/embed/KtW7G525l9k',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브97', 'Y', 'https://www.youtube.com/embed/PTn45GXllMc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브98', 'Y', 'https://www.youtube.com/embed/UsShgd3M0LY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브99', 'Y', 'https://www.youtube.com/embed/1vfMmDuTweQ',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유튜브100', 'Y', 'https://www.youtube.com/embed/ewPh95Tzz7I',
        null);

/* 기사 */
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '노화 늦추고 싶다면? ''이 운동''이 제격', 'A',
        'https://n.news.naver.com/mnews/article/014/0004995175?sid=103',
        'https://imgnews.pstatic.net/image/014/2023/04/11/0004995175_001_20230411151704112.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '낮잠 1시간, 뜻밖의 결과가.. 숙면에 좋은 음식은?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064830?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064830_001_20230411150101312.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '비만 위험 26%나 증가…곳곳에 숨은 이 성분은?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064827?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064827_001_20230411130101285.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '"마시면 화장실 직행"… 美 스벅 신메뉴 ''설사 유발'' 이유는?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059920?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/11/0000059920_001_20230411113502005.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '다이어트 위해 먹은 곤약, 자칫하다간 장에 ''이런'' 문제', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059919?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/11/0000059919_001_20230411113101314.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '아침에 ''이것'' 건너뛴 사람… 스트레스 수준 1.4배 ↑', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059915?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/11/0000059915_001_20230411103601397.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '치아 위해...주의해야 할 식품 vs 먹어야 할 식품', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064815?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064815_001_20230411094001323.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '단 것 즐기면 생기는 질병....설탕 줄이는 방법은?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064814?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064814_001_20230411092901305.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '물 대신 마시기 좋은 음료 4가지', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059902?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/11/0000059902_001_20230411060101326.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '"고지방·고당분 음식, 우리의 뇌에 변화가?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064811?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064811_001_20230411092104443.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '‘악의 고리’ 운동으로 흘린 땀 삼켜버리는 야식', 'A',
        'https://n.news.naver.com/mnews/article/119/0002701302?sid=103',
        'https://imgnews.pstatic.net/image/119/2023/04/10/0002701302_001_20230411074101224.jpeg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '무알코올 vs 논알코올...잘못 마시면 당류 초과?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064808?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/10/0000064808_001_20230411090401342.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '나도 모르게 스트레스 받고 있다는 ''몸의 신호'' 5', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059889?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/10/0000059889_001_20230410165701290.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '여성이 걸릴 확률이 3배 더 높다는 이 질병...삼국지 조조도 앓았다는데', 'A',
        'https://n.news.naver.com/mnews/article/009/0005114201?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/04/10/0005114201_001_20230410153001031.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '20대 헬스케어족 “갓생 살려면 영양제 10알은 먹어야죠”', 'A',
        'https://n.news.naver.com/mnews/article/032/0003216350?sid=103',
        'https://imgnews.pstatic.net/image/032/2023/04/10/0003216350_001_20230410162707843.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '머위, 고추 등...알레르기 완화하는 자연요법', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064794?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/10/0000064794_001_20230410121701283.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '비만 남녀의 뇌구조 다르다', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064770?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/09/0000064770_001_20230409195801366.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '왜 안 빠지지? ''다이어트 정체기'' 벗어나는 방법 4', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059851?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/09/0000059851_001_20230409160101308.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '걷기, 공복, 근육… 건강한 장수의 비결 10', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064762?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/09/0000064762_001_20230409063101301.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '폭식증, 뇌 회로 이상으로 발생?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064758?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/08/0000064758_001_20230408200101307.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '건강 찾아 ''제로 커피''…인공감미료는 괜찮나?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064751?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/08/0000064751_001_20230408130101306.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '중성지방, 여>남 역전.. 갱년기 여성 위한 음식은?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064749?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/08/0000064749_001_20230408115901285.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '제철 맞은 두릅, ''이 질병'' 있다면 피해야', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064741?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/08/0000064741_001_20230408060201380.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''이 식품'' 살 빼는 중에도 ''마음껏''… 비만 전문가 추천', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059828?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059828_001_20230410091801413.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '식사 직후 운동했다가... 식사·운동 시간을 어떻게?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064733?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/07/0000064733_001_20230407150104274.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '에너지 태우는 ''베이지색 지방'', 나이들수록 감소하는 이유', 'A',
        'https://n.news.naver.com/mnews/article/584/0000022601?sid=103',
        'https://imgnews.pstatic.net/image/584/2023/04/07/0000022601_001_20230407135901559.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '현주엽 ''고기 다이어트'' 효과는? 3일간 고기만 먹었더니…', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059812?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059812_001_20230407134701296.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '목 안 말라도 물을 꼭 마셔야 하는 ''심각한'' 이유', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059811?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059811_001_20230407113101303.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '[밀당365] 혈당 걱정 줄인 ''피자빵'' 만들어요', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059805?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059805_001_20230407084101354.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '중년의 뱃살 관리...아침에 뭘 먹어야 할까', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064710?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/07/0000064710_001_20230407100101277.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '간단한데? 수명 늘리는 습관 ''3가지''', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059802?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059802_001_20230407073101305.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '유산소+근력... 고혈압 ''가장'' 낮추는 운동법은?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064709?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/07/0000064709_001_20230407132901307.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '밀가루 먹고 나서 속 불편하다면 대신 ''이것'' 먹어보세요', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059801?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059801_001_20230407085501325.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '지중해식단, 특히 중년 여성에 좋아', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064705?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/07/0000064705_001_20230407054501308.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '라면 먹을 때 김치 얹어 먹어야 되는 사람, 꼭 보세요', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059794?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059794_001_20230407134501312.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '한식 전후 제철인 봄나물 쑥… 냉한 기운 쫓아내 감기 예방 [한의사 曰 건강꿀팁]', 'A',
        'https://n.news.naver.com/mnews/article/014/0004993286?sid=103',
        'https://imgnews.pstatic.net/image/014/2023/04/06/0004993286_002_20230406185806817.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '포화지방과 불포화지방... 어떤 음식에 많을까?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064699?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/06/0000064699_001_20230406184601368.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '다이어트할 때 입에서 ''단내'' 나는 이유', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059773?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059773_001_20230406141501350.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '말랐던 코쿤, 9kg 증량… 비법은 먹기 아닌 ''이것''', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059772?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059772_001_20230406141504563.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '최강희 다이어트, 밀가루?설탕 끊었을 때 효과는?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059770?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059770_001_20230406132501329.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '30대부터 ''뼈 건강'' 챙겨야...골다공증 피하려면', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064681?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/06/0000064681_001_20230406145001355.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '근력운동만?....유산소 운동 병행, 고혈압 위험 ↓', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064680?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/06/0000064680_001_20230406142801326.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '평소에 밥 ''이렇게'' 먹으면, 피로 안 쌓여요', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059758?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059758_001_20230406060101319.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '뚱뚱하면 무릎 관절염 위험 높다… 대규모 연구로 확인', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059752?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/05/0000059752_001_20230405213101321.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '작은 습관으로 체질량 지수 줄이기', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064658?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/05/0000064658_001_20230405194601330.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '돼지 기름은 몸에 좋고, 소 기름은 나쁘다? 사실은…', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059737?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/05/0000059737_001_20230405171601381.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '착한 콜레스테롤의 배신..."심혈관 질환 위험 높일 수 있다"', 'A',
        'https://n.news.naver.com/mnews/article/584/0000022573?sid=103',
        'https://imgnews.pstatic.net/image/584/2023/04/05/0000022573_001_20230405155502293.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '알리코제약, 성균관대 약대와 업무협약 체결', 'A',
        'https://n.news.naver.com/mnews/article/009/0005115867?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/04/13/0005115867_001_20230413105908730.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '의자에 앉아서 ‘이것’ 못하면… 신체 기능 ‘퇴화’ 신호', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059990?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/13/0000059990_001_20230413050101304.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '단백질 보충제, ''이 증상'' 나타나면 줄여야', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058650?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058650_001_20230228230101353.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '스마트폰 보느라 턱 아플 때, ‘6?6?6’ 운동 해보세요', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058648?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058648_001_20230228210101333.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '살 안찌는 스프라이트 제로, 대신 피 굳는다?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063557?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/28/0000063557_001_20230228233901362.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '옆구리 통증이 특징… 몸살과 비슷한 ''이 질환'' ', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058644?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058644_001_20230228180101341.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, ' ''바이오헬스 마이스터대'' 도입…핵심인력 11만명 키운다', 'A',
        'https://www.sedaily.com/NewsView/29LXE150ND',
        'https://imgnews.pstatic.net/image/011/2023/02/28/0004161754_001_20230228221015758.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '만성통증 환자의 정신적 웰빙, ''이것''이 중요', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063553?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/28/0000063553_001_20230228160101284.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '귓불 만졌는데 무언가 잡힌다면… ‘이것’ 의심', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058638?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058638_001_20230228150101314.jpg?type=w647');
insert into BANNER c
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '치매 예방하는 ''10가지'' 생활습관', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058636?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058636_001_20230228144901327.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '두통-편두통 있다면, ‘혈당’부터 관리해야…왜?', 'A',
        'https://n.news.naver.com/mnews/article/016/0002110325?sid=103',
        'https://imgnews.pstatic.net/image/016/2023/02/28/20230228000496_0_20230228143702964.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''이 음료'' 다이어트에 좋다? 오히려 살 찌울 수도…', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058634?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058634_001_20230228145101370.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '척추에 문제 있는지… ''여기''만 봐도 알 수 있어', 'A',
        'https://n.news.naver.com/mnews/article/584/0000022573?sid=103',
        'https://imgnews.pstatic.net/image/584/2023/04/05/0000022573_001_20230405155502293.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '팔이 안 올라간다… 오십견일까, 회전근개파열일까?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058623?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058623_001_20230228102401404.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '대변볼 때 스마트폰 보면서도 치핵은 막는 방법', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058620?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058620_001_20230228100101354.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '눈곱 보면 병 안다… 유독 누렇다면?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058618?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058618_001_20230228100501328.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '이렇게 자면 5년 더 산다…CNN도 추천한 수면습관 5가지', 'A',
        'https://n.news.naver.com/mnews/article/016/0002109946?sid=103',
        'https://imgnews.pstatic.net/image/016/2023/02/28/20220922000460_0_20230228074901130.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '체중 감량, 이 ‘간식들’은 허하노라', 'A',
        'https://n.news.naver.com/mnews/article/145/0000018151?sid=103',
        'https://imgnews.pstatic.net/image/145/2023/02/28/0000018151_001_20230228072409458.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '[헬스S] 목에 이물감 생기고 헛기침 한다면…', 'A',
        'https://n.news.naver.com/mnews/article/417/0000899325?sid=103',
        'https://imgnews.pstatic.net/image/417/2023/02/28/0000899325_001_20230228052601494.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''운동 더하는데·'' 억울한 나잇살, 내려놓아야 하나', 'A',
        'https://n.news.naver.com/mnews/article/119/0002687724?sid=103',
        'https://imgnews.pstatic.net/image/119/2023/02/27/0002687724_001_20230227181901207.jpeg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '운동 안 하면 머리 나빠질까?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063519?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/27/0000063519_001_20230227180101310.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '두통에 눈물까지 주르륵? ''이 질환'' 의심해야', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058602?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/27/0000058602_001_20230227173401395.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '김민석, 다이어트 위해 ''이것'' 40장씩 먹어… 효과 있을까?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058596?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/27/0000058596_001_20230227145401410.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '허리 삐끗했을 때 효과 좋은 약은?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063509?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/27/0000063509_001_20230227130101508.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '속에 화가 부글부글… ''화병''에 대처하는 방법', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063480?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/26/0000063480_001_20230226183101323.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '“아침 저녁으로 쌀쌀하네”...새벽운동 갔다가 갑자기 쓰러졌다는데', 'A',
        'https://n.news.naver.com/mnews/article/009/0005093844?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/02/26/0005093844_001_20230227095403014.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''단백질 보충제'' 똑똑하게 고르는 법은?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063466?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/25/0000063466_001_20230225190101333.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '헬스클럽 ''이 운동'', 코로나 감염 위험 6배', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063459?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/25/0000063459_001_20230225131201369.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '운동 다시 시작할 시기...이럴 때 좋은 식품 6', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063456?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/25/0000063456_001_20230225111201407.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '이게 효과냐!! 고강도 운동 후 늘어난 체중 ‘왜’', 'A',
        'https://n.news.naver.com/mnews/article/119/0002687125?sid=103',
        'https://imgnews.pstatic.net/image/119/2023/02/25/0002687125_001_20230225110203099.jpeg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '낮은 지방, 높은 섬유질…심혈관 살리는 채소는?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063454?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/25/0000063454_001_20230225105901320.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''이 스트레칭'' 했다간… 목디스크 도진다', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058557?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/25/0000058557_001_20230225060101323.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '[주말엔 운동] 걷기 지루하다면? ''심폐·하체기능'' 높이는 이 운동 하자', 'A',
        'https://n.news.naver.com/mnews/article/031/0000730809?sid=103',
        'https://imgnews.pstatic.net/image/031/2023/02/25/0000730809_001_20230225000101079.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90,
        '뚱뚱한 아이들, 어른 돼도 비만 가능성 80%…"식사·운동 등 생활습관 고쳐야" [김정은 기자의 생생헬스]', 'A',
        'https://n.news.naver.com/mnews/article/015/0004814524?sid=103',
        'https://imgnews.pstatic.net/image/015/2023/02/24/0004814524_001_20230306171401047.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '운동, 한 달에 한 번만 해도… ''이 능력'' 향상에 도움', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058544?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/24/0000058544_001_20230224162901347.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '‘3대 500kg’, 나도 도전? 무리하다간 이런 일이', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058543?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/24/0000058543_001_20230224150101354.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '[같toon마음] 톡 쏘는 개운함... 제로탄산 돌풍', 'A',
        'https://n.news.naver.com/mnews/article/025/0003261934?sid=103',
        'https://imgnews.pstatic.net/image/025/2023/02/24/0003261934_001_20230224183902084.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '운동만 하면 울렁거리고 메스꺼워...왜?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063436?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/24/0000063436_001_20230224135601374.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '장 건강, 체중 감량… 그릭 요거트가 몸에 좋은 이유 5', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063417?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/24/0000063417_001_20230224063101320.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '허리디스크로 오해하기 쉬운 ‘이상근증후군’은 무엇', 'A',
        'https://n.news.naver.com/mnews/article/009/0005093151?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/02/23/0005093151_001_20230223211901010.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '‘ 간헐적 단식’ 살빼기에 효과적? "주의 사항 숙지해야"', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063409?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/23/0000063409_001_20230223170101313.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '두 달간 누워만 있게 했더니… ''몸''에 벌어진 일', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058508?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/23/0000058508_001_20230223173401422.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '누우면 괜찮은데… 일어섰을 때 뱃살 쏟아지면 ‘이 병’ 의심', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058491?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/23/0000058491_001_20230223100101372.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '채소 많이 먹으면 ‘이 질환’ 치료에 도움 된다', 'A',
        'https://n.news.naver.com/mnews/article/022/0003786339?sid=103',
        'https://imgnews.pstatic.net/image/022/2023/02/23/20230223504527_20230223235303401.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '운동 당장 시작!....단 한 번도 치매 예방 효과(연구)', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063383?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/23/0000063383_001_20230223095001540.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '다이어트에 식사 시간 제한보다 더 중요한 건?', 'A',
        'https://n.news.naver.com/mnews/article/023/0003747821?sid=103',
        'https://imgnews.pstatic.net/image/023/2023/02/22/0003747821_001_20230223000801076.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '여성, ''이 둘레'' 재보면 ‘비만 유전자’ 보유 가능성 안다', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058456?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/22/0000058456_001_20230222130101346.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '운동 중 무릎에서 ‘퍽’ 하는 느낌땐 ‘반월상 연골판 파열’ 의심을', 'A',
        'https://n.news.naver.com/mnews/article/009/0005091883?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/02/21/0005091883_001_20230221205201045.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '근육 키우려 ''이것'' 먹었다가… 탈모 생긴 까닭', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058408?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/21/0000058408_001_20230221104501373.jpg?type=w647');

/* QNA */
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '테스트 QNA 게시글', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);

/* FAQ */
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Short-nosed bandicoot', '계정');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Iguana, marine', '기타');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Cat, long-tailed spotted', '다이어리');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Buttermilk snake', '커뮤니티');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Tortoise, indian star', '이벤트');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Short-nosed bandicoot', '계정');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Iguana, marine', '기타');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Cat, long-tailed spotted', '다이어리');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Buttermilk snake', '커뮤니티');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Tortoise, indian star', '이벤트');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Short-nosed bandicoot', '계정');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '테스트 FAQ 게시글', 'admin', SYSDATE, 0, 'Iguana, marine', '기타');

/* EVENT */
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '테스트 이벤트 게시글', 'admin', DEFAULT, DEFAULT, '테스트 이벤트 게시글 내용입니다.', null, null);


/* NOTICE */
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '테스트 공지 게시글', 'admin', SYSDATE, DEFAULT, '테스트 공지 게시글 내용입니다.', null, null);

commit;

