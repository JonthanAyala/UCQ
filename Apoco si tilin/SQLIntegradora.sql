create database pelisplus;
use pelisplus;

create table users(
	id integer primary key AUTO_INCREMENT,
    name varchar(100) not null,
    lastname varchar(100) not null,
    surname varchar(100) not null,
    username varchar(100) not null,
    birthday date not null,
    status varchar(100)
);
insert into users values (0,'Jonathan', 'Ayala', 'Garcia', 'Jonthan13', sysdate(), 'Activo');
select * from users;
