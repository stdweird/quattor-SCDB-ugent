unique template common/ofed/rpms/1.5.x/el6;


prefix "/software/packages";
"{rdma}" = dict();

variable OFED_QIB_RPMS ?= false;
include {if(OFED_QIB_RPMS) {'common/ofed/rpms/1.5.x/qib'}};
