use UNIVER
CREATE TABLE TIMETABLE (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    IDGROUP INT CONSTRAINT TIMETABLE_GROUP_FK FOREIGN KEY REFERENCES GROUPS(IDGROUP) NOT NULL,
    AUDITORIUM CHAR(20) CONSTRAINT TIMETABLE_AUDITORIUM_FK FOREIGN KEY REFERENCES AUDITORIUM(AUDITORIUM) NOT NULL,
    SUBJECT CHAR(10) CONSTRAINT TIMETABLE_SUBJECT_FK FOREIGN KEY REFERENCES SUBJECT(SUBJECT) NOT NULL,
    TEACHER CHAR(10) CONSTRAINT TIMETABLE_TEACHER_FK FOREIGN KEY REFERENCES TEACHER(TEACHER) NOT NULL,
    DAY_OF_WEEK VARCHAR(20) CHECK (DAY_OF_WEEK IN ('�����������', '�������', '�����', '�������', '�������', '�������')),
    PERIOD INT CHECK (PERIOD BETWEEN 1 AND 7) -- ���� (1-7)
);


insert into TIMETABLE (IDGROUP, AUDITORIUM, SUBJECT, TEACHER, DAY_OF_WEEK, PERIOD)
	values (1, '301-1', '��', '����      ', '�����������', 1),
			(2 , '304-4', '���', '����      ', '�������', 2),
			(3, '313-1', '��        ', '����      ', '�����', 3),
			(4, '314-4', '���       ', '����      ', '�������', 4),
			(5, '320-4', '��        ', '����      ', '�������', 5),
			(6, '324-1', '���       ', '����      ', '�������', 6),
			(7, '413-1', '����      ', '����      ', '�����������', 7),
			(8, '423-1', '��        ', '���       ', '�������', 1),
			(9, '320-4', '����      ', '����      ', '�����', 2),
			(10, '423-1', '����      ', '����      ', '�������', 3);



SELECT AUDITORIUM.AUDITORIUM 
FROM AUDITORIUM 
LEFT JOIN TIMETABLE 
    ON AUDITORIUM.AUDITORIUM = TIMETABLE.AUDITORIUM 
    AND TIMETABLE.DAY_OF_WEEK = '�����������'
    AND TIMETABLE.PERIOD = 1
WHERE TIMETABLE.AUDITORIUM IS NULL;
