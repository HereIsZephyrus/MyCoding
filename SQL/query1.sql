BEGIN TRANSACTION Query1;
    SELECT EMS.Student.S_name '姓名',EMS.Student.S_ID '学号',EMS.SC.Grade '成绩'
    FROM EMS.Student,EMS.SC,EMS.Course
    WHERE EMS.Course.C_ID=EMS.SC.C_ID
        AND EMS.Course.C_name='数学' AND EMS.SC.Grade>=87;

    SELECT EMS.SC.S_ID '学号',EMS.SC.Grade '成绩'
    FROM EMS.SC,EMS.Course
    WHERE EMS.Course.C_ID=EMS.SC.C_ID AND EMS.Course.C_name='信息系统'
    ORDER BY EMS.SC.Grade DESC;

    SELECT COUNT(Distinct EMS.Student.S_ID) '选修了课程的学生数'
    FROM EMS.Student,EMS.SC
    WHERE EMS.Student.S_ID=EMS.SC.S_ID;
COMMIT;
