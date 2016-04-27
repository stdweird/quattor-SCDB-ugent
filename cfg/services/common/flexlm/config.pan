unique template common/flexlm/config;

variable LICENSE_FILENAME ?= 'intel.lic';
variable LICENSE_DIRECTORY ?= '/opt/intel/licenses';

"/software/components/chkconfig/service/flexlm" = dict("on" , "","startstop" , true);

## sysconfig
include 'components/sysconfig/config';
prefix "/software/components/sysconfig/files/flexlm";
'license_dir' = LICENSE_DIRECTORY;
'license_file' = LICENSE_FILENAME;
include 'common/download/service';
'/software/components/download/files' = {
    path = format("%s/%s", LICENSE_DIRECTORY, LICENSE_FILENAME);
    SELF[escape(path)] = create("common/download/auth",
                                "href", format("secure/%s", LICENSE_FILENAME),
                                "perm", "0640",
                                "group", "flexlm",
                                "owner", "flexlm");
    SELF;
};
include 'components/dirperm/config';
"/software/components/dirperm/paths" = append(dict(
    "path",    LICENSE_DIRECTORY,
    "owner",   "root:flexlm",
    "perm",    "0750",
    "type",    "d",
    ));


variable HAS_INTEL_CLUSTERSTUDIO_XE ?= false;

'/system/licenses' = {
        append(SELF, dict(
                "vendor", "Intel",
                "name", "Cluster Studio for Linux",
                "enddate", INTEL_CLUSTERSTUDIO_SUPPORT_ENDDATE,
                "serial", INTEL_CLUSTERSTUDIO_SERIAL,
            ));
        if  (HAS_INTEL_CLUSTERSTUDIO_XE) {
            append(SELF, dict(
                "vendor", "Intel",
                "name", "Cluster Studio for Linux XE",
                "enddate", INTEL_CLUSTERSTUDIO_XE_SUPPORT_ENDDATE,
                "serial", INTEL_CLUSTERSTUDIO_XE_SERIAL,
            ));
            append(SELF, dict(
                "vendor", "Intel",
                "name", "Optimized Technology Preview for High Performance Conjugate Gradient Benchmark",
                "enddate", INTEL_OTP_BENCHMARK_SUPPORT_ENDDATE,
                "serial", INTEL_OTP_BENCHMARK_SERIAL,
                ));

        };
        SELF;
};

# ----------------------------------------------------------------------------
# altlogrotate
# ----------------------------------------------------------------------------
include 'components/altlogrotate/config';
"/software/components/altlogrotate/entries/flexlm-intel-logs" =
  dict("pattern", "/var/log/flexlm/lmgrd.intel.log",
        "compress", true,
        "missingok", true,
        "frequency", "weekly",
        "create", true,
        "ifempty", true,
        "rotate", 10);
