unique template common/ca/config;

include 'common/ca/schema';

bind "/software/components/metaconfig/services/{/etc/sindes/ca.config}/contents" = openssl_sindes_file;

prefix "/software/components/metaconfig/services/{/etc/sindes/ca.config}";

"module" = "tiny";
"contents" = create("common/ca/ca");

"contents/req_distinguished_name" = dict(
    "O", SINDES_SITE_CRT_O,
    "OU", SINDES_SITE_CRT_OU,
    "CN", format("%s CA", FULL_HOSTNAME));

include 'components/dirperm/config';

"/software/components/dirperm/paths" = {
    foreach (i; dir; list("", "CA", "CA/ca")) {
        append(dict("path", format("/var/sindes/%s", dir),
                     "owner", "sindes:sindes",
                     "perm", "0770",
                     "type", "d"));
    };
    append(dict("path", "/etc/sindes",
                 "owner", "root:ccmcert",
                 "type", "d",
                 "perm", "0750"));
    append(dict("path", "/etc/sindes/sindesrc",
                 "owner", "root:sindes",
                 "perm", "0640",
                 "type", "f"));
    append(dict("path", "/etc/sindes/sindessh.log4perl.conf",
                 "perm", "0640",
                 "type", "f",
                 "owner", "root:sindes"));
    append(dict("path", "/etc/sindes/getcertificate.log4perl.conf",
                 "owner", "root:sindes",
                 "perm", "0640",
                 "type", "f"));
};

include 'components/accounts/config';

"/software/components/accounts/groups/sindes/gid" = 480;

prefix "/software/components/accounts/users/sindes";

"uid" = 480;
"createHome" = false;
"homeDir" = "/home/sindes";
"shell" = "/usr/bin/sindessh";
"comment" = "SINDES account";
"groups/0" = "sindes";
"groups/1" = "ccmcert";

"/software/components/accounts/users/apache/groups" = append("sindes");
"/software/components/accounts/users/apache/groups" = append("ccmcert");
