CREATE TABLE students (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(50),
                          age INT,
                          major VARCHAR(50),
                          gpa DECIMAL(3,2)
);

CREATE TABLE scholarships (
                              id SERIAL PRIMARY KEY,
                              student_id INT REFERENCES students(id),
                              name VARCHAR(50),
                              amount DECIMAL(10,2),
                              year INT
);

INSERT INTO students (name, age, major, gpa) VALUES
                                                 ('An', 20, 'CNTT', 3.5),
                                                 ('Bình', 21, 'Toán', 3.2),
                                                 ('Cường', 22, 'CNTT', 3.8),
                                                 ('Dương', 20, 'Vật lý', 3.0),
                                                 ('Em', 21, 'CNTT', 2.9);

INSERT INTO scholarships (student_id, name, amount, year) VALUES
                                                              (1, 'Học bổng xuất sắc', 1000, 2025),
                                                              (3, 'Học bổng xuất sắc', 1200, 2025),
                                                              (2, 'Học bổng khuyến khích', 500, 2025),
                                                              (4, 'Học bổng khuyến khích', 400, 2025);


insert into scholarships (student_id, name, amount, year)
values (5, 'Học bổng khuyến khích', 450, 2025);

update students set gpa = 4.0 where id in (select s.id
                                    from students as s
                                    join scholarships s2 on s.id = s2.student_id
                                    where s2.name = 'Học bổng xuất sắc');

DELETE from scholarships where student_id in (select s.id
                                                  from students as s
                                                  where s.gpa < 3.0);

delete from students where gpa < 3.0;

select s.name, s.major , s2.name, s2.amount
from students as s
join scholarships s2 on s.id = s2.student_id
where s2.year = 2025;

select * from scholarships;

select s.name
from students as s
where s.id in (select s2.student_id
                   from scholarships as s2
                   group by s2.student_id
                   having count(s2.student_id) > 1);

select s.name
from students as s
join scholarships s2 on s.id = s2.student_id
where s.name ilike '%C%' and s2.amount > 1000;

select *
from students
order by gpa desc
limit 2
offset 0;
