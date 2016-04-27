unique template common/ofed/rpms/config;

variable OFED_RELEASE_VERSION ?= "1.5.4.1";

variable OFED_RPMS_DEVEL ?= true; # true, provide a bunch of symlinks (eg libdat2.so for default DAPL usage)
variable OFED_RPMS_STATIC ?= false;
variable OFED_RPMS_DEBUGINFO ?= false;
variable OFED_RPMS_MPI ?= false;


## this first
include "common/ofed/rpms/"+OFED_RELEASE_VERSION+"/rpms";
include {if (OFED_RPMS_DEVEL) {"common/ofed/rpms/"+OFED_RELEASE_VERSION+"/devel"}};
include {if (OFED_RPMS_STATIC) {"common/ofed/rpms/"+OFED_RELEASE_VERSION+"/static"}};
include {if (OFED_RPMS_DEBUGINFO) {"common/ofed/rpms/"+OFED_RELEASE_VERSION+"/debuginfo"}};
include {if (OFED_RPMS_MPI) {"common/ofed/rpms/"+OFED_RELEASE_VERSION+"/mpi"}};
