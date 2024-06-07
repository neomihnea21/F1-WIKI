--cerinta 1
SELECT e.last_name, e.salary, j.job_title, d.department_id, l.city, c.country_name, concat(concat(boss.last_name, ' '), boss.first_name) "Nume si Prenume Manager" from employees e
inner join employees boss on boss.employee_id=e.manager_id
inner join jobs j on e.job_id=j.job_id
inner join departments d on d.department_id=e.department_id 
inner join locations l on l.location_id=d.location_id
inner join countries c on c.country_id=l.country_id
where boss.last_name='Hunold' and boss.first_name='Alexander'
and e.hire_date>to_date('01-07-1991', 'dd-mm-yyyy') and e.hire_date<to_date('28-02-1999', 'dd-mm-yyyy');

--cerinta 2
SELECT d.department_id, d.department_name,  NVL(to_char(d.manager_id), 'Departamentul nu are manager') "Manager Departament",
NVL(to_char(e.employee_id), 'Departamentul nu are angajati') "Angajati departament"
from departments d left join employees e on d.department_id=e.department_id;

--cerinta 3
SELECT employee_id, last_name, e.department_id, salary, e.job_id from employees e
inner join departments d on d.department_id=e.department_id
inner join locations l on l.location_id=d.location_id
WHERE (salary, commission_pct) in(SELECT salary, commission_pct from employees e inner join departments d on d.department_id=e.department_id
                                               inner join locations l on l.location_id=d.location_id 
                                               where l.city='Oxford');

--cerinta 4
CREATE TABLE campanie_VNE(
    cod_campanie int,
    titlu varchar(30) not null,
    data_start date default sysdate,
    data_end date, 
    valoare int, 
    cod_sponsor int
);
alter table campanie_VNE
add constraint PK_Cod PRIMARY KEY (cod_campanie);
alter table campanie_VNE
add constraint ordine_date check (data_start<data_end);

create table SPONSOR_VNE(
    cod_sponsor int PRIMARY KEY,
    nume varchar(40) unique not null,
    email varchar(40) unique
);
alter table campanie_VNE
add constraint legare_sponsor foreign key(cod_sponsor) references SPONSOR_VNE(cod_sponsor);
commit;

--cerinta 5
--inserare explicita
insert into sponsor_vne 
(cod_sponsor, nume, email)
values
--(10, 'CISCO', 'cisco@gmail.com');
--(20, 'KFC', NULL);
--(30, 'ADOBE', 'adobe@adobe.com');
--(40, 'BRD', NULL);
--(50, 'VODAFONE', 'vdf@gmail.com');
--(60, 'BCR', NULL);
--(70, 'SAMSUNG', NULL);
--(80, 'IBM', 'ibm@ibm.com');
--(90, 'OMV', NULL);
(100, 'ENEL', NULL);
commit;
--inserare explicita aici
select * from campanie_vne;
insert into campanie_vne (cod_campanie, titlu, data_start, data_end, valoare, cod_sponsor) values
--(1, 'CAMP1', sysdate, to_date('20-06-2024', 'dd-mm-yyyy'), 1200, 10);
--(2, 'CAMP2', sysdate, to_date('25-07-2024', 'dd-mm-yyyy'), 3400, 20);
--(3, 'CAMP3' ,sysdate, to_date('10-06-2024', 'dd-mm-yyyy'), NULL, 30);
--(4, 'CAMP4', sysdate, to_date('20-06-2024', 'dd-mm-yyyy'), NULL, 40);
--(5, 'CAMP5', sysdate, to_date('05-06-2024', 'dd-mm-yyyy'), 2200, 50);
--(6, 'CAMP6', sysdate, to_date('15-08-2024', 'dd-mm-yyyy'), NULL, 60);
--(7 ,'CAMP7', sysdate, to_date('02-09-2024', 'dd-mm-yyyy'), 5500, 70);
--(8, 'CAMP8', sysdate, to_date('10-10-2024', 'dd-mm-yyyy'), NULL, 20);
--(9, 'CAMP9', sysdate, to_date('10-06-2024', 'dd-mm-yyyy'), 4000, 30);
(10, 'CAMP10', sysdate, to_date('25-09-2024', 'dd-mm-yyyy'), 3500, NULL);
commit;
select * from campanie_vne;
select * from sponsor_vne;
--cerinta 6

DELETE from campanie_vne
WHERE data_end<to_date('01-07-2024', 'dd-mm-yyyy');
rollback;
--cerinta 7

--vom face conversie la de la int la varchar pentru asta si inapoi
alter table campanie_vne
add valoare_string varchar(20);
update campanie_vne
set valoare_string=NVL(to_char(valoare*1.25), 'Campanie Caritabila');
select cod_campanie, titlu, data_start, data_end, valoare_string, cod_sponsor from campanie_vne; 
rollback;
alter table campanie_vne
drop column valoare_string;
--cerinta 8

--deoarece sponsorii sunt cheie externa in campanii, trebuie sa decidem ce facem cu o campanie cand stergem un sponsor
--noi vom pune on delete cascade ca sa se stearga campaniile cand pleaca sponsorul, dupa care stergem sponsorul
alter table campanie_vne
add constraint legare_sponsor foreign key (cod_sponsor) references sponsor_vne(cod_sponsor) on delete cascade;
DELETE from SPONSOR_VNE
where cod_sponsor=20;
select * from sponsor_vne;
--cerinta 9

--e deja pusa regula de stergere a sponsorilor, asa ca acum doar dam delete
delete from sponsor_vne
where cod_sponsor not in(select cod_sponsor from campanie_vne where cod_sponsor is not null);