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

-- cart 등록
-- 장바구니번호, 회원번호, 상품번호, 카테고리번호, 등록일, 수량
insert into cart
values(3,9,9,1,now(),1)
;

-- fundingOption 조회
select  funding_option_no,
		funding_no,
        option_no
from fundingOption
;

-- funding_product 조회
select  funding_no,
		event_no,
        product_no,
        funding_option,
        funding_status,
        funding_date
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
values(null,'sujin','수진','0327','sujin@gmail.com','01077778888','0905',now())
;

-- wishlist 조회
select  wishlist_no,
		user_no,
        product_no,
        date,
        ea
from wishlist
;

-- 위시리스트 추가
insert into wishlist
values(2,2,3,now(),5)
;

-- wishlistoption 조회
select *
from wishlistoption
;