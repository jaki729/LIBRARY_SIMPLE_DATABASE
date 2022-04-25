create schema person

create table [person].[author]
(
	ID integer,
	Name varchar(100) constraint "Author_Name_CHK_NL"  not null,
	Gender char(1) constraint "Author_Gender_CHK_NL"  not null,
	Qualification varchar(50),
	constraint "Author_Gender_CHK" check (Gender in ('M', 'F')),
	constraint "Author_ID_PK" primary key (ID)
);

CREATE TABLE  [person].[publisher]
(	ID integer, 
	NAME varchar(100) CONSTRAINT "Publisher_Name" NOT NULL , 
	CITY varchar(50), 
	ZIP varchar(5), 
	CONSTRAINT "Publisher_ID_PK" PRIMARY KEY ([ID]) , 
	
);

create table [person].[customer]
(
	ID integer,
	Name varchar(100)  constraint "Customer_Name_CHK_NL"  not null,
	Email varchar(100),
	Phone varchar(11),
	City varchar(50),
	Zip varchar(4),
	constraint "Customer_Zip_CHK" check (Zip like '_____'),
	constraint "Customer_Phone_CHK" check (Phone like '0%'),
	constraint "Customer_Phone_UK" unique (Phone),
	constraint "Customer_Email_CHK" check (Email like '%@%.%'),
	constraint "Customer_ID_PK" primary key (ID)
);


create table [person].[branch]
(
	ID varchar(3),
	Street varchar(50),
	City varchar(50) constraint "Branch_City_CHK_NL" not null,
	constraint "Branch_ID_PK" primary key (ID),
	constraint "Branch_ID_CHK" check (ID like '___')
);


create table [person].[employee]
(
	ID integer,
	Branch_ID varchar(3) constraint "Employee_Br_ID_CHK" not null,
	Salary numeric(10, 2),
	Name varchar(100) constraint "Employee_Dt_Name_CHK_NL"  not null,
	Gender char(1) constraint "Employee_Dt_Gender_CHK_NL"  not null,
	Phone varchar(11) constraint "Employee_Dt_Phone_CHK_NL"  not null,
	City varchar(50) constraint "Employee_Dt_City_CHK_NL" not null,
	Street varchar(50),
	constraint "Employee_Salary_CHK" check (Salary >= 2000),
	constraint "Employee_Branch_ID_FK" foreign key (Branch_ID)
		references [person].[branch] (ID) on delete cascade,
	constraint "Employee_Phone_CHK" check (Phone like '0%'),
	constraint "Employee_Phone_UK" unique (Phone),
	constraint "Employee_ID_PK" primary key (ID)
);


create table [person].[books]
(
	ID integer,
	Name varchar(100),
	ISBN varchar(30) constraint "Books_ISBN_CHK1" not null,
	Author_ID integer not null identity,
	Publisher_ID integer  not null unique,
	No_of_Books numeric(10, 0),
	constraint "Books_No_Of_Bks_CHK2" check (No_of_Books >= 0),
	constraint "Books_ISBN_CHK" check (ISBN like '%-%-%-%'),
	constraint "Books_ISBN_UK" unique (ISBN),
	constraint "Books_Author_ID_FK" foreign key (Author_ID) 
		references [person].[author] (ID) on delete no action,
	constraint "Books_Publish_ID_FK" foreign key (Publisher_ID)
		references [person].[publisher](ID) on delete no action,
	constraint "Books_ID_PK" primary key (ID)
);



create table [person].[issue]
(
	Customer_ID integer constraint "Issue_Cust_ID_CHK" not null,
	Book_ID integer constraint "Issue_BK_ID_CHK" not null,
	Branch_ID varchar(3) constraint "Issue_Br_ID_CHK" not null,
	Employee_ID integer constraint "Emp_ID_CHK" not null,
	Issue_Date date,
	Return_Date date,
	constraint "Issue_Cust_ID_FK" foreign key (Customer_ID)
		references [person].[customer] (ID),
	constraint "Issue_Book_ID_FK" foreign key (Book_ID)
		references [person].[books](ID),
	constraint "Issue_Branch_ID_FK" foreign key (Branch_ID)
		references [person].[branch](ID),
	constraint "Issue_Emp_ID_FK" foreign key (Employee_ID)
		references [person].[employee](ID),
	constraint "Issue_PK" primary key (Customer_ID, Book_ID)
);


CREATE TABLE [person].[user] (
  Username varchar(15) NOT NULL,
  Password varchar(20) NOT NULL,
  
) ;



CREATE TABLE [person].[shelf] (
  ShelfID varchar(10) NOT NULL,
  FloorID varchar(11) NOT NULL,
  constraint "Self_PK" primary key (ShelfID) ,
);

CREATE TABLE [person].[bookcopy] (
  ISBN char(14) NOT NULL,
  CopyID varchar(11) NOT NULL,
  IsChecked varchar(1) NOT NULL DEFAULT '0',
  IsHold varchar(1) NOT NULL DEFAULT '0',
  IsDamaged varchar(1) NOT NULL DEFAULT '0',
  FuRequester varchar(15) DEFAULT NULL,
  CONSTRAINT "Bookcopy_PK" primary key (ISBN,CopyID),
  
); 
