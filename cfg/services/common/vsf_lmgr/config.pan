unique template common/vsf_lmgr/config;

variable LICENSE_FILENAME ?= 'scalemp.license';
variable LICENSE_DIRECTORY ?= '/opt/ScaleMP/vsf_lmgr';

"/software/components/chkconfig/service/vsf_lmgr" = dict("on" , "","startstop" , true);
include 'common/download/service';
'/software/components/download/files' = {

    path = format("%s/%s", LICENSE_DIRECTORY, LICENSE_FILENAME);
    url = format("secure/%s", LICENSE_FILENAME);

    SELF[escape(path)] = create("common/download/auth",
                                "href", url,
                                "perm", "0640");
    SELF;
};
