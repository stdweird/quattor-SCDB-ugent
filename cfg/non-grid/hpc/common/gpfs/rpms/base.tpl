unique template common/gpfs/rpms/base;

variable GPFS_BASE_UPDATE ?= "0";
variable GPFS_BASE_RPMLIST ?= list(
    "gpfs.base-"+GPFS_VERSION_BASE+"-"+GPFS_BASE_UPDATE+"."+PKG_ARCH_GPFS+".rpm",
    #"gpfs.gui-"+GPFS_VERSION_BASE+"-"+GPFS_BASE_UPDATE+"."+PKG_ARCH_GPFS+".rpm",
    "gpfs.docs-"+GPFS_VERSION_BASE+"-"+GPFS_BASE_UPDATE+".noarch.rpm",
    "gpfs.gpl-"+GPFS_VERSION_BASE+"-"+GPFS_BASE_UPDATE+".noarch.rpm",
    "gpfs.msg."+GPFS_LANG_LOCAL+"-"+GPFS_VERSION_BASE+"-"+GPFS_BASE_UPDATE+".noarch.rpm",
);
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

