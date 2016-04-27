unique template common/ofed/qlogic;

## some qlogic/qib specific settings
## kcopy service
include 'components/chkconfig/config';
"/software/components/chkconfig/service/kcopy/on" = "";
"/software/components/chkconfig/service/kcopy/startstop" = true;

"/software/components/chkconfig/service/qlogic_sa/off" = "";
"/software/components/chkconfig/service/qlogic_sa/on" = null;
"/software/components/chkconfig/service/qlogic_sa/startstop" = true;

"/software/components/chkconfig/service/qlogic_fm/off" = "";
"/software/components/chkconfig/service/qlogic_fm/on" = null;
"/software/components/chkconfig/service/qlogic_fm/startstop" = true;



"/software/components/symlink/links" = {
    SELF[length(SELF)] = dict("name", "/lib64/libofedplus.so",
                             "target", "/lib64/libofedplus.so.0.0",
                             "exists", false,
                             "replace", dict("all","yes"),
                              );
    SELF;
};
