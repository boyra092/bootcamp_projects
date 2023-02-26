create table customer (
  customerid int primary key,
  customername text,
  customerage int
);

insert into customer values 
  (1,"Boy",20),
  (2,"Tai",22),
  (3,"Goi",13),
  (4,"Gii",53),
  (5,"Guu",33),
  (6,"Gaa",37),
  (7,"Bo",34)   ;       

.mode markdown
.header on  
select * from customer;

create table branch (
  branchid int primary key,
  branchprovince text,
  branchsize text
);

insert into branch values
	(1,"Bangkok","S"),
    (2,"Yala","L"),
    (3,"Phuket","M");

.mode markdown
.header on  
select * from branch;

create table payment (
  paymentid int not null primary key,
  paymentmethod text,
  paymenttime
);

insert into payment values 
  (1,"credit","2022-01-22 16.12.11"),
  (2,"cash","2022-03-21 12.11.50"),
  (3,"cash","2022-09-30 9.01.32");

.mode markdown
.header on  
select * from payment;

create table sale (
  saleid int primary key,
  saleproduct text,
  saleprice int
);

insert into sale values
	(1,"shabu",300),
    (2,"timsum",250),
    (3,"pizza",199),
  (4,"pizza",199),
  (5,"pizza",199),
    (6,"timsum",250),
  (7,"pizza",199);

.mode markdown
.header on  
select * from sale;

create table feedback (
  feedbackid int primary key, 
  feedbackscore int,
  paymentid int,
  saleid int,
  branchid int,
  customerid int,
  FOREIGN KEY (customerid) references customer(customerid)
  FOREIGN KEY (paymentid) REFERENCES payment(paymentid)
  FOREIGN KEY (saleid) REFERENCES sale(saleid)
  FOREIGN KEY (branchid) REFERENCES branch(branchid));

INSERT INTO feedback VALUES
  (1,8,1,2,6,4),
  (2,9,3,9,5,4),
  (3,3,5,7,4,7),
  (4,8,7,5,3,6),
  (5,9,9,4,2,5),
  (6,6,3,2,1,4);

.mode markdown
.header on  
select * from feedback;

--Q1 What is the mean of feedback score in each product ?

select avg(feedbackscore), saleproduct, saleprice from feedback 
  join sale on feedback.saleid = sale.saleid
  group by saleproduct;

--Q2 What are the sale product and price with feedback score > 5 ?
select saleproduct, saleprice from feedback 
  join sale on feedback.saleid = sale.saleid
  where feedbackscore > 5;

--Q3 What are the sale product that having lowest sale price and getting feedback score > 5 ?
select saleproduct from 
  (select saleproduct, saleprice from feedback 
  join sale on feedback.saleid = sale.saleid
  where feedbackscore > 5) order by saleprice
  limit 1;
