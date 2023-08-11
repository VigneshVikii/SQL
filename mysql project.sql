create database sql_project; 
use sql_project;
show tables;
create table Patient_Info(patient_id int primary key auto_increment,
Patient_name varchar(255) not null,Type_of_sickness varchar(255) DEFAULT'GENRAL'
,medicines varchar(256) not null,Insurance_no int unique , check(Insurance_no>=1));
insert into Patient_Info values(106,"Lavanya","knee pain"," GO365 Nura Tablet",6),
(107,"jegan","Back pain","lobacknil",7),
(108,"Venkat","Ulcer","protonix",8);
select *from Patient_Info;
create table patient_pc_info(patient_id int primary key,patient_name varchar(255) not null,
address varchar(255),Attender varchar(255),Contact varchar(255), 
constraint FK_patient_id foreign key(patient_id)references Patient_Info(patient_id));
insert into Patient_pc_info values(103,"Yoga","PATTUKKOTAI","DR.SHINDHIYA",'7988456123'),
(105,"Hari","PATTUKKOTTAI","DR.SHINDHIYA",9321654987)
,(104,"Selvam","THIRUVARUR","DR.RAHUL",8976541235);
insert into Patient_pc_info values(106,"lavanya","PATTUKKOTTAI","DR.INDHU",8856437890);
select *from Patient_pc_info;
 create table pt_HS_info(patient_id int primary key,patient_name varchar(455) not null,
 Fees int default '300', Medicine_amnt int ,Total float as (fees+Medicine_amnt),
 GST float AS(Total*18/100), Final_Amnt float AS(Total+GST),check(Medicine_amnt>0),
 constraint UK_patient_id foreign key(patient_id)references Patient_Info(patient_id));
insert into pt_HS_info(patient_id,patient_name,Fees,Medicine_amnt) values(108,"Venkat","990","7640");
select *from pt_HS_info;
create table insurance(insurance_no int unique,patient_id int primary key,
Name varchar(255),Eligible varchar(255),
constraint TK_patient_id foreign key(patient_id) references Patient_Info(patient_id));
insert into insurance values(11,101,"Vigensh",5),(12,102,"Rajashankari",11),
(13,103,"Yoga",20),(14,104,"Selvam",12),(15,105,"Hari",6),(16,108,"Venkat",7);
select *from insurance;
(select Patient_Info.patient_id,Patient_Info.patient_name,patient_pc_info.Attender,
pt_HS_info.Total,pt_HS_info.GST,pt_HS_info.Final_Amnt,insurance.insurance_no,
insurance.Eligible from Patient_Info inner join patient_pc_info on 
Patient_Info.patient_id=patient_pc_info.patient_id RIGHT join
 pt_HS_info on Patient_Info.patient_id=pt_HS_info.patient_id 
 LEFT join insurance on Patient_Info.patient_id=insurance.patient_id);
 select Patient_Info.patient_id,Patient_Info.patient_name,pt_HS_info.Total,pt_HS_info.GST,pt_HS_info.Final_Amnt
 from patient_Info right join pt_HS_info on Patient_Info.patient_id=pt_HS_info.patient_id;
  select Patient_Info.patient_id,Patient_Info.patient_name,insurance.insurance_no,insurance.Eligible from Patient_Info
  LEFT join insurance 
 on Patient_Info.patient_id=insurance.patient_id;