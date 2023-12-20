DROP VIEW IF EXISTS CS_Student;
DROP VIEW IF EXISTS IS_Course;
GO

CREATE VIEW CS_Student --Student of computer science department
AS
    SELECT S_ID,S_Name ,S_sex,S_age,S_dept
    FROM EMS.Student
    WHERE S_dept='CS';
GO

CREATE VIEW IS_Course --Student on information system class
AS
    SELECT EMS.Student.S_ID S_ID, S_Name , Grade
    FROM EMS.Student,EMS.SC,EMS.Course
    WHERE EMS.Student.S_ID=EMS.SC.S_ID AND EMS.SC.C_ID=EMS.Course.C_ID
        AND EMS.Course.C_name='信息系统';
GO
