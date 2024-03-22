BEGIN TRANSACTION Definition1
DROP TABLE IF EXISTS EMS.SC;
--保护性声明，注意由于参照性的存在要先删除SC表
DROP TABLE IF EXISTS EMS.Student;
DROP TABLE IF EXISTS EMS.Course;

CREATE TABLE EMS.Student(
    S_ID INT PRIMARY KEY,
    S_Name VARCHAR(20) NOT NULL,
    S_sex VARCHAR(4) NOT NULL,
    S_age INT NOT NULL,
    S_dept VARCHAR(10) NOT NULL
);
CREATE TABlE EMS.Course(
    C_ID INT PRIMARY KEY,
    C_Name VARCHAR(20) NOT NULL,
    C_pno INT,
    C_credit INT NOT NULL
);
CREATE TABLE EMS.SC(
    S_ID INT NOT NULL,
    C_ID INT NOT NULL,
    Grade INT,
    PRIMARY KEY(S_ID,C_ID),
    FOREIGN KEY(S_ID) REFERENCES EMS.Student(S_ID),
    FOREIGN KEY(C_ID) REFERENCES EMS.Course(C_ID)
);
ALTER TABLE EMS.SC
ADD CONSTRAINT S_ID
FOREIGN KEY (S_ID) REFERENCES EMS.Student(S_ID)
ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE EMS.SC
ADD CONSTRAINT C_ID
FOREIGN KEY (C_ID) REFERENCES EMS.Course(C_ID)
ON DELETE CASCADE ON UPDATE CASCADE
COMMIT;