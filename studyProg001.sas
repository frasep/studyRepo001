/***************************************************************************************************/
/* Macro to get the current GIT branch name from the git clone where the current program is stored */
/* the root of all studies being provided as a parameter */
/* This macro return  */
/***************************************************************************************************/

%macro get_current_gitbranch(git_head_path);
data _null_;
    infile "&git_head_path" truncover;
    input line $100.;
    if substr(line, 1, 5) = 'ref: ' then do;
        current_gitbranch = scan(line, 3, '/');
        call symputx('current_gitbranch', current_gitbranch,'G');
    end;
run;
%mend get_current_gitbranch;

%get_current_gitbranch(/create-export/create/homes/Sebastien.Poussart@sas.com/myrepos/github/studyRepo001/.git/HEAD);

%put Current branch: &current_gitbranch.;
