DROP DATABASE if exists peifeili_cinemate;

CREATE DATABASE peifeili_cinemate;

USE peifeili_cinemate;

CREATE TABLE Users (
  username varchar(50) primary key not null,
  pswd varchar(50) not null,
  fname varchar(50) not null,
  lname varchar(50) not null,
  image varchar(1000) not null
);
  
create table Following (
  followingID int(11) primary key not null auto_increment,
  username varchar(50) not null,
  following varchar(50) not null,
  FOREIGN KEY fk1(username) REFERENCES Users(username)
);
 
create table Feed (
  eventID int(11) primary key not null auto_increment,
  username varchar(50) not null, -- replace username with userID as foreign key
  userAction varchar(50) not null,
  movie varchar(50) not null,
  imdbID varchar(50) not null,
  rating float(10) not null,
  feedTime varchar(50) not null,
  FOREIGN KEY fk(username) REFERENCES Users(username)
);



 