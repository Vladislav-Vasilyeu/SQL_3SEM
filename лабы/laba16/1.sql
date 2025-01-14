select 
    trim(t.TEACHER) as 'Преподаватель_ФИО',
    trim(t.TEACHER_NAME) as 'Имя',
    trim(t.PULPIT) as 'Кафедра',
    t.GENDER as 'Пол'
from TEACHER t
where t.PULPIT like 'Ещё'
for xml path('Преподаватель'), root('Отчет_Преподавателей'), elements;
