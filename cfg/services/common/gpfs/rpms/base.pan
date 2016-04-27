unique template common/gpfs/rpms/base;

variable GPFS_BASE_UPDATE ?= "0";
variable GPFS_BASE_RPMLIST ?= {
    rpms = list(
        format("gpfs.base-%s-%s.%s.rpm", GPFS_VERSION_BASE, GPFS_BASE_UPDATE, PKG_ARCH_GPFS),
        format("gpfs.docs-%s-%s.noarch.rpm", GPFS_VERSION_BASE, GPFS_BASE_UPDATE),
        format("gpfs.gpl-%s-%s.noarch.rpm", GPFS_VERSION_BASE, GPFS_BASE_UPDATE),
        format("gpfs.msg.%s-%s-%s.noarch.rpm", GPFS_LANG_LOCAL, GPFS_VERSION_BASE, GPFS_BASE_UPDATE),
    );
    if(GPFS_VERSION_MAJOR >= 4) {
        append(rpms, format("gpfs.ext-%s-%s.%s.rpm", GPFS_VERSION_BASE, GPFS_BASE_UPDATE, PKG_ARCH_GPFS));
        # no gskit?
    };
    rpms;
};
    
"/software/components/gpfs/base/rpms" = GPFS_BASE_RPMLIST;

variable GPFS_BASE_BASEURL ?= undef;
"/software/components/gpfs/base/baseurl" = GPFS_BASE_BASEURL;

variable GPFS_BASE_USE_PROXY ?= false;
"/software/components/gpfs/base/useproxy" = GPFS_BASE_USE_PROXY;

variable GPFS_BASE_USE_CURL ?= true;
"/software/components/gpfs/base/usecurl" = GPFS_BASE_USE_CURL;

variable GPFS_BASE_USE_CCMCERTWITHCURL ?= false;
"/software/components/gpfs/base/useccmcertwithcurl" = GPFS_BASE_USE_CCMCERTWITHCURL;

variable GPFS_BASE_USE_SINDESGETCERTCERTWITHCURL ?= true;
"/software/components/gpfs/base/usesindesgetcertcertwithcurl" = GPFS_BASE_USE_SINDESGETCERTCERTWITHCURL;
