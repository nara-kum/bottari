-- web_db 사용
use bottari_db;

-- 테이블 목록 조회
show tables;

-- 상품 조회
select *
from product
;

-- 캘린더 조회
select *
from Calender
;

-- cart 조회
select *
from cart
;

-- fundingOption 조회
select  funding_option_no,
		funding_no,
        option_no
from fundingOption
;

-- funding_product 조회
select *
from funding_product
;

-- users 조회
select  user_no, 
		id,
		name,
		password,
		email,
		phone,
		birth,
		now()
from users
;

-- 회원추가
insert into users 
values(null,'ahreum','아름','1000','abc@naver.com','01011112222',null,now())
;

-- wishlist 조회
select *
from wishlist
;

-- wishlistoption 조회
select *
from wishlistoption
;