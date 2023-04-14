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




/* MEMBER(ȸ������ �⺻�������̺�) */
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
    CONSTRAINT CK_ADMIN CHECK (ADMIN_CK IN ('Y', 'N')), /* �������� ��� : Y , ȸ���� ��� : N */
    CONSTRAINT CK_LOGIN_OK CHECK (LOGIN_OK IN ('Y', 'N')) /* �α��� ������ ��� : Y , �α��� �Ұ��� ��� : N */
);


insert into MEMBER values ('admin', 'admin', '��ö��', '������', '01030230530', '1995/06/21' ,'M', 'ADMIN@ca.gov', 'Y', DEFAULT, DEFAULT, DEFAULT, DEFAULT);
insert into MEMBER values ('user01', 'user01', '�ڳ���', '��������', '01030230531', '1988/10/18', 'F', 'admin02@ca.gov', 'N', DEFAULT, DEFAULT, DEFAULT, DEFAULT);



/* �ڸ�Ʈ */
COMMENT ON TABLE MEMBER IS 'ȸ������ �⺻�������̺�';

COMMENT ON COLUMN MEMBER.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.USER_PW IS 'ȸ���н�����';
COMMENT ON COLUMN MEMBER.USER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.USER_NICKNAME IS 'ȸ���г���';
COMMENT ON COLUMN MEMBER.PHONE IS 'ȸ����ȭ��ȣ';
COMMENT ON COLUMN MEMBER.BIRTH IS 'ȸ������';
COMMENT ON COLUMN MEMBER.GENDER IS 'ȸ������';
COMMENT ON COLUMN MEMBER.EMAIL IS 'ȸ���̸���';
COMMENT ON COLUMN MEMBER.ADMIN_CK IS '�����ڿ���';
COMMENT ON COLUMN MEMBER.PROFILE_ORIGINFILE IS '�����ʿ�������';
COMMENT ON COLUMN MEMBER.PROFILE_RENAMEFILE IS '�����ʼ�������';
COMMENT ON COLUMN MEMBER.JOIN_DATE IS 'ȸ��������';
COMMENT ON COLUMN MEMBER.LOGIN_OK IS '�α��ΰ��ɿ���';


/* BANNER(�����ڹ�����̺�) */
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

/* �ڸ�Ʈ */
COMMENT ON TABLE BANNER IS '�����ڹ�����̺�';

COMMENT ON COLUMN BANNER.BANNER_NO IS '��ʹ�ȣ';
COMMENT ON COLUMN BANNER.USER_ID IS '������';
COMMENT ON COLUMN BANNER.BANNER_POST_DATE IS '��ʵ����';
COMMENT ON COLUMN BANNER.BANNER_LAST_POST_DATE IS '��ʰԽ�������';
COMMENT ON COLUMN BANNER.BANNER_TITLE IS '�������';
COMMENT ON COLUMN BANNER.BANNER_ITEM IS '����׸�';
COMMENT ON COLUMN BANNER.BANNER_LINK_ADRRESS IS '����ּ�';
COMMENT ON COLUMN BANNER.BANNER_IMG IS '����̹���';

/* ������ */
CREATE SEQUENCE SEQ_BANNER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* -------------------------------------------------------------------------------- */

/* QNA(������ 1:1�������̺�) */
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

/* �ڸ�Ʈ */
COMMENT ON TABLE QNA IS '������ 1��1�������̺�';

COMMENT ON COLUMN QNA.QNA_NO IS 'QNA��ȣ';
COMMENT ON COLUMN QNA.QNA_TITLE IS 'QNA����';
COMMENT ON COLUMN QNA.USER_ID IS 'QNA�ۼ���';
COMMENT ON COLUMN QNA.QNA_POST_DATE IS 'QNA�ۼ���';
COMMENT ON COLUMN QNA.QNA_VIEWS IS 'QNA��ȸ��';
COMMENT ON COLUMN QNA.QNA_CONTENT IS 'QNA����';
COMMENT ON COLUMN QNA.QNA_ORIGINFILE IS 'QNA��������';
COMMENT ON COLUMN QNA.QNA_RENAMEFILE IS 'QNA��������';
COMMENT ON COLUMN QNA.QNA_PRIVATE IS 'QNA��������';
COMMENT ON COLUMN QNA.QNA_REF IS 'QNA���۹�ȣ';
COMMENT ON COLUMN QNA.QNA_SEQ IS 'QNA��ۼ���';
COMMENT ON COLUMN QNA.QNA_LEV IS 'QNA��۴ܰ�';
COMMENT ON COLUMN QNA.QNA_REPLY_REF IS 'QNA��۹�ȣ';

/* ������ */
CREATE SEQUENCE SEQ_QNA
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* -------------------------------------------------------------------------------- */

/* FAQ(������ FAQ���̺�) */
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

/* �ڸ�Ʈ */
COMMENT ON TABLE FAQ IS '������ FAQ���̺�';

COMMENT ON COLUMN FAQ.FAQ_NO IS 'FAQ��ȣ';
COMMENT ON COLUMN FAQ.FAQ_TITLE IS 'FAQ����';
COMMENT ON COLUMN FAQ.USER_ID IS 'FAQ������';
COMMENT ON COLUMN FAQ.FAQ_POST_DATE IS 'FAQ�ۼ���';
COMMENT ON COLUMN FAQ.FAQ_VIEWS IS 'FAQ��ȸ��';
COMMENT ON COLUMN FAQ.FAQ_CONTENT IS 'FAQ����';
COMMENT ON COLUMN FAQ.FAQ_CAT IS 'FAQī�װ�';

/* ������ */
CREATE SEQUENCE SEQ_FAQ
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* -------------------------------------------------------------------------------- */

/* NOTICE(�������� ���̺�) */
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

/* �ڸ�Ʈ */
COMMENT ON TABLE NOTICE IS '�������� ���̺�';
COMMENT ON COLUMN NOTICE.NOTICE_NO IS '�������ױ۹�ȣ';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '������������';
COMMENT ON COLUMN NOTICE.USER_ID IS '���������ۼ���';
COMMENT ON COLUMN NOTICE.WRITE_NOTICE_DATE IS '���������ۼ���';
COMMENT ON COLUMN NOTICE.NOTICE_VIEWS IS '����������ȸ��';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '�������ױ۳���';
COMMENT ON COLUMN NOTICE.NOTICE_ORIGINFILE IS '�������׿�������';
COMMENT ON COLUMN NOTICE.NOTICE_RENAMEFILE IS '�������׼�������';

/* ������ */
CREATE SEQUENCE SEQ_NOTICE
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* -------------------------------------------------------------------------------- */

/* EVENT(�̺�Ʈ ���̺�) */
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

/* �ڸ�Ʈ */
COMMENT ON TABLE EVENT IS '�̺�Ʈ ���̺�';
COMMENT ON COLUMN EVENT.EVENT_NO IS '�̺�Ʈ�۹�ȣ';
COMMENT ON COLUMN EVENT.EVENT_TITLE IS '�̺�Ʈ����';
COMMENT ON COLUMN EVENT.USER_ID IS '�̺�Ʈ�ۼ���';
COMMENT ON COLUMN EVENT.WRITE_EVENT_DATE IS '�̺�Ʈ�ۼ���';
COMMENT ON COLUMN EVENT.EVENT_VIEWS IS '�̺�Ʈ��ȸ��';
COMMENT ON COLUMN EVENT.EVENT_CONTENT IS '�̺�Ʈ�۳���';
COMMENT ON COLUMN EVENT.EVENT_ORIGINFILE IS '�̺�Ʈ��������';
COMMENT ON COLUMN EVENT.EVENT_RENAMEFILE IS '�̺�Ʈ��������';

/* ������ */
CREATE SEQUENCE SEQ_EVENT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

/* QUIT(ȸ��Ż�� ���̺�) */
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
    QUIT_ADMIN_CK      CHAR(1), /* �������� ��� : Y , ȸ���� ��� : N */

    CONSTRAINT FK_QUIT_USER_ID FOREIGN KEY (QUIT_USER_ID) REFERENCES MEMBER
);


/* �ڸ�Ʈ */
COMMENT ON TABLE QUIT IS 'ȸ��Ż�� ���̺�';

COMMENT ON COLUMN QUIT.QUIT_USER_ID IS 'Ż��ȸ�����̵�';
COMMENT ON COLUMN QUIT.QUIT_USER_PW IS 'Ż��ȸ���н�����';
COMMENT ON COLUMN QUIT.QUIT_USER_NAME IS 'Ż��ȸ���̸�';
COMMENT ON COLUMN QUIT.QUIT_USER_NICKNAME IS 'Ż��ȸ���г���';
COMMENT ON COLUMN QUIT.QUIT_PHONE IS 'Ż��ȸ����ȭ��ȣ';
COMMENT ON COLUMN QUIT.QUIT_BIRTH IS 'Ż��ȸ������';
COMMENT ON COLUMN QUIT.QUIT_GENDER IS 'Ż��ȸ������';
COMMENT ON COLUMN QUIT.QUIT_EMAIL IS 'Ż��ȸ���̸���';
COMMENT ON COLUMN QUIT.QUIT_ADMIN_CK IS 'Ż������ڿ���';


/* LOG(�α����̺�) */
CREATE TABLE LOG
(
    USER_ID    VARCHAR2(50),
    VISIT_IP   VARCHAR2(20),
    VISIT_TIME DATE,

    CONSTRAINT FK_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER
);


/* �ڸ�Ʈ */
COMMENT ON TABLE LOG IS '�α����̺�';

COMMENT ON COLUMN LOG.USER_ID IS '�����ڼ�';
COMMENT ON COLUMN LOG.VISIT_IP IS '�������ּ�';
COMMENT ON COLUMN LOG.VISIT_TIME IS '���ӽð�';

/* -------------------------------------------------------------------------------- */


/* ---------------------------------- ���õ����� ----------------------------------*/

/* ��� */

truncate table banner;

/* ��Ʃ�� */
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��01', 'Y', 'https://www.youtube.com/embed/yyjOhsNEqtE',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��02', 'Y', 'https://www.youtube.com/embed/CYcLODSeC-c',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��03', 'Y', 'https://www.youtube.com/embed/zSJYAyoojdw',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��04', 'Y', 'https://www.youtube.com/embed/lDsJi3_EW-Y',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��05', 'Y', 'https://www.youtube.com/embed/gMaB-fG4u4g',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��06', 'Y', 'https://www.youtube.com/embed/niSkbOuQG9I',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��07', 'Y', 'https://www.youtube.com/embed/SwlS857LjVc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��08', 'Y', 'https://www.youtube.com/embed/N-15wUPnqpc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��09', 'Y', 'https://www.youtube.com/embed/VtadZPVaglY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��10', 'Y', 'https://www.youtube.com/embed/n8zGSCTd1bA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��11', 'Y', 'https://www.youtube.com/embed/MMswNnLdHso',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��12', 'Y', 'https://www.youtube.com/embed/xG6epreSCek',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��13', 'Y', 'https://www.youtube.com/embed/FFWklphDy8A',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��14', 'Y', 'https://www.youtube.com/embed/TV3545H1wqw',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��15', 'Y', 'https://www.youtube.com/embed/0iqP6WP2ET4',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��16', 'Y', 'https://www.youtube.com/embed/hJ4_prZ9kB4',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��17', 'Y', 'https://www.youtube.com/embed/eOx7LQhXX_c',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��18', 'Y', 'https://www.youtube.com/embed/VNQpP6C1fJg',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��19', 'Y', 'https://www.youtube.com/embed/4AU4kY4CAio',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��20', 'Y', 'https://www.youtube.com/embed/DJPBglSOC88',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��21', 'Y', 'https://www.youtube.com/embed/Z0Z8_lVFkjk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��22', 'Y', 'https://www.youtube.com/embed/eQvBIvishmc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��23', 'Y', 'https://www.youtube.com/embed/sTX0C08SYBM',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��24', 'Y', 'https://www.youtube.com/embed/IU8wnFpbh2c',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��25', 'Y', 'https://www.youtube.com/embed/IgsyvlKKFzM',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��26', 'Y', 'https://www.youtube.com/embed/tE5WqR-IDiM',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��27', 'Y', 'https://www.youtube.com/embed/N3Hhhk74N3U',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��28', 'Y', 'https://www.youtube.com/embed/W4SpM2gxGdE',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��29', 'Y', 'https://www.youtube.com/embed/n5-Crk5mX-M',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��30', 'Y', 'https://www.youtube.com/embed/rSBOuArsz1k',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��31', 'Y', 'https://www.youtube.com/embed/nu8kTZZNbdk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��32', 'Y', 'https://www.youtube.com/embed/YVvfCKfokis',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��33', 'Y', 'https://www.youtube.com/embed/fp72Xfzud0s',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��34', 'Y', 'https://www.youtube.com/embed/v0mxhnfD2z8',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��35', 'Y', 'https://www.youtube.com/embed/kep-E_blfYg',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��36', 'Y', 'https://www.youtube.com/embed/_AH7u-q7V3M',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��37', 'Y', 'https://www.youtube.com/embed/WbxQdRI-YbQ',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��38', 'Y', 'https://www.youtube.com/embed/FGBdoLxzKOE',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��39', 'Y', 'https://www.youtube.com/embed/_JZeAYqQeII',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��40', 'Y', 'https://www.youtube.com/embed/eRZ3eFU1Pr8',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��41', 'Y', 'https://www.youtube.com/embed/mL4YteK8ANc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��42', 'Y', 'https://www.youtube.com/embed/46vQnzaZ6aU',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��43', 'Y', 'https://www.youtube.com/embed/JoyBhen4Zsg',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��44', 'Y', 'https://www.youtube.com/embed/1W9gMxLoW6Q',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��45', 'Y', 'https://www.youtube.com/embed/CnLZUXQofiI',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��46', 'Y', 'https://www.youtube.com/embed/vMLYQm2Q_q0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��47', 'Y', 'https://www.youtube.com/embed/KCAwey51gUc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��48', 'Y', 'https://www.youtube.com/embed/l4THcKL-sPM',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��49', 'Y', 'https://www.youtube.com/embed/pXzEw2D8bds',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��50', 'Y', 'https://www.youtube.com/embed/d60DyrNZpMA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��51', 'Y', 'https://www.youtube.com/embed/X2s3RZR8lPI',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��52', 'Y', 'https://www.youtube.com/embed/6_LYz_XxD-g',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��53', 'Y', 'https://www.youtube.com/embed/50WCSpZtdmA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��54', 'Y', 'https://www.youtube.com/embed/FMOISIlhLEY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��55', 'Y', 'https://www.youtube.com/embed/tZEZNsuDkLY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��56', 'Y', 'https://www.youtube.com/embed/VVn5IUM8sms',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��57', 'Y', 'https://www.youtube.com/embed/sLe6jgHoYtk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��58', 'Y', 'https://www.youtube.com/embed/4TwQwVFLi4Q',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��59', 'Y', 'https://www.youtube.com/embed/Q-C_NUKQr9g',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��60', 'Y', 'https://www.youtube.com/embed/q2jEHE7Ir3A',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��61', 'Y', 'https://www.youtube.com/embed/5J2a4uUrY2U',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��62', 'Y', 'https://www.youtube.com/embed/mUnSpfItRf0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��63', 'Y', 'https://www.youtube.com/embed/pc_hXPTLirA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��64', 'Y', 'https://www.youtube.com/embed/U6nnxml9GRs',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��65', 'Y', 'https://www.youtube.com/embed/Q6RQq32SNN4',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��66', 'Y', 'https://www.youtube.com/embed/8VtkpMGw0hw',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��67', 'Y', 'https://www.youtube.com/embed/iCndwkvhcmY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��68', 'Y', 'https://www.youtube.com/embed/aGF5A74zLVU',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��69', 'Y', 'https://www.youtube.com/embed/x2IWl3wT8Zc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��70', 'Y', 'https://www.youtube.com/embed/XdFhIyu_7Vw',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��71', 'Y', 'https://www.youtube.com/embed/aTcbqto_Tg0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��72', 'Y', 'https://www.youtube.com/embed/5DcdUr5hhhU',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��73', 'Y', 'https://www.youtube.com/embed/onGxALM_FI0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��74', 'Y', 'https://www.youtube.com/embed/y7f3QXwI2JY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��75', 'Y', 'https://www.youtube.com/embed/XVBSOujrJ6A',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��76', 'Y', 'https://www.youtube.com/embed/62uuqixUpso',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��77', 'Y', 'https://www.youtube.com/embed/qo-7v55SuCE',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��78', 'Y', 'https://www.youtube.com/embed/h8KbXLAS-xo',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��79', 'Y', 'https://www.youtube.com/embed/XmtnlvvqBHI',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��80', 'Y', 'https://www.youtube.com/embed/ONNdFtRaP5M',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��81', 'Y', 'https://www.youtube.com/embed/LjupwhdpvdQ',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��82', 'Y', 'https://www.youtube.com/embed/s4T6xDvGSJ0',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��83', 'Y', 'https://www.youtube.com/embed/UcK8B_UWiVc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��84', 'Y', 'https://www.youtube.com/embed/ZgBfmJfE1Sk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��85', 'Y', 'https://www.youtube.com/embed/ZZbeRBCG6UY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��86', 'Y', 'https://www.youtube.com/embed/7Vqv5SmSKHY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��87', 'Y', 'https://www.youtube.com/embed/Ko9qLcABzmA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��88', 'Y', 'https://www.youtube.com/embed/TMpaMZ-Sa-o',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��89', 'Y', 'https://www.youtube.com/embed/tW2oRlPqGsU',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��90', 'Y', 'https://www.youtube.com/embed/KNxy25OnlNA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��91', 'Y', 'https://www.youtube.com/embed/nxLL_HjaAak',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��92', 'Y', 'https://www.youtube.com/embed/YKLdBhAVNxk',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��93', 'Y', 'https://www.youtube.com/embed/AwdVp00S9SA',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��94', 'Y', 'https://www.youtube.com/embed/AZzu826WFyc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��95', 'Y', 'https://www.youtube.com/embed/NlMjP_uaIW8',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��96', 'Y', 'https://www.youtube.com/embed/KtW7G525l9k',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��97', 'Y', 'https://www.youtube.com/embed/PTn45GXllMc',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��98', 'Y', 'https://www.youtube.com/embed/UsShgd3M0LY',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��99', 'Y', 'https://www.youtube.com/embed/1vfMmDuTweQ',
        null);
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��Ʃ��100', 'Y', 'https://www.youtube.com/embed/ewPh95Tzz7I',
        null);

/* ��� */
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��ȭ ���߰� �ʹٸ�? ''�� �''�� ����', 'A',
        'https://n.news.naver.com/mnews/article/014/0004995175?sid=103',
        'https://imgnews.pstatic.net/image/014/2023/04/11/0004995175_001_20230411151704112.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� 1�ð�, ����� �����.. ���鿡 ���� ������?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064830?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064830_001_20230411150101312.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� ���� 26%�� ������������ ���� �� ������?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064827?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064827_001_20230411130101285.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '"���ø� ȭ��� ����"�� ڸ ���� �Ÿ޴� ''���� ����'' ������?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059920?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/11/0000059920_001_20230411113502005.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���̾�Ʈ ���� ���� ���, ��ĩ�ϴٰ� �忡 ''�̷�'' ����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059919?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/11/0000059919_001_20230411113101314.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��ħ�� ''�̰�'' �ǳʶ� ����� ��Ʈ���� ���� 1.4�� ��', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059915?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/11/0000059915_001_20230411103601397.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, 'ġ�� ����...�����ؾ� �� ��ǰ vs �Ծ�� �� ��ǰ', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064815?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064815_001_20230411094001323.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� �� ���� ����� ����....���� ���̴� �����?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064814?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064814_001_20230411092901305.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� ��� ���ñ� ���� ���� 4����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059902?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/11/0000059902_001_20230411060101326.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '"�����桤���� ����, �츮�� ���� ��ȭ��?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064811?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/11/0000064811_001_20230411092104443.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '������ ���� ����� �기 �� ���ѹ����� �߽�', 'A',
        'https://n.news.naver.com/mnews/article/119/0002701302?sid=103',
        'https://imgnews.pstatic.net/image/119/2023/04/10/0002701302_001_20230411074101224.jpeg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�����ڿ� vs ����ڿ�...�߸� ���ø� ��� �ʰ�?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064808?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/10/0000064808_001_20230411090401342.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� �𸣰� ��Ʈ���� �ް� �ִٴ� ''���� ��ȣ'' 5', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059889?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/10/0000059889_001_20230410165701290.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '������ �ɸ� Ȯ���� 3�� �� ���ٴ� �� ����...�ﱹ�� ������ �ξҴٴµ�', 'A',
        'https://n.news.naver.com/mnews/article/009/0005114201?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/04/10/0005114201_001_20230410153001031.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '20�� �ｺ�ɾ��� ������ ����� ������ 10���� �Ծ���ҡ�', 'A',
        'https://n.news.naver.com/mnews/article/032/0003216350?sid=103',
        'https://imgnews.pstatic.net/image/032/2023/04/10/0003216350_001_20230410162707843.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '����, ���� ��...�˷����� ��ȭ�ϴ� �ڿ����', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064794?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/10/0000064794_001_20230410121701283.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� ������ ������ �ٸ���', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064770?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/09/0000064770_001_20230409195801366.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� �� ������? ''���̾�Ʈ ��ü��'' ����� ��� 4', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059851?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/09/0000059851_001_20230409160101308.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�ȱ�, ����, ������ �ǰ��� ����� ��� 10', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064762?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/09/0000064762_001_20230409063101301.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '������, �� ȸ�� �̻����� �߻�?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064758?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/08/0000064758_001_20230408200101307.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�ǰ� ã�� ''���� Ŀ��''���ΰ����̷�� ������?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064751?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/08/0000064751_001_20230408130101306.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�߼�����, ��>�� ����.. ����� ���� ���� ������?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064749?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/08/0000064749_001_20230408115901285.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��ö ���� �θ�, ''�� ����'' �ִٸ� ���ؾ�', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064741?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/08/0000064741_001_20230408060201380.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''�� ��ǰ'' �� ���� �߿��� ''������''�� �� ������ ��õ', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059828?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059828_001_20230410091801413.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�Ļ� ���� ��ߴٰ�... �Ļ硤� �ð��� ���?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064733?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/07/0000064733_001_20230407150104274.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '������ �¿�� ''�������� ����'', ���̵���� �����ϴ� ����', 'A',
        'https://n.news.naver.com/mnews/article/584/0000022601?sid=103',
        'https://imgnews.pstatic.net/image/584/2023/04/07/0000022601_001_20230407135901559.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���ֿ� ''��� ���̾�Ʈ'' ȿ����? 3�ϰ� ��⸸ �Ծ����ϡ�', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059812?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059812_001_20230407134701296.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� �� ���� ���� �� ���ž� �ϴ� ''�ɰ���'' ����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059811?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059811_001_20230407113101303.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '[�д�365] ���� ���� ���� ''���ڻ�'' ������', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059805?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059805_001_20230407084101354.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�߳��� ��� ����...��ħ�� �� �Ծ�� �ұ�', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064710?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/07/0000064710_001_20230407100101277.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�����ѵ�? ���� �ø��� ���� ''3����''', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059802?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059802_001_20230407073101305.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�����+�ٷ�... ������ ''����'' ���ߴ� �����?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064709?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/07/0000064709_001_20230407132901307.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�а��� �԰� ���� �� �����ϴٸ� ��� ''�̰�'' �Ծ����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059801?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/07/0000059801_001_20230407085501325.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�����ؽĴ�, Ư�� �߳� ������ ����', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064705?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/07/0000064705_001_20230407054501308.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��� ���� �� ��ġ ��� �Ծ�� �Ǵ� ���, �� ������', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059794?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059794_001_20230407134501312.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�ѽ� ���� ��ö�� ������ ���� ���� ��� �ѾƳ� ���� ���� [���ǻ� �� �ǰ�����]', 'A',
        'https://n.news.naver.com/mnews/article/014/0004993286?sid=103',
        'https://imgnews.pstatic.net/image/014/2023/04/06/0004993286_002_20230406185806817.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��ȭ����� ����ȭ����... � ���Ŀ� ������?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064699?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/06/0000064699_001_20230406184601368.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���̾�Ʈ�� �� �Կ��� ''�ܳ�'' ���� ����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059773?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059773_001_20230406141501350.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '������ ����, 9kg ������ ����� �Ա� �ƴ� ''�̰�''', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059772?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059772_001_20230406141504563.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�ְ��� ���̾�Ʈ, �а���?���� ������ �� ȿ����?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059770?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059770_001_20230406132501329.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '30����� ''�� �ǰ�'' ì�ܾ�...��ٰ��� ���Ϸ���', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064681?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/06/0000064681_001_20230406145001355.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�ٷ¿��?....����� � ����, ������ ���� ��', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064680?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/06/0000064680_001_20230406142801326.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��ҿ� �� ''�̷���'' ������, �Ƿ� �� �׿���', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059758?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/06/0000059758_001_20230406060101319.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�׶��ϸ� ���� ������ ���� ���١� ��Ը� ������ Ȯ��', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059752?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/05/0000059752_001_20230405213101321.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� �������� ü���� ���� ���̱�', 'A',
        'https://n.news.naver.com/mnews/article/296/0000064658?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/04/05/0000064658_001_20230405194601330.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� �⸧�� ���� ����, �� �⸧�� ���ڴ�? �������', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059737?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/05/0000059737_001_20230405171601381.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� �ݷ����׷��� ���..."������ ��ȯ ���� ���� �� �ִ�"', 'A',
        'https://n.news.naver.com/mnews/article/584/0000022573?sid=103',
        'https://imgnews.pstatic.net/image/584/2023/04/05/0000022573_001_20230405155502293.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�˸�������, ���հ��� ���� �������� ü��', 'A',
        'https://n.news.naver.com/mnews/article/009/0005115867?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/04/13/0005115867_001_20230413105908730.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���ڿ� �ɾƼ� ���̰͡� ���ϸ顦 ��ü ��� ����ȭ�� ��ȣ', 'A',
        'https://n.news.naver.com/mnews/article/346/0000059990?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/04/13/0000059990_001_20230413050101304.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�ܹ��� ������, ''�� ����'' ��Ÿ���� �ٿ���', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058650?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058650_001_20230228230101353.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '����Ʈ�� ������ �� ���� ��, ��6?6?6�� � �غ�����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058648?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058648_001_20230228210101333.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� ����� ��������Ʈ ����, ��� �� ���´�?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063557?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/28/0000063557_001_20230228233901362.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '������ ������ Ư¡�� ����� ����� ''�� ��ȯ'' ', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058644?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058644_001_20230228180101341.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, ' ''���̿��ｺ ���̽��ʹ�'' ���ԡ��ٽ��η� 11���� Ű���', 'A',
        'https://www.sedaily.com/NewsView/29LXE150ND',
        'https://imgnews.pstatic.net/image/011/2023/02/28/0004161754_001_20230228221015758.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�������� ȯ���� ������ ����, ''�̰�''�� �߿�', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063553?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/28/0000063553_001_20230228160101284.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�Ӻ� �����µ� ���� �����ٸ顦 ���̰͡� �ǽ�', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058638?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058638_001_20230228150101314.jpg?type=w647');
insert into BANNER c
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, 'ġ�� �����ϴ� ''10����'' ��Ȱ����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058636?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058636_001_20230228144901327.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '����-����� �ִٸ�, �����硯���� �����ؾߡ���?', 'A',
        'https://n.news.naver.com/mnews/article/016/0002110325?sid=103',
        'https://imgnews.pstatic.net/image/016/2023/02/28/20230228000496_0_20230228143702964.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''�� ����'' ���̾�Ʈ�� ����? ������ �� ��� ������', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058634?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058634_001_20230228145101370.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, 'ô�߿� ���� �ִ����� ''����''�� ���� �� �� �־�', 'A',
        'https://n.news.naver.com/mnews/article/584/0000022573?sid=103',
        'https://imgnews.pstatic.net/image/584/2023/04/05/0000022573_001_20230405155502293.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� �� �ö󰣴١� ���ʰ��ϱ�, ȸ���ٰ��Ŀ��ϱ�?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058623?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058623_001_20230228102401404.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�뺯�� �� ����Ʈ�� ���鼭�� ġ���� ���� ���', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058620?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058620_001_20230228100101354.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� ���� �� �ȴ١� ���� �����ٸ�?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058618?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/28/0000058618_001_20230228100501328.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�̷��� �ڸ� 5�� �� ��١�CNN�� ��õ�� ������� 5����', 'A',
        'https://n.news.naver.com/mnews/article/016/0002109946?sid=103',
        'https://imgnews.pstatic.net/image/016/2023/02/28/20220922000460_0_20230228074901130.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, 'ü�� ����, �� �����ĵ顯�� ���ϳ��', 'A',
        'https://n.news.naver.com/mnews/article/145/0000018151?sid=103',
        'https://imgnews.pstatic.net/image/145/2023/02/28/0000018151_001_20230228072409458.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '[�ｺS] �� �̹��� ����� ���ħ �Ѵٸ顦', 'A',
        'https://n.news.naver.com/mnews/article/417/0000899325?sid=103',
        'https://imgnews.pstatic.net/image/417/2023/02/28/0000899325_001_20230228052601494.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''� ���ϴµ���'' ����� ���ջ�, �������ƾ� �ϳ�', 'A',
        'https://n.news.naver.com/mnews/article/119/0002687724?sid=103',
        'https://imgnews.pstatic.net/image/119/2023/02/27/0002687724_001_20230227181901207.jpeg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '� �� �ϸ� �Ӹ� ��������?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063519?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/27/0000063519_001_20230227180101310.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���뿡 �������� �ָ���? ''�� ��ȯ'' �ǽ��ؾ�', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058602?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/27/0000058602_001_20230227173401395.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��μ�, ���̾�Ʈ ���� ''�̰�'' 40�徿 �Ծ ȿ�� ������?', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058596?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/27/0000058596_001_20230227145401410.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�㸮 �߲����� �� ȿ�� ���� ����?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063509?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/27/0000063509_001_20230227130101508.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�ӿ� ȭ�� �αۺαۡ� ''ȭ��''�� ��ó�ϴ� ���', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063480?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/26/0000063480_001_20230226183101323.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '����ħ �������� �ҽ��ϳס�...����� ���ٰ� ���ڱ� �������ٴµ�', 'A',
        'https://n.news.naver.com/mnews/article/009/0005093844?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/02/26/0005093844_001_20230227095403014.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''�ܹ��� ������'' �ȶ��ϰ� ���� ����?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063466?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/25/0000063466_001_20230225190101333.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�ｺŬ�� ''�� �'', �ڷγ� ���� ���� 6��', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063459?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/25/0000063459_001_20230225131201369.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '� �ٽ� ������ �ñ�...�̷� �� ���� ��ǰ 6', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063456?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/25/0000063456_001_20230225111201407.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�̰� ȿ����!! ���� � �� �þ ü�� ���֡�', 'A',
        'https://n.news.naver.com/mnews/article/119/0002687125?sid=103',
        'https://imgnews.pstatic.net/image/119/2023/02/25/0002687125_001_20230225110203099.jpeg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� ����, ���� �������������� �츮�� ä�Ҵ�?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063454?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/25/0000063454_001_20230225105901320.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '''�� ��Ʈ��Ī'' �ߴٰ��� ���ũ ������', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058557?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/25/0000058557_001_20230225060101323.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '[�ָ��� �] �ȱ� �����ϴٸ�? ''������ü���'' ���̴� �� � ����', 'A',
        'https://n.news.naver.com/mnews/article/031/0000730809?sid=103',
        'https://imgnews.pstatic.net/image/031/2023/02/25/0000730809_001_20230225000101079.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90,
        '�׶��� ���̵�, � �ŵ� �� ���ɼ� 80%��"�Ļ硤� �� ��Ȱ���� ���ľ�" [������ ������ �����ｺ]', 'A',
        'https://n.news.naver.com/mnews/article/015/0004814524?sid=103',
        'https://imgnews.pstatic.net/image/015/2023/02/24/0004814524_001_20230306171401047.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�, �� �޿� �� ���� �ص��� ''�� �ɷ�'' ��� ����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058544?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/24/0000058544_001_20230224162901347.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��3�� 500kg��, ���� ����? �����ϴٰ� �̷� ����', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058543?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/24/0000058543_001_20230224150101354.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '[��toon����] �� ��� ������... ����ź�� ��ǳ', 'A',
        'https://n.news.naver.com/mnews/article/025/0003261934?sid=103',
        'https://imgnews.pstatic.net/image/025/2023/02/24/0003261934_001_20230224183902084.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '��� �ϸ� �ﷷ�Ÿ��� �޽�����...��?', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063436?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/24/0000063436_001_20230224135601374.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� �ǰ�, ü�� ������ �׸� ���Ʈ�� ���� ���� ���� 5', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063417?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/24/0000063417_001_20230224063101320.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�㸮��ũ�� �����ϱ� ���� ���̻�����ı����� ����', 'A',
        'https://n.news.naver.com/mnews/article/009/0005093151?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/02/23/0005093151_001_20230223211901010.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� ������ �ܽġ� �컩�⿡ ȿ����? "���� ���� �����ؾ�"', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063409?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/23/0000063409_001_20230223170101313.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '�� �ް� ������ �ְ� �ߴ��ϡ� ''��''�� ������ ��', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058508?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/23/0000058508_001_20230223173401422.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '����� ���������� �Ͼ�� �� ��� ������� ���� ���� �ǽ�', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058491?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/23/0000058491_001_20230223100101372.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, 'ä�� ���� ������ ���� ��ȯ�� ġ�ῡ ���� �ȴ�', 'A',
        'https://n.news.naver.com/mnews/article/022/0003786339?sid=103',
        'https://imgnews.pstatic.net/image/022/2023/02/23/20230223504527_20230223235303401.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '� ���� ����!....�� �� ���� ġ�� ���� ȿ��(����)', 'A',
        'https://n.news.naver.com/mnews/article/296/0000063383?sid=103',
        'https://imgnews.pstatic.net/image/296/2023/02/23/0000063383_001_20230223095001540.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���̾�Ʈ�� �Ļ� �ð� ���Ѻ��� �� �߿��� ��?', 'A',
        'https://n.news.naver.com/mnews/article/023/0003747821?sid=103',
        'https://imgnews.pstatic.net/image/023/2023/02/22/0003747821_001_20230223000801076.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '����, ''�� �ѷ�'' �纸�� ���� �����ڡ� ���� ���ɼ� �ȴ�', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058456?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/22/0000058456_001_20230222130101346.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '� �� �������� ���ܡ� �ϴ� ������ ���ݿ��� ������ �Ŀ��� �ǽ���', 'A',
        'https://n.news.naver.com/mnews/article/009/0005091883?sid=103',
        'https://imgnews.pstatic.net/image/009/2023/02/21/0005091883_001_20230221205201045.jpg?type=w647');
insert into BANNER
values (SEQ_BANNER.NEXTVAL, 'admin', SYSDATE, SYSDATE + 90, '���� Ű��� ''�̰�'' �Ծ��ٰ��� Ż�� ���� ���', 'A',
        'https://n.news.naver.com/mnews/article/346/0000058408?sid=103',
        'https://imgnews.pstatic.net/image/346/2023/02/21/0000058408_001_20230221104501373.jpg?type=w647');

/* QNA */
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);
insert into QNA
values (SEQ_QNA.NEXTVAL, '�׽�Ʈ QNA �Խñ�', 'user01', SYSDATE, 0, 'Short-nosed bandicoot', NULL, NULL, 'Y', DEFAULT,
        DEFAULT, DEFAULT, DEFAULT);

/* FAQ */
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Short-nosed bandicoot', '����');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Iguana, marine', '��Ÿ');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Cat, long-tailed spotted', '���̾');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Buttermilk snake', 'Ŀ�´�Ƽ');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Tortoise, indian star', '�̺�Ʈ');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Short-nosed bandicoot', '����');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Iguana, marine', '��Ÿ');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Cat, long-tailed spotted', '���̾');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Buttermilk snake', 'Ŀ�´�Ƽ');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Tortoise, indian star', '�̺�Ʈ');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Short-nosed bandicoot', '����');
insert into FAQ
values (SEQ_FAQ.NEXTVAL, '�׽�Ʈ FAQ �Խñ�', 'admin', SYSDATE, 0, 'Iguana, marine', '��Ÿ');

/* EVENT */
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);
INSERT INTO EVENT
VALUES (SEQ_EVENT.NEXTVAL, '�׽�Ʈ �̺�Ʈ �Խñ�', 'admin', DEFAULT, DEFAULT, '�׽�Ʈ �̺�Ʈ �Խñ� �����Դϴ�.', null, null);


/* NOTICE */
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);
INSERT INTO NOTICE
VALUES (SEQ_NOTICE.NEXTVAL, '�׽�Ʈ ���� �Խñ�', 'admin', SYSDATE, DEFAULT, '�׽�Ʈ ���� �Խñ� �����Դϴ�.', null, null);

commit;

