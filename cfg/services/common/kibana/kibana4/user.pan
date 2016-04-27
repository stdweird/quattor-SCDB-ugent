unique template common/kibana/kibana4/user;

include 'components/accounts/config';
include 'components/useraccess/config';

prefix "/software/components/accounts/users/kibana";

"uid" = 493;
"shell" = "/sbin/nologin";
"password" = "*";
"comment" = "kibana account";
"groups/0" = "kibana";
"createHome" = true;
"homeDir" = "/home/kibana";

"/software/components/accounts/groups/kibana/gid" = 493;
