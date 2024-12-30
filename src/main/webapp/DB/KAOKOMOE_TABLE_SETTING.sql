CREATE TABLE Actor (
	actor_id	number(10)		NOT NULL,
	face_code	number(1)		NOT NULL,
	actor_name	varchar2(50)		NOT NULL,
	actor_debut	varchar2(100)		NULL,
	actor_hit	varchar2(100)		NULL,
	actor_newest	varchar2(100)		NULL
);

COMMENT ON COLUMN Actor.actor_id IS '각 배우에게 부여된 고유 ID 값';

COMMENT ON COLUMN Actor.face_code IS '배우가 가진 얼굴상(소금, 간장, 마요네즈, 된장)의 고유 코드(1:소금,2:간장,3:마요네즈,4:된장)';

COMMENT ON COLUMN Actor.actor_name IS '배우 이름(띄어쓰기 주의)';

COMMENT ON COLUMN Actor.actor_debut IS '배우의 데뷔작';

COMMENT ON COLUMN Actor.actor_hit IS '배우의 히트작';

COMMENT ON COLUMN Actor.actor_newest IS '배우의 최신작';

CREATE TABLE Face (
	face_code	number(1)		NOT NULL,
	face_name	varchar(30)		NOT NULL
);

COMMENT ON COLUMN Face.face_code IS '배우가 가진 얼굴상(소금, 간장, 마요네즈, 된장)의 고유 코드(1:소금,2:간장,3:마요네즈,4:된장)';

COMMENT ON COLUMN Face.face_name IS '소금, 간장, 마요네즈, 된장';

CREATE TABLE Photo (
	actor_id	         number(10)		NOT NULL,
	actor_profile_photo	 varchar2(200)		NULL,
	actor_worldcup_photo varchar2(200)		NULL
);

COMMENT ON COLUMN Photo.actor_id IS '각 배우에게 부여된 고유 ID 값';

COMMENT ON COLUMN Photo.actor_profile_photo IS '배우의 프로필 사진(경로가 명시되어 있음)';

COMMENT ON COLUMN Photo.actor_worldcup_photo IS '배우의 이상형 월드컵 움짤(경로가 명시되어 있음)';

ALTER TABLE Actor ADD CONSTRAINT PK_ACTOR PRIMARY KEY (
	actor_id
);

ALTER TABLE Face ADD CONSTRAINT PK_FACE PRIMARY KEY (
	face_code
);

ALTER TABLE Photo ADD CONSTRAINT PK_PHOTO PRIMARY KEY (
	actor_id
);

ALTER TABLE Photo ADD CONSTRAINT FK_Actor_TO_Photo_1 FOREIGN KEY (
	actor_id
)
REFERENCES Actor (
	actor_id
);



