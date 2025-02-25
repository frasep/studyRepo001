%macro get_current_gitbranch(cloneDir,studyName);
	data _null_;
		infile "&cloneDir/&studyName/.git/HEAD" truncover;
		input line $100.;

		if substr(line, 1, 5)='ref: ' then do;
			current_gitbranch=scan(line, 3, '/');
			call symputx('current_gitbranch', current_gitbranch, 'G');
		end;
	run;
%mend get_current_gitbranch;

%get_current_gitbranch(/mnt/viya-share/data/repos, study1);

%let studyPath = /mnt/viya-share/data/Buckets/Study1;

%macro createFolderIfNotExist(parentDir, folder);
    %if %sysfunc(fileexist(&folder)) = 0 %then %do;
		data _null_;
	    	rc = dcreate("&folder", "&parentDir");
	    	if rc = 0 then
	        	put 'ERROR: Directory could not be created.';
	    	else
	        	put 'Directory created successfully.';
		run;
    %end;
%mend createFolderIfNotExist;

%put Current branch: &current_gitbranch.;
%put Branch path: &studyPath;

%createFolderIfNotExist(&studyPath.,&current_gitbranch.);
%createFolderIfNotExist(&studyPath./&current_gitbranch.,data);
%createFolderIfNotExist(&studyPath./&current_gitbranch.,outputs);
