create table user_table(
	user_id int primary key auto_increment,
	state int not null default '1',
	username varchar(100),
	password varchar(100),
	email varchar(200),
	phone varchar(50)
);

select * from user_table;

desc user_table;

delete from user_table where user_id=28;

insert into user_table(username, password) values('aaa', 'aaa');

UPDATE user_table set state='1' where user_id=29;

alter table user_table add column state  int not null default '1';

CREATE TABLE product_category(
	id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	parent_id int UNSIGNED NOT NULL DEFAULT 0
);

insert into product_category(name, parent_id) values
('口紅',5),
('眼影',5),
('粉底',5),
('防曬乳',5),
('眉筆',5),
('睫毛膏',5);


select * from product_category;

update product_category set parent_id=4 where id=44;

CREATE TABLE product(
	id int PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(200),
	category_id int,
	price int,
	number int,
	image varchar(100),
	state int NOT NULL DEFAULT 1
);

desc product;

insert into product(name, category_id, price, number, image, state) values
('Apple IphoneX', 2, 15780, 54, '/img/iphoneX.png', 1),
('Asus ZenFone', 2, 21354, 65, '/img/ZenFone.png', 1),
('Samsung Note8', 2, 6578, 21, '/img/Note8.png', 1),
('Sony Zperia', 2, 23457, 11, '/img/Zperia.png', 1),
('Google Pixel', 2, 10863, 47, '/img/Pixel.png', 1);

drop table product;

select * from product;

http://pngimg.com/

