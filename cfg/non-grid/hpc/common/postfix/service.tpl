unique template common/postfix/service;

include { 'common/postfix/packages' };

## enable postfix
"/software/components/chkconfig/service/postfix" = nlist("on", "",
    "startstop", true);

## disable sendmail (also binds on port 25)
"/software/components/chkconfig/service/sendmail/off" = "";
"/software/components/chkconfig/service/sendmail/startstop" = true;
