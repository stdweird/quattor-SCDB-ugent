unique template common/gss/rpms/2.0/kernelUpdates;

variable OS_REPOSITORY_LIST = append("gss/kernelUpdates");

prefix "/software/packages";
"{dkms}" = dict();
