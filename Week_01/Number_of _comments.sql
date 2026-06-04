CREATE TABLE Submissions (
    sub_id INT,
    parent_id INT
);

INSERT INTO Submissions (sub_id, parent_id) VALUES 
(1, NULL),
(2, NULL),
(1, NULL),
(12, NULL),
(3, 1),
(5, 2),
(3, 1),
(4, 1),
(9, 1),
(10, 2),
(6, 7);

select s1.sub_id as post_id,
count (distinct s2.sub_id) as number_of_comments 
from Submissions as s1
left join 
Submissions as s2
on s1.sub_id = s2.parent_id
where s1.parent_id is null
group by s1.sub_id
