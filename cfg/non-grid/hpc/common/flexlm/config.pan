unique template common/flexlm/config;

variable LICENSE_FILENAME ?= 'intel.lic';
variable LICENSE_DIRECTORY ?= '/opt/intel/licenses';

"/software/components/chkconfig/service/flexlm" = nlist("on" , "","startstop" , true);

## sysconfig
include { 'components/sysconfig/config' };
prefix "/software/components/sysconfig/files/flexlm";
'license_dir' = LICENSE_DIRECTORY;
'license_file' = LICENSE_FILENAME;


include { 'common/download/service' };

'/software/components/download/files' = {
    path = format("%s/%s", LICENSE_DIRECTORY, LICENSE_FILENAME);
    SELF[escape(path)] = create("common/download/auth",
                                "href", format("secure/%s", LICENSE_FILENAME),
                                "perm", "0640",
                                "group", "flexlm",
                                "owner", "flexlm");
    SELF;
};

include { 'components/dirperm/config'};
"/software/components/dirperm/paths" = append(nlist(
    "path",    LICENSE_DIRECTORY,
    "owner",   "root:flexlm",
    "perm",    "0750",
    "type",    "d",
    ));
