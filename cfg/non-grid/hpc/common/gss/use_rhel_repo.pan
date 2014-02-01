unique template common/gss/use_rhel_repo;

# last
variable OS_REPOSITORY_LIST = {
    t=list();
    foreach(idx;repo;SELF) {
        if (! match(repo,'^sl\d+x?_')) {
            append(t,repo);
        };
    };
    
    # add RHEL
    append(t,"rhel");
    append(t,"rhel_updates");
    
    t;
};
