BEGIN TRANSACTION trigger1;
DROP TRIGGER IF EXISTS EMS.trace_student_update;
DROP TRIGGER IF EXISTS EMS.trace_student_delete;
DROP TRIGGER IF EXISTS EMS.trace_course_update;
GO
CREATE TRIGGER EMS.trace_student_update
ON EMS.Student
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE EMS.SC
    SET SC.S_ID = inserted.S_ID
    FROM inserted,deleted
    WHERE SC.S_ID = deleted.S_ID
END;
GO
CREATE TRIGGER EMS.trace_course_update
ON EMS.Course
FOR UPDATE
AS
IF (UPDATE(C_Name))
BEGIN
    PRINT 'Course name is fixed';
    ROLLBACK;
END
GO
CREATE TRIGGER EMS.trace_student_delete
ON EMS.Student
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE EMS.SC
    FROM deleted
    WHERE SC.S_ID = deleted.S_ID
END;
GO
COMMIT;