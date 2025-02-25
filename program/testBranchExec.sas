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

%get_current_gitbranch(/create-export/create/homes/Sebastien.Poussart@sas.com/myrepos/github, studyRepo001);

%let folderPath = /create-export/create/homes/Sebastien.Poussart@sas.com/data/studyData;

%macro createFolderIfNotExist(folder);
	%put Folder used : &folder;
    %if %sysfunc(fileexist(&folder)) = 0 %then %do;
		data _null_;
	    	rc = dcreate('folderName', "&folder");
	    	if rc = 0 then
	        	put 'ERROR: Directory could not be created.';
	    	else
	        	put 'Directory created successfully.';
		run;
    %end;
%mend createFolderIfNotExist;

%put Current branch: &current_gitbranch.;
%put Current branch: &folderPath;

%createFolderIfNotExist(&folderPath/&current_gitbranch.);
%createFolderIfNotExist(&folderPath/&current_gitbranch./data);
%createFolderIfNotExist(&folderPath/&current_gitbranch./outputs);
