/* MEMBER(회원정보 기본사항테이블) */
CREATE TABLE MEMBER
(
    USER_ID       VARCHAR2(50),
    USER_PW       VARCHAR2(50)  NOT NULL,
    USER_NAME     VARCHAR2(30)  NOT NULL,
    USER_NICKNAME VARCHAR2(30)  NOT NULL,
    PHONE         VARCHAR2(30)  NOT NULL,
    BIRTH         DATE          NOT NULL,
    GENDER        CHAR(1)       NOT NULL,
    EMAIL         VARCHAR2(100) NOT NULL,
    ADMIN_CK      CHAR(1) DEFAULT 'N',

    CONSTRAINT PK_USER_ID PRIMARY KEY (USER_ID),
    CONSTRAINT UQ_USER_NN UNIQUE (USER_NICKNAME),
    CONSTRAINT UQ_PHONE UNIQUE (PHONE),
    CONSTRAINT CK_GENDER CHECK (GENDER IN ('M', 'F')),
    CONSTRAINT UQ_EMAIL UNIQUE (EMAIL),
    CONSTRAINT CK_ADMIN CHECK (ADMIN_CK IN ('Y', 'N'))
);


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


CREATE SEQUENCE SEQ_MEMBER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


/* LOG(로그테이블) */
CREATE TABLE LOG
(
    USER_ID    VARCHAR2(50),
    VISIT_IP   VARCHAR2(20) NOT NULL,
    VISIT_TIME DATE         NOT NULL,

    CONSTRAINT FK_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER
);

/* 코멘트 */
COMMENT ON TABLE LOG IS '로그테이블';

COMMENT ON COLUMN LOG.USER_ID IS '접속자수';
COMMENT ON COLUMN LOG.VISIT_IP IS '아이피주소';
COMMENT ON COLUMN LOG.VISIT_TIME IS '접속시간';


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


CREATE SEQUENCE SEQ_BANNER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


/* QNA(고객센터 1:1문의테이블) */
CREATE TABLE QNA
(
    QNA_NO         NUMBER,
    QNA_TITLE      VARCHAR2(200)  NOT NULL,
    USER_ID        VARCHAR2(50)   NOT NULL,
    QNA_POST_DATE  DATE           NOT NULL,
    QNA_VIEWS      NUMBER  DEFAULT 0,
    QNA_CONTENT    VARCHAR2(4000) NOT NULL,
    QNA_ORIGINFILE VARCHAR2(200),
    QNA_RENAMEFILE VARCHAR2(200),
    QNA_PRIVATE    CHAR(1) DEFAULT 'Y',

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
COMMENT ON COLUMN QNA.QNA_ORIGINFILE IS 'QNA답변원본파일';
COMMENT ON COLUMN QNA.QNA_RENAMEFILE IS 'QNA수정파일';
COMMENT ON COLUMN QNA.QNA_PRIVATE IS 'QNA공개여부';


CREATE SEQUENCE SEQ_QNA
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


/* ANSWER(고객센터 1대1문의답변테이블) */
CREATE TABLE ANSWER
(
    ANSWER_NO         NUMBER,
    ANSWER_REF        NUMBER              NOT NULL,
    ANSWER_TITLE      VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID           VARCHAR2(50 BYTE)   NOT NULL,
    ANSWER_POST_DATE  DATE                NOT NULL,
    ANSWER_VIEWS      NUMBER  DEFAULT 0,
    ANSWER_CONTENT    VARCHAR2(4000 BYTE) NOT NULL,
    ANSWER_ORIGINFILE VARCHAR2(200 BYTE),
    ANSWER_RENAMEFILE VARCHAR2(200 BYTE),
    ANSWER_PRIVATE    CHAR(1) DEFAULT 'Y',

    CONSTRAINT PK_ANSWER_NO PRIMARY KEY (ANSWER_NO),
    CONSTRAINT FK_ANSWER_REF FOREIGN KEY (ANSWER_REF) REFERENCES QNA (QNA_NO),
    CONSTRAINT FK_ANSWER_WRITER FOREIGN KEY (USER_ID) REFERENCES MEMBER,
    CONSTRAINT CK_ANSWER_PRIVATE CHECK (ANSWER_PRIVATE IN ('Y', 'N'))
);


/* 코멘트 */
COMMENT ON TABLE ANSWER IS '고객센터 1대1문의답변테이블';

COMMENT ON COLUMN ANSWER.ANSWER_NO IS 'QNA답변글번호';
COMMENT ON COLUMN ANSWER.ANSWER_REF IS 'QNA참조질문글번호';
COMMENT ON COLUMN ANSWER.ANSWER_TITLE IS 'QNA답변글제목';
COMMENT ON COLUMN ANSWER.USER_ID IS 'QNA답변글관리자';
COMMENT ON COLUMN ANSWER.ANSWER_POST_DATE IS 'QNA답변글작성일';
COMMENT ON COLUMN ANSWER.ANSWER_VIEWS IS 'QNA답변글조회수';
COMMENT ON COLUMN ANSWER.ANSWER_CONTENT IS 'QNA답변글내용';
COMMENT ON COLUMN ANSWER.ANSWER_ORIGINFILE IS 'QNA답변원본파일';
COMMENT ON COLUMN ANSWER.ANSWER_RENAMEFILE IS 'QNA수정파일';
COMMENT ON COLUMN ANSWER.ANSWER_PRIVATE IS 'QNA답변글공개여부';

CREATE SEQUENCE SEQ_ANSWER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


/* FAQ(고객센터 FAQ테이블) */
CREATE TABLE FAQ
(
    FAQ_NO         NUMBER,
    FAQ_TITLE      VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID        VARCHAR2(50 BYTE)   NOT NULL,
    FAQ_POST_DATE  DATE                NOT NULL,
    FAQ_VIEWS      NUMBER DEFAULT 0,
    FAQ_CONTENT    VARCHAR2(4000 BYTE) NOT NULL,
    FAQ_ORIGINFILE VARCHAR2(200 BYTE),
    FAQ_RENAMEFILE VARCHAR2(200 BYTE),

    CONSTRAINT PK_FAQ_NO PRIMARY KEY (FAQ_NO),
    CONSTRAINT FK_FAQ_WRITER FOREIGN KEY (USER_ID) REFERENCES MEMBER
);


COMMENT ON TABLE FAQ IS '고객센터 FAQ테이블';

COMMENT ON COLUMN FAQ.FAQ_NO IS 'FAQ번호';
COMMENT ON COLUMN FAQ.FAQ_TITLE IS 'FAQ제목';
COMMENT ON COLUMN FAQ.USER_ID IS 'FAQ관리자';
COMMENT ON COLUMN FAQ.FAQ_POST_DATE IS 'FAQ작성일';
COMMENT ON COLUMN FAQ.FAQ_VIEWS IS 'FAQ조회수';
COMMENT ON COLUMN FAQ.FAQ_CONTENT IS 'FAQ내용';
COMMENT ON COLUMN FAQ.FAQ_ORIGINFILE IS 'FAQ원본파일';
COMMENT ON COLUMN FAQ.FAQ_RENAMEFILE IS 'FAQ수정파일';


CREATE SEQUENCE SEQ_FAQ
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


/* NOTICE(공지사항 테이블) */
CREATE TABLE NOTICE
(
    NOTICE_NO         NUMBER,
    NOTICE_TITLE      VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID           VARCHAR2(50 BYTE)   NOT NULL,
    WRITE_NOTICE_DATE DATE                NOT NULL,
    NOTICE_VIEWS      NUMBER,
    NOTICE_CONTENT    VARCHAR2(4000 BYTE) NOT NULL,
    NOTICE_ORIGINFILE VARCHAR2(200 BYTE),
    NOTICE_RENAMEFILE VARCHAR2(200 BYTE),
    NOTICE_INITLINK   VARCHAR2(200 BYTE),

    CONSTRAINT PK_NOTICE_NO PRIMARY KEY (NOTICE_NO),
    CONSTRAINT FK_NOTICE_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER
);

COMMENT ON TABLE NOTICE IS '공지사항 테이블';
COMMENT ON COLUMN NOTICE.NOTICE_NO IS '공지사항글번호';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '공지사항제목';
COMMENT ON COLUMN NOTICE.USER_ID IS '공지사항작성자';
COMMENT ON COLUMN NOTICE.WRITE_NOTICE_DATE IS '공지사항작성일';
COMMENT ON COLUMN NOTICE.NOTICE_VIEWS IS '공지사항조회수';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '공지사항글내용';
COMMENT ON COLUMN NOTICE.NOTICE_ORIGINFILE IS '공지사항원본파일';
COMMENT ON COLUMN NOTICE.NOTICE_RENAMEFILE IS '공지사항수정파일';
COMMENT ON COLUMN NOTICE.NOTICE_INITLINK IS '공지사항링크';



CREATE SEQUENCE SEQ_NOTICE
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


/* EVENT(이벤트 테이블) */
CREATE TABLE EVENT
(
    EVENT_NO         NUMBER              NOT NULL,
    EVENT_TITLE      VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID          VARCHAR2(50 BYTE)   NOT NULL,
    WRITE_EVENT_DATE DATE                NOT NULL,
    EVENT_VIEWS      NUMBER,
    EVENT_CONTENT    VARCHAR2(4000 BYTE) NOT NULL,
    EVENT_ORIGINFILE VARCHAR2(200 BYTE),
    EVENT_RENAMEFILE VARCHAR2(200 BYTE),
    EVENT_INITLINK   VARCHAR2(200 BYTE),

    CONSTRAINT PK_EVENT_NO PRIMARY KEY (EVENT_NO),
    CONSTRAINT FK_EVENT_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER
);

COMMENT ON TABLE EVENT IS '이벤트 테이블';
COMMENT ON COLUMN EVENT.EVENT_NO IS '이벤트글번호';
COMMENT ON COLUMN EVENT.EVENT_TITLE IS '이벤트제목';
COMMENT ON COLUMN EVENT.USER_ID IS '이벤트작성자';
COMMENT ON COLUMN EVENT.WRITE_EVENT_DATE IS '이벤트작성일';
COMMENT ON COLUMN EVENT.EVENT_VIEWS IS '이벤트조회수';
COMMENT ON COLUMN EVENT.EVENT_CONTENT IS '이벤트글내용';
COMMENT ON COLUMN EVENT.EVENT_ORIGINFILE IS '이벤트원본파일';
COMMENT ON COLUMN EVENT.EVENT_RENAMEFILE IS '이벤트수정파일';
COMMENT ON COLUMN EVENT.EVENT_INITLINK IS '이벤트링크';



CREATE SEQUENCE SEQ_EVENT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


/* KAKAO(소셜로그인 카카오) */
CREATE TABLE KAKAO
(
    KAKAO_ID     VARCHAR2(100) NOT NULL,
    KAKAO_SECRET VARCHAR2(50)  NOT NULL,
    KAKAO_SCOPE  VARCHAR2(50)  NOT NULL,
    KAKAO_NAME   VARCHAR2(30)  NOT NULL,
    KAKAO_BIRTH  DATE          NOT NULL,
    EMAIL        VARCHAR2(100) NOT NULL,

    CONSTRAINT PK_KAKAO_ID PRIMARY KEY (KAKAO_ID),
    CONSTRAINT FK_KAKAO_EMAIL FOREIGN KEY (EMAIL) REFERENCES MEMBER
);

COMMENT ON TABLE KAKAO IS '소셜로그인 카카오';
COMMENT ON COLUMN KAKAO.KAKAO_ID IS '카카오회원아이디';
COMMENT ON COLUMN KAKAO.KAKAO_SECRET IS '카카오회원시크릿코드';
COMMENT ON COLUMN KAKAO.KAKAO_SCOPE IS '카카오회원스코프';
COMMENT ON COLUMN KAKAO.KAKAO_NAME IS '카카오회원이름';
COMMENT ON COLUMN KAKAO.KAKAO_BIRTH IS '카카오회원생일';
COMMENT ON COLUMN KAKAO.EMAIL IS '회원이메일';


/* NAVER(소셜로그인 네이버) */
CREATE TABLE NAVER
(
    NAVER_ID     VARCHAR2(100) NOT NULL,
    NAVER_SECRET VARCHAR2(50)  NOT NULL,
    NAVER_SCOPE  VARCHAR2(50)  NOT NULL,
    NAVER_NAME   VARCHAR2(30)  NOT NULL,
    NAVER_BIRTH  DATE          NOT NULL,
    EMAIL        VARCHAR2(100) NOT NULL,

    CONSTRAINT PK_NAVER_ID PRIMARY KEY (NAVER_ID),
    CONSTRAINT FK_NAVER_ID_EMAIL FOREIGN KEY (EMAIL) REFERENCES MEMBER
);

COMMENT ON TABLE NAVER IS '소셜로그인 네이버';
COMMENT ON COLUMN NAVER.NAVER_ID IS '네이버회원아이디';
COMMENT ON COLUMN NAVER.NAVER_SECRET IS '네이버회원시크릿코드';
COMMENT ON COLUMN NAVER.NAVER_SCOPE IS '네이버회원스코프';
COMMENT ON COLUMN NAVER.NAVER_NAME IS '네이버회원이름';
COMMENT ON COLUMN NAVER.NAVER_BIRTH IS '네이버회원생일';
COMMENT ON COLUMN NAVER.EMAIL IS '회원이메일';


/* GOOGLE(소셜로그인 구글)) */
CREATE TABLE GOOGLE
(
    GOOGLE_ID     VARCHAR2(100) NOT NULL,
    GOOGLE_SECRET VARCHAR2(50)  NOT NULL,
    GOOGLE_SCOPE  VARCHAR2(50)  NOT NULL,
    GOOGLE_NAME   VARCHAR2(30)  NOT NULL,
    GOOGLE_BIRTH  DATE          NOT NULL,
    EMAIL         VARCHAR2(100) NOT NULL,

    CONSTRAINT PK_GOOGLE_ID PRIMARY KEY (GOOGLE_ID),
    CONSTRAINT FK_GOOGLE_ID_EMAIL FOREIGN KEY (EMAIL) REFERENCES MEMBER
);

COMMENT ON TABLE GOOGLE IS '소셜로그인 구글';
COMMENT ON COLUMN GOOGLE.GOOGLE_ID IS '구글회원아이디';
COMMENT ON COLUMN GOOGLE.GOOGLE_SECRET IS '구글회원시크릿코드';
COMMENT ON COLUMN GOOGLE.GOOGLE_SCOPE IS '구글회원스코프';
COMMENT ON COLUMN GOOGLE.GOOGLE_NAME IS '구글회원이름';
COMMENT ON COLUMN GOOGLE.GOOGLE_BIRTH IS '구글회원생일';
COMMENT ON COLUMN GOOGLE.EMAIL IS '회원이메일';


/* BOARD(관리자게시글테이블) */
CREATE TABLE BOARD
(
    BOARD_NO        NUMBER             NOT NULL,
    BOARD_TITLE     VARCHAR2(200 BYTE) NOT NULL,
    USER_ID         VARCHAR2(50 BYTE)  NOT NULL,
    BOARD_POST_DATE DATE               NOT NULL,
    BOARD_VIEWS     NUMBER,
    BOARD_ITEM      CHAR(1)            NOT NULL,

    CONSTRAINT PK_BOARD_NO PRIMARY KEY (BOARD_NO),
    CONSTRAINT FK_BOARD_WRITER FOREIGN KEY (USER_ID) REFERENCES MEMBER,
    CONSTRAINT CK_BOARD_ITEM CHECK (BOARD_ITEM IN ('T', 'F', 'B', 'E'))
);

COMMENT ON TABLE BOARD IS '관리자게시글테이블';
COMMENT ON COLUMN BOARD.BOARD_NO IS '관리자게시글번호';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '관리자게시글제목';
COMMENT ON COLUMN BOARD.USER_ID IS '관리자게시물작성자';
COMMENT ON COLUMN BOARD.BOARD_POST_DATE IS '관리자게시물등록일';
COMMENT ON COLUMN BOARD.BOARD_VIEWS IS '관리자게시물조회수';
COMMENT ON COLUMN BOARD.BOARD_ITEM IS '관리자게시물항목';


CREATE SEQUENCE SEQ_BOARD
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;



CREATE TABLE FREE
(
    FREE_NO          NUMBER              NOT NULL,
    FREE_NAME        VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID          VARCHAR2(50 BYTE)   NOT NULL,
    FREE_WRITE_DATE  DATE                NOT NULL,
    FREE_CLICK_COUNT NUMBER,
    FREE_VALUE       VARCHAR2(4000 BYTE) NOT NULL,
    FREE_ORIGINFILE  VARCHAR2(200 BYTE),
    FREE_RENAMEFILE  VARCHAR2(200 BYTE),
    FREE_INITLINK    VARCHAR2(200 BYTE),
    FREE_REF         NUMBER,
    FREE_REPLY_REF   NUMBER,
    FREE_REPLY_LEV   NUMBER,
    FREE_REPLY_SEQ   NUMBER,

    CONSTRAINT PK_FREE_NO PRIMARY KEY (FREE_NO),
    CONSTRAINT FK_FREE_USER_ID FOREIGN KEY (USER_ID)
        REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_BFREE
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

CREATE TABLE FREE_LIKE
(
    USER_ID VARCHAR2(30) NOT NULL,
    FREE_NO NUMBER       NOT NULL,
    CONSTRAINT FK_LF_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER,
    CONSTRAINT FK_LF_FREE_NO FOREIGN KEY (FREE_NO) REFERENCES FREE,
    CONSTRAINT PK_FREE_LIKE PRIMARY KEY (USER_ID, FREE_NO)
);



CREATE TABLE TIP
(
    TIP_NO          NUMBER              NOT NULL,
    TIP_NAME        VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID         VARCHAR2(50 BYTE)   NOT NULL,
    TIP_WRITE_DATE  DATE                NOT NULL,
    TIP_CLICK_COUNT NUMBER,
    TIP_VALUE       VARCHAR2(4000 BYTE) NOT NULL,
    TIP_ORIGINFILE  VARCHAR2(200 BYTE),
    TIP_RENAMEFILE  VARCHAR2(200 BYTE),
    TIP_INITLINK    VARCHAR2(200 BYTE),
    TIP_REF         NUMBER,
    TIP_REPLY_REF   NUMBER,
    TIP_REPLY_LEV   NUMBER,
    TIP_REPLY_SEQ   NUMBER,

    CONSTRAINT PK_TIP_NO PRIMARY KEY (TIP_NO),
    CONSTRAINT FK_TIP_USER_ID FOREIGN KEY (USER_ID)
        REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_BTIP
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


CREATE TABLE TIP_LIKE
(
    USER_ID VARCHAR2(30) NOT NULL,
    TIP_NO  NUMBER       NOT NULL,
    CONSTRAINT FK_LT_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER,
    CONSTRAINT FK_LT_TIP_NO FOREIGN KEY (TIP_NO) REFERENCES TIP,

    CONSTRAINT PK_TIP_LIKE PRIMARY KEY (USER_ID, TIP_NO)
);



CREATE TABLE EYEBODY
(
    EYEBODY_NO          NUMBER              NOT NULL,
    EYEBODY_NAME        VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID             VARCHAR2(50 BYTE)   NOT NULL,
    EYEBODY_WRITE_DATE  DATE                NOT NULL,
    EYEBODY_CLICK_COUNT NUMBER,
    EYEBODY_VALUE       VARCHAR2(4000 BYTE) NOT NULL,
    EYEBODY_ORIGINFILE  VARCHAR2(200 BYTE),
    EYEBODY_RENAMEFILE  VARCHAR2(200 BYTE),
    EYEBODY_INITLINK    VARCHAR2(200 BYTE),
    EYEBODY_REF         NUMBER,
    EYEBODY_REPLY_REF   NUMBER,
    EYEBODY_REPLY_LEV   NUMBER,
    EYEBODY_REPLY_SEQ   NUMBER,

    CONSTRAINT PK_EYEBODY_NO PRIMARY KEY (EYEBODY_NO),
    CONSTRAINT FK_EYEBODY_USER_ID FOREIGN KEY (USER_ID)
        REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_BEYEBODY
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


CREATE TABLE EYEBODY_LIKE
(
    USER_ID    VARCHAR2(30) NOT NULL,
    EYEBODY_NO NUMBER       NOT NULL,

    CONSTRAINT FK_LE_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER,
    CONSTRAINT FK_LE_EYEBODY_NO FOREIGN KEY (EYEBODY_NO) REFERENCES EYEBODY,

    CONSTRAINT PK_EYEBODY_LIKE PRIMARY KEY (USER_ID, EYEBODY_NO)
);



CREATE TABLE BFAF
(
    BFAF_NO          NUMBER              NOT NULL,
    BFAF_NAME        VARCHAR2(200 BYTE)  NOT NULL,
    USER_ID          VARCHAR2(50 BYTE)   NOT NULL,
    BFAF_WRITE_DATE  DATE                NOT NULL,
    BFAF_CLICK_COUNT NUMBER,
    BFAF_VALUE       VARCHAR2(4000 BYTE) NOT NULL,
    BFAF_ORIGINFILE  VARCHAR2(200 BYTE),
    BFAF_RENAMEFILE  VARCHAR2(200 BYTE),
    BFAF_INITLINK    VARCHAR2(200 BYTE),
    BFAF_REF         NUMBER,
    BFAF_REPLY_REF   NUMBER,
    BFAF_REPLY_LEV   NUMBER,
    BFAF_REPLY_SEQ   NUMBER,

    CONSTRAINT PK_BFAF_NO PRIMARY KEY (BFAF_NO),
    CONSTRAINT FK_BFAF_USER_ID FOREIGN KEY (USER_ID)
        REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_BBFAF
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;


CREATE TABLE BFAF_LIKE
(
    USER_ID VARCHAR2(30) NOT NULL,
    BFAF_NO NUMBER       NOT NULL,

    CONSTRAINT FK_LB_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER,
    CONSTRAINT FK_LB_BFAF_NO FOREIGN KEY (BFAF_NO) REFERENCES BFAF,

    CONSTRAINT PK_BFAF_LIKE PRIMARY KEY (USER_ID, BFAF_NO)
);


COMMENT ON TABLE FREE IS '자유게시판 테이블';
COMMENT ON COLUMN FREE.FREE_NO IS '글번호';
COMMENT ON COLUMN FREE.FREE_NAME IS '제목';
COMMENT ON COLUMN FREE.USER_ID IS '작성자';
COMMENT ON COLUMN FREE.FREE_WRITE_DATE IS '작성일';
COMMENT ON COLUMN FREE.FREE_CLICK_COUNT IS '조회수';
COMMENT ON COLUMN FREE.FREE_VALUE IS '글내용';
COMMENT ON COLUMN FREE.FREE_ORIGINFILE IS '파일원본이름';
COMMENT ON COLUMN FREE.FREE_RENAMEFILE IS '파일수정이름';
COMMENT ON COLUMN FREE.FREE_INITLINK IS '링크';
COMMENT ON COLUMN FREE.FREE_REF IS '원글 번호';
COMMENT ON COLUMN FREE.FREE_REPLY_REF IS '댓글 번호';
COMMENT ON COLUMN FREE.FREE_REPLY_LEV IS '댓글 단계';
COMMENT ON COLUMN FREE.FREE_REPLY_SEQ IS '댓글 순번';

COMMENT ON TABLE FREE_LIKE IS '자유게시판 좋아요 체크 테이블';
COMMENT ON COLUMN FREE_LIKE.USER_ID IS '글번호';
COMMENT ON COLUMN FREE_LIKE.FREE_NO IS '제목';

COMMENT ON TABLE TIP IS '팁게시판 테이블';
COMMENT ON COLUMN TIP.TIP_NO IS '글번호';
COMMENT ON COLUMN TIP.TIP_NAME IS '제목';
COMMENT ON COLUMN TIP.USER_ID IS '작성자';
COMMENT ON COLUMN TIP.TIP_WRITE_DATE IS '작성일';
COMMENT ON COLUMN TIP.TIP_CLICK_COUNT IS '조회수';
COMMENT ON COLUMN TIP.TIP_VALUE IS '글내용';
COMMENT ON COLUMN TIP.TIP_ORIGINFILE IS '파일원본이름';
COMMENT ON COLUMN TIP.TIP_RENAMEFILE IS '파일수정이름';
COMMENT ON COLUMN TIP.TIP_INITLINK IS '링크';
COMMENT ON COLUMN TIP.TIP_REF IS '원글 번호';
COMMENT ON COLUMN TIP.TIP_REPLY_REF IS '댓글 번호';
COMMENT ON COLUMN TIP.TIP_REPLY_LEV IS '댓글 단계';
COMMENT ON COLUMN TIP.TIP_REPLY_SEQ IS '댓글 순번';

COMMENT ON TABLE TIP_LIKE IS '팁게시판 좋아요 체크 테이블';
COMMENT ON COLUMN TIP_LIKE.USER_ID IS '글번호';
COMMENT ON COLUMN TIP_LIKE.TIP_NO IS '제목';

COMMENT ON TABLE EYEBODY IS '눈바디게시판 테이블';
COMMENT ON COLUMN EYEBODY.EYEBODY_NO IS '글번호';
COMMENT ON COLUMN EYEBODY.EYEBODY_NAME IS '제목';
COMMENT ON COLUMN EYEBODY.USER_ID IS '작성자';
COMMENT ON COLUMN EYEBODY.EYEBODY_WRITE_DATE IS '작성일';
COMMENT ON COLUMN EYEBODY.EYEBODY_CLICK_COUNT IS '조회수';
COMMENT ON COLUMN EYEBODY.EYEBODY_VALUE IS '글내용';
COMMENT ON COLUMN EYEBODY.EYEBODY_ORIGINFILE IS '파일원본이름';
COMMENT ON COLUMN EYEBODY.EYEBODY_RENAMEFILE IS '파일수정이름';
COMMENT ON COLUMN EYEBODY.EYEBODY_INITLINK IS '링크';
COMMENT ON COLUMN EYEBODY.EYEBODY_REF IS '원글 번호';
COMMENT ON COLUMN EYEBODY.EYEBODY_REPLY_REF IS '댓글 번호';
COMMENT ON COLUMN EYEBODY.EYEBODY_REPLY_LEV IS '댓글 단계';
COMMENT ON COLUMN EYEBODY.EYEBODY_REPLY_SEQ IS '댓글 순번';

COMMENT ON TABLE EYEBODY_LIKE IS '눈바디게시판 좋아요 체크 테이블';
COMMENT ON COLUMN EYEBODY_LIKE.USER_ID IS '글번호';
COMMENT ON COLUMN EYEBODY_LIKE.EYEBODY_NO IS '제목';

COMMENT ON TABLE BFAF IS 'before/after 게시판 테이블';
COMMENT ON COLUMN BFAF.BFAF_NO IS '글번호';
COMMENT ON COLUMN BFAF.BFAF_NAME IS '제목';
COMMENT ON COLUMN BFAF.USER_ID IS '작성자';
COMMENT ON COLUMN BFAF.BFAF_WRITE_DATE IS '작성일';
COMMENT ON COLUMN BFAF.BFAF_CLICK_COUNT IS '조회수';
COMMENT ON COLUMN BFAF.BFAF_VALUE IS '글내용';
COMMENT ON COLUMN BFAF.BFAF_ORIGINFILE IS '파일원본이름';
COMMENT ON COLUMN BFAF.BFAF_RENAMEFILE IS '파일수정이름';
COMMENT ON COLUMN BFAF.BFAF_INITLINK IS '링크';
COMMENT ON COLUMN BFAF.BFAF_REF IS '원글 번호';
COMMENT ON COLUMN BFAF.BFAF_REPLY_REF IS '댓글 번호';
COMMENT ON COLUMN BFAF.BFAF_REPLY_LEV IS '댓글 단계';
COMMENT ON COLUMN BFAF.BFAF_REPLY_SEQ IS '댓글 순번';

COMMENT ON TABLE BFAF_LIKE IS 'before/after 게시판 좋아요 체크 테이블';
COMMENT ON COLUMN BFAF_LIKE.USER_ID IS '글번호';
COMMENT ON COLUMN BFAF_LIKE.BFAF_NO IS '제목';

/*다이어리목록 테이블*/
CREATE TABLE DIARY
(
    USER_ID         VARCHAR2(50 BYTE)    NOT NULL,
    DIARY_POST_DATE DATE DEFAULT SYSDATE NOT NULL,
    DIARY_NO        VARCHAR2(10 BYTE)    NOT NULL,
    DIARY_CATEGORY  VARCHAR2(10 BYTE)    NOT NULL,
    DIARY_MEMO      VARCHAR2(180 BYTE),
    DIARY_IMAGE     VARCHAR2(180 BYTE),

    CONSTRAINT PK_DIARY_NO PRIMARY KEY (DIARY_NO),
    CONSTRAINT CK_CATEGORY CHECK (DIARY_CATEGORY IN ('eat', 'act', 'body')),
    CONSTRAINT FK_DIARY_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER ON DELETE CASCADE

);

COMMENT ON TABLE DIARY IS '다이어리 목록';
COMMENT ON COLUMN DIARY.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN DIARY.DIARY_POST_DATE IS '작성일시';
COMMENT ON COLUMN DIARY.DIARY_NO IS '다이어리번호';
COMMENT ON COLUMN DIARY.DIARY_CATEGORY IS '카테고리';
COMMENT ON COLUMN DIARY.DIARY_MEMO IS '메모';
COMMENT ON COLUMN DIARY.DIARY_IMAGE IS '이미지파일명';


/*음식 100G당 성분함량표 테이블*/
CREATE TABLE FOOD
(
    FOOD_CODE         VARCHAR2(10 BYTE)       NOT NULL,
    FOOD_NAME         VARCHAR2(300 BYTE)      NOT NULL,
    FOOD_KCAL         NUMBER(10, 5) DEFAULT 0 NOT NULL,
    FOOD_CARBOHYDRATE NUMBER(10, 5) DEFAULT 0 NOT NULL,
    FOOD_PROTEIN      NUMBER(10, 5) DEFAULT 0 NOT NULL,
    FOOD_FAT          NUMBER(10, 5) DEFAULT 0 NOT NULL,
    FOOD_CHOLESTEROL  NUMBER(10, 5) DEFAULT 0 NOT NULL,
    FOOD_ROUGHAGE     NUMBER(10, 5) DEFAULT 0 NOT NULL,
    FOOD_VITAMIN      NUMBER(10, 5) DEFAULT 0 NOT NULL,

    CONSTRAINT PK_FOOD_CODE PRIMARY KEY (FOOD_CODE),
    CONSTRAINT UN_FOOD_NAME UNIQUE (FOOD_NAME)
);

COMMENT ON TABLE FOOD IS '음식 성분함량표';
COMMENT ON COLUMN FOOD.FOOD_CODE IS '음식코드';
COMMENT ON COLUMN FOOD.FOOD_NAME IS '음식이름';
COMMENT ON COLUMN FOOD.FOOD_KCAL IS '열량(kcal)';
COMMENT ON COLUMN FOOD.FOOD_CARBOHYDRATE IS '탄수화물 (g)';
COMMENT ON COLUMN FOOD.FOOD_PROTEIN IS '단백질 (g)';
COMMENT ON COLUMN FOOD.FOOD_FAT IS '지방 (g)';
COMMENT ON COLUMN FOOD.FOOD_CHOLESTEROL IS ' 콜레스테롤 (g)';
COMMENT ON COLUMN FOOD.FOOD_ROUGHAGE IS '식이섬유 (g)';
COMMENT ON COLUMN FOOD.FOOD_VITAMIN IS '비타민C (g)';


/*운동 분당 MET계수표 테이블*/
CREATE TABLE MOVE
(
    MOVE_CODE      VARCHAR2(10 BYTE)  NOT NULL,
    MOVE_NAME      VARCHAR2(200 BYTE) NOT NULL,
    MOVE_MET       NUMBER(3, 1)       NOT NULL,
    MOVE_INTENSITY VARCHAR2(10)       NOT NULL,

    CONSTRAINT PK_MOVE_CODE PRIMARY KEY (MOVE_CODE),
    CONSTRAINT UN_MOVE_NAME UNIQUE (MOVE_NAME)
);

COMMENT ON TABLE MOVE IS '운동MET계수표';
COMMENT ON COLUMN MOVE.MOVE_CODE IS '운동코드';
COMMENT ON COLUMN MOVE.MOVE_NAME IS '운동이름';
COMMENT ON COLUMN MOVE.MOVE_MET IS 'MET';
COMMENT ON COLUMN MOVE.MOVE_INTENSITY IS '운동강도';


/*식단 작성정보(누적) 테이블*/
CREATE TABLE EAT
(
    DIARY_NO         VARCHAR2(10 BYTE),
    EAT_SEQ          VARCHAR2(10 BYTE),
    FOOD_CODE        VARCHAR2(10 BYTE)      NOT NULL,
    EAT_G            NUMBER(5, 0) DEFAULT 0 NOT NULL,
    EAT_KCAL         NUMBER(5, 0) DEFAULT 0 NOT NULL,
    EAT_CARBOHYDRATE NUMBER(3, 1) DEFAULT 0 NOT NULL,
    EAT_PROTEIN      NUMBER(3, 1) DEFAULT 0 NOT NULL,
    EAT_FAT          NUMBER(3, 1) DEFAULT 0 NOT NULL,

    CONSTRAINT PK_EAT_SEQ PRIMARY KEY (DIARY_NO, EAT_SEQ),
    CONSTRAINT FK_EAT_DIARY_NO FOREIGN KEY (DIARY_NO) REFERENCES DIARY ON DELETE CASCADE,
    CONSTRAINT FK_FOOD_CODE FOREIGN KEY (FOOD_CODE) REFERENCES FOOD ON DELETE CASCADE

);

COMMENT ON TABLE EAT IS '식단정보';
COMMENT ON COLUMN EAT.DIARY_NO IS '다이어리번호';
COMMENT ON COLUMN EAT.EAT_SEQ IS '식단다이어리 순번';
COMMENT ON COLUMN EAT.FOOD_CODE IS '음식코드';
COMMENT ON COLUMN EAT.EAT_G IS '섭취한 양(g)';
COMMENT ON COLUMN EAT.EAT_KCAL IS '섭취칼로리량(kcal)';
COMMENT ON COLUMN EAT.EAT_CARBOHYDRATE IS '섭취한 탄수화물(g)';
COMMENT ON COLUMN EAT.EAT_PROTEIN IS '섭취한 단백질(g)';
COMMENT ON COLUMN EAT.EAT_FAT IS '섭취한지방(g)';


/*운동 작성정보(누적) 테이블*/
CREATE TABLE ACT
(
    DIARY_NO  VARCHAR2(10 BYTE)      NOT NULL,
    ACT_SEQ   VARCHAR2(10 BYTE)      NOT NULL,
    MOVE_CODE VARCHAR2(10 BYTE)      NOT NULL,
    ACT_MM    NUMBER(3, 0) DEFAULT 0 NOT NULL,
    ACT_KCAL  NUMBER(5, 0) DEFAULT 0 NOT NULL,

    CONSTRAINT PK_ACT_SEQ PRIMARY KEY (DIARY_NO, ACT_SEQ),
    CONSTRAINT FK_ACT_DIARY_NO FOREIGN KEY (DIARY_NO) REFERENCES DIARY ON DELETE CASCADE,
    CONSTRAINT FK_MOVE_CODE FOREIGN KEY (MOVE_CODE) REFERENCES MOVE ON DELETE CASCADE
);

COMMENT ON TABLE ACT IS '운동정보';
COMMENT ON COLUMN ACT.DIARY_NO IS '다이어리번호';
COMMENT ON COLUMN ACT.ACT_SEQ IS '운동다이어리 순번';
COMMENT ON COLUMN ACT.MOVE_CODE IS '운동코드';
COMMENT ON COLUMN ACT.ACT_MM IS '운동한 시간(m)';
COMMENT ON COLUMN ACT.ACT_KCAL IS '소모칼로리량(kcal)';


/*체형 작성정보(누적) 테이블*/
CREATE TABLE BODY
(
    DIARY_NO              VARCHAR2(10 BYTE)      NOT NULL,
    BODY_POST_DATE        DATE         DEFAULT SYSDATE,
    BODY_SEQ              VARCHAR2(10 BYTE),
    BODY_WEIGHT           NUMBER(5, 2) DEFAULT 0 NOT NULL,
    BODY_WEIGHT_RATING    VARCHAR2(10 BYTE),
    BODY_FAT              NUMBER(5, 2) DEFAULT 0 NOT NULL,
    BODY_FAT_RATING       VARCHAR2(10 BYTE),
    BODY_MUSCLE           NUMBER(5, 2) DEFAULT 0 NOT NULL,
    BODY_MUSCLE_RATING    VARCHAR2(10 BYTE),
    BODY_WAISTLINE        NUMBER(5, 2) DEFAULT 0 NOT NULL,
    BODY_WAISTLINE_RATING VARCHAR2(10 BYTE),
    BODY_BMI              NUMBER(5, 2) DEFAULT 0 NOT NULL,
    BODY_BMI_RATING       VARCHAR2(10 BYTE),
    BODY_BMR              NUMBER(5, 2) DEFAULT 0 NOT NULL,

    CONSTRAINT PK_BPOST_DATE PRIMARY KEY (BODY_POST_DATE),
    CONSTRAINT FK_BODY_DIARY_NO FOREIGN KEY (DIARY_NO) REFERENCES DIARY ON DELETE CASCADE,
    CONSTRAINT UN_BODY_DIARY_NO UNIQUE (DIARY_NO)
);

COMMENT ON TABLE BODY IS '체형 정보';
COMMENT ON COLUMN BODY.DIARY_NO IS '다이어리번호';
COMMENT ON COLUMN BODY.BODY_WEIGHT IS '체중(kg)';
COMMENT ON COLUMN BODY.BODY_WEIGHT_RATING IS '체중 평가';
COMMENT ON COLUMN BODY.BODY_FAT IS '체지방량(g)';
COMMENT ON COLUMN BODY.BODY_FAT_RATING IS '체지방 평가';
COMMENT ON COLUMN BODY.BODY_MUSCLE IS '골격근량(g)';
COMMENT ON COLUMN BODY.BODY_MUSCLE_RATING IS '골격근량 평가';
COMMENT ON COLUMN BODY.BODY_WAISTLINE IS '허리둘레(cm)';
COMMENT ON COLUMN BODY.BODY_WAISTLINE_RATING IS '허리둘레 평가';
COMMENT ON COLUMN BODY.BODY_BMI IS '계산된 BMI';
COMMENT ON COLUMN BODY.BODY_BMI_RATING IS 'BMI 평가';
COMMENT ON COLUMN BODY.BODY_BMR IS '계산된 BMR(kcal)';


/*회원 목표관리 테이블*/
CREATE TABLE GOAL
(
    USER_ID         VARCHAR2(50 BYTE) NOT NULL,
    CREATE_DATE     DATE,
    GOAL_DATE       DATE         DEFAULT SYSDATE,
    ENERGY_DEMAND   NUMBER(2, 0) DEFAULT 30,
    HEIGHT          NUMBER(5, 2),
    CURRENT_WEIGHT  NUMBER(5, 2),
    STANDARD_WEIGHT NUMBER(5, 2),
    TARGET_WEIGHT   NUMBER(5, 2),

    CONSTRAINT PK_GOAL_USER_DATE PRIMARY KEY (USER_ID, CREATE_DATE),
    CONSTRAINT FK_GOAL_USER_ID FOREIGN KEY (USER_ID) REFERENCES MEMBER ON DELETE CASCADE,
    CONSTRAINT CK_ENERGY_DEMAND CHECK (ENERGY_DEMAND IN (20, 25, 30, 35, 40))

);

COMMENT ON TABLE GOAL IS '목표관리 정보';
COMMENT ON COLUMN GOAL.USER_ID IS '작성자 아이디';
COMMENT ON COLUMN GOAL.CREATE_DATE IS '등록날짜(매일)';
COMMENT ON COLUMN GOAL.GOAL_DATE IS '목표 종료일';
COMMENT ON COLUMN GOAL.ENERGY_DEMAND IS '에너지 요구량';
COMMENT ON COLUMN GOAL.HEIGHT IS '키(cm)';
COMMENT ON COLUMN GOAL.CURRENT_WEIGHT IS '현재 체중(kg)';
COMMENT ON COLUMN GOAL.STANDARD_WEIGHT IS '표준 체중(kg)';
COMMENT ON COLUMN GOAL.TARGET_WEIGHT IS '목표체중(kg)';


/*운동보기: 강도별 랜덤추천 목록 테이블*/
CREATE TABLE REC_ACT
(
    REC_ACT_CODE  NUMBER(1, 0),
    REC_ACT_TITLE VARCHAR2(100 BYTE),
    REC_ACT_IMAGE VARCHAR2(180 BYTE),
    REC_ACT_LINK  VARCHAR2(180 BYTE),

    CONSTRAINT PK_REC_ACT PRIMARY KEY (REC_ACT_CODE)
);

COMMENT ON TABLE REC_ACT IS '운동추천정보';
COMMENT ON COLUMN REC_ACT.REC_ACT_CODE IS '코멘트 코드';
COMMENT ON COLUMN REC_ACT.REC_ACT_TITLE IS '코멘트 글';
COMMENT ON COLUMN REC_ACT.REC_ACT_IMAGE IS '이미지파일명';
COMMENT ON COLUMN REC_ACT.REC_ACT_LINK IS '백과사전 링크';


/*시퀀스 생성*/
CREATE SEQUENCE SEQ_DIARY_NO
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 99999999999
    NOCACHE
    NOORDER NOCYCLE;