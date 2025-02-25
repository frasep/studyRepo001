/**************************************************************/
/* Study dynamic init related to current GIT branch           */
/**************************************************************/
%let studyName=study1;
%let bucketsRootPath = /mnt/viya-share/data/Buckets;
%let reposRootPath = /mnt/viya-share/data/repos;
%get_current_gitbranch(&reposRootPath, &studyName);

%createFolderIfNotExist(&bucketsRootPath./&studyName., &current_gitbranch.);
%createFolderIfNotExist(&bucketsRootPath./&studyName./&current_gitbranch.,data);
%createFolderIfNotExist(&bucketsRootPath./&studyName./&current_gitbranch.,outputs);
%createFolderIfNotExist(&bucketsRootPath./&studyName./&current_gitbranch.,logs);

/**************************************************************/

options nodate pageno=1 linesize=80 pagesize=60 source;
proc printto log="&studyPath./&current_gitbranch./logs/sas_log.log";
   run;

data numbers;
   input x y z;
   datalines;
 14.2   25.2   96.8
 10.8   51.6   96.8
  9.5   34.2  138.2
  8.8   27.6   83.2
 11.5   49.4  287.0
  6.3   42.0  170.7
;
run;

proc printto print="&studyPath./&current_gitbranch./outputs/sas_output.log"
new;
run;
proc print data=numbers;
   title 'The Numbers Data Set';
run;
proc printto;
run;