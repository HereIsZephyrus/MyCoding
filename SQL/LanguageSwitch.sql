use master
ALTER DATABASE [StudentManagement] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [StudentManagement] COLLATE Chinese_PRC_Stroke_90_CI_AS_KS_SC_UTF8
ALTER DATABASE [StudentManagement] SET MULTI_USER WITH ROLLBACK IMMEDIATE

ALTER DATABASE [Hospital] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE [Hospital] COLLATE Chinese_PRC_Stroke_90_CI_AS_KS_SC_UTF8
ALTER DATABASE [Hospital] SET MULTI_USER WITH ROLLBACK IMMEDIATE