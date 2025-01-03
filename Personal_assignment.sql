---personal assignment_1---

create database studentmanagement
use studentmanagement

create table students(studentid int,firstname varchar(20),lastname varchar(20),age int,gender varchar(10),marks float)

insert into students values(101,'manu','k',20,'male',80.90)
insert into students values(102,'anu','k',21,'female',70)
insert into students values(103,'midhun','kesu',22,'male',90)
insert into students values(104,'soman','k',20,'male',88)
insert into students values(105,'jamanu','kuio',21,'male',50)
insert into students values(106,'indira','jui',22,'female',40)
insert into students values(107,'megha','k',20,'female',70)
insert into students values(108,'manunuo','kyui',21,'male',100)
insert into students values(109,'wemanu','kert',23,'male',10)
insert into students values(110,'meghakesu','shibu',25,'female',95)

select * from students
select firstname,marks from students
select * from students where marks>80


select * from students where age between 18 and 25
select * from students where gender='female'
select * from students  where lastname like '%k'

select * from students max
select avg(marks) from students
select max(marks) as maximummarks,min(marks) as minimummarks from students

alter table students add  city varchar(50)
select * from students
sp_rename 'students.city','hydrabad','column' 
select * from students
update students set hydrabad='city'
select * from students
sp_rename 'students.hydrabad','city','column'
update students set city='hydrabad' where marks>80


delete from students where marks<40
select * from students

drop table students


create table courses(courseid int,coursename varchar(10),studentid int)

insert into courses values(100,'bca',101)
insert into courses values(101,'bcom',102)
insert into courses values(102,'bba',103)
insert into courses values(103,'mba',104)
insert into courses values(104,'mca',105)

select * from courses
select * from students

select students.studentid,students.firstname,courses.coursename from students inner join courses on students.studentid=courses.studentid
select students.studentid,students.firstname,courses.coursename from students left join courses on students.studentid=courses.studentid
select students.studentid,students.firstname,courses.coursename from students right join courses on students.studentid=courses.studentid


---personal assignment_2---
---not-null--constraints---

drop table if exists employess
create table employess(empid int not null,firstname varchar(20) not null,lastname varchar(20),hiredate date not null)
insert into employess values(101,'manu','k','06/19/1995')
insert into employess values(null,'manu','k','06/19/1995')

select * from employess
 
 ---default constraints---
drop table if exists products
create table products(productid int primary key,productname varchar(20) not null,price decimal(10,2) default 0.00,createdate datetime default current_timestamp)
insert into products  values(100,'orange',default,default)
select * from products
sp_help products

alter table products drop constraint DF__products__price__5DCAEF64
sp_help products

ALTER TABLE products
ADD CONSTRAINT priceconstraint DEFAULT 10.00 FOR price;

insert into products  values(103,'orage',default,default)
select * from products

---check constraints---
drop table if exists orders
create table orders(orderid int primary key,quantity int check(quantity>0),orderdate date)
insert into orders values(100,0,'05/14/1998')
insert into orders values(101,4,'09/11/1998')

select * from orders
sp_help orders
alter table orders drop constraint check_order

ALTER TABLE orders
ADD CONSTRAINT check_order CHECK (quantity>=5)

INSERT INTO Orders (OrderID, Quantity, OrderDate) VALUES (5, 5, '2024-01-01');
INSERT INTO Orders (OrderID, Quantity, OrderDate) VALUES (6, 10, '2023-12-30');

sp_help orders

---unique constraints---
drop table if exists users
create table users(userid int primary key,username varchar(20) unique,email varchar(20) unique)
insert into users values(101,'manu','manukshibu@gmail.com')
insert into users values(102,'mu','manukshiu@gmail.com')
insert into users values(103,'anu','manshibu@gmail.com')

select * from users



----personal assignment---3
----Understanding Primary Keys---
drop table if exists students
create table students(stid int primary key,fname varchar(10),lname varchar(10),age int)

insert into students values(1,'manu','kshibu',20)
insert into students values(2,'manu','kshibu',21)
insert into students values(3,'manu','kshibu',22)
insert into students values(4,'manu','kshibu',23)
insert into students values(5,'manu','kshibu',24)

select * from students

select * from students where stid=2

insert into students values(5,'manu','kshibu',24)


---personal assignment--4---
---Understanding Foreign Keys---
drop table if exists courses
create table courses(cid int primary key,cname varchar(20))

insert into courses values(10,'bca')
insert into courses values(11,'bcom')
insert into courses values(12,'bba')

select * from courses

drop table if exists enrolment
create table enrolment(eid int primary key,cid int foreign key references courses(cid),stid int foreign key references students(stid))

insert into enrolment values(20,10,1)
insert into enrolment values(21,11,2)
insert into enrolment values(22,12,3)

--List all students enrolled in a specific course (e.g., CourseID = 1)--
SELECT students.stid FROM enrolment students WHERE students.cid = 10;

-- Create the tables
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Contact VARCHAR(255)
);

CREATE TABLE BorrowedBooks (
    TransactionID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowedDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert sample data into Books
INSERT INTO Books (BookID, Title, Author)
VALUES
    (1, 'The Great Gatsby', 'F. Scott Fitzgerald'),
    (2, '1984', 'George Orwell'),
    (3, 'To Kill a Mockingbird', 'Harper Lee');

-- Insert sample data into Members
INSERT INTO Members (MemberID, Name, Contact)
VALUES
    (101, 'Alice Johnson', 'alice@example.com'),
    (102, 'Bob Smith', 'bob@example.com'),
    (103, 'Charlie Brown', 'charlie@example.com');

-- Insert sample data into BorrowedBooks
INSERT INTO BorrowedBooks (TransactionID, MemberID, BookID, BorrowedDate, ReturnDate)
VALUES
    (1, 101, 1, '2024-12-01', '2024-12-10'),
    (2, 102, 2, '2024-12-02', NULL),
    (3, 103, 3, '2024-12-05', '2024-12-15'),
    (4, 101, 2, '2024-12-07', '2024-12-17');


	SELECT M.MemberID, M.Name, M.Contact
FROM Members M
JOIN BorrowedBooks BB ON M.MemberID = BB.MemberID
WHERE BB.BookID = 2;

SELECT B.BookID, B.Title, B.Author
FROM Books B
JOIN BorrowedBooks BB ON B.BookID = BB.BookID
WHERE BB.MemberID = 101;

SELECT B.BookID, B.Title, B.Author, M.Name, BB.ReturnDate
FROM Books B
JOIN BorrowedBooks BB ON B.BookID = BB.BookID
JOIN Members M ON M.MemberID = BB.MemberID
WHERE BB.ReturnDate < getdate() OR BB.ReturnDate IS NULL;



