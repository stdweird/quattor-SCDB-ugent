unique template common/oncall/members;

include {'components/metaconfig/config'};

include 'common/oncall/schema';

prefix "/software/components/metaconfig/services/{/etc/oncall.conf}";

"owner" = "root";
"group" = "root";
"mode" = 0640;
"module" = "tiny";

"contents/db/name" = ONCALL_VARIANT;
"contents/db/user" = if (DOMAIN == 'ugent.be') {
    'icinga';
    } else {
    "ndoutils";
};

"contents/db/password" = if (DOMAIN == 'ugent.be') {
    ONCALL_DB_PASSWD_T2;
} else {
    ONCALL_DB_PASSWD_T1;
};

"contents/google/login" = "hpc-admin@lists.ugent.be";
"contents/google/passwd" = GOOGLE_CALENDAR_PASSWD;

"contents/sms/passwd" = SMS_PASSWD;

"contents/mail/from" = format("OnCall_Daemon@%s", SENDING_DOMAIN);
"contents/mail/to" = "hpc-admin@lists.ugent.be";

"contents/admins/shortn" = "kh,wdp,sdw,jt,ag";

"contents/jt/name" = "Jens Timmerman";
"contents/jt/email" = "jens.timmerman@ugent.be";
"contents/jt/tel" = JENS_PHONE;

"contents/kh/name" = "Kenneth Hoste";
"contents/kh/email" = "kenneth.hoste@ugent.be";
"contents/kh/tel" = KENNETH_PHONE;

"contents/wdp/name" = "Wouter Depypere";
"contents/wdp/email" = "wouter.depypere@ugent.be";
"contents/wdp/tel" = WOUTER_PHONE;


"contents/ag/name" = "Andy Georges";
"contents/ag/email" = "andy.georges@ugent.be";
"contents/ag/tel" = ANDY_PHONE;


"contents/sdw/name" = "Stijn De Weirdt";
"contents/sdw/email" = "stijn.deweirdt@ugent.be";
"contents/sdw/tel" = STIJN_PHONE;

"contents/lfm/name" = 'Luis Fernando Muñoz Mejías';
"contents/lfm/email" = 'luis.munoz@ugent.be';
"contents/lfm/tel" = LUIS_PHONE;

"contents/admins/shortn" = "kh,wdp,sdw,jt,ag,lfm";
