unique template common/aquilon/accounts;

include 'components/accounts/config';
include 'components/useraccess/config';

prefix "/software/components/accounts/users/aquilon";

"uid" = 389;
"shell" = "/usr/bin/git-shell";
"password" = "*";
"comment" = "Aquilon account";
"groups/0" = "aquilon";
"createHome" = true;
"homeDir" = "/var/quattor";

"/software/components/accounts/groups/aquilon/gid" = 389;

"/software/components/accounts/users" = {
    foreach (i; admin; UGENT_ACTIVE_ADMINS) {
        append(SELF[admin]["groups"], "aquilon");
    };
    SELF;
};

"/software/components/useraccess/users/aquilon/roles" = UGENT_ACTIVE_ADMINS;
