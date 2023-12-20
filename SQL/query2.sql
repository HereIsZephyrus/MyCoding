BEGIN TRANSACTION query2;
    SELECT * FROM CS_Student
    WHERE S_age<20;
    SELECT S_name FROM IS_Course
    WHERE Grade>85;
COMMIT;

