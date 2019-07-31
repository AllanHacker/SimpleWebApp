create table user_table(
	user_id int primary key auto_increment,
	username varchar(100),
	password varchar(100),
	email varchar(200),
	phone varchar(50)
);

select * from user_table;

desc user_table;
