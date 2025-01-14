use UNIVER
select A.id, A.value_A, B.id, B.value_B
from A full outer join B on A.id = b.id;
select *
from  B full outer join A on B.id = A.id
select *
from A full outer join B on A.id = B.id where B.id is null;
select * 
from A full outer join B on A.id = B.id where A.id is null;
select * 
from A full outer join B on A.id = B.id where A.id is not null and B.id is not null;