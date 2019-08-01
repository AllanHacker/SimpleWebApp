create table user_table(
	user_id int primary key auto_increment,
	username varchar(100),
	password varchar(100),
	email varchar(200),
	phone varchar(50)
);

select * from user_table;

desc user_table;

delete from user_table where user_id=28;

insert into user_table(username, password) values('aaa', 'aaa');

UPDATE user_table set password='a', email='a', phone='0' where user_id=30;
