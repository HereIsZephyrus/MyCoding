BEGIN TRANSACTION Update1;
    UPDATE EMS.SC
    SET EMS.SC.Grade=EMS.SC.Grade+5
    WHERE 'CS'=(
        SELECT EMS.Student.S_dept
        FROM EMS.Student
        WHERE EMS.Student.S_ID=EMS.SC.S_ID);
COMMIT
