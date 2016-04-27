unique template common/build/mock;

prefix "/software/packages";
"{mock}" = dict();

# mock installs a mock group
'/software/components/accounts/kept_groups/mock' = '';

# add UGENT_ADMINS to this group
"/software/components/accounts/users" = {
    foreach (i; user; UGENT_ACTIVE_ADMINS) {
        SELF[user]['groups']=append(SELF[user]['groups'],'mock');
    };
    SELF;
};
