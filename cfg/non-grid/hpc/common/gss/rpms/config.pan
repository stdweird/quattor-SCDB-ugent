unique template common/gss/rpms/config;

# add repos

include 'common/gss/rpms/gpfs';
include 'common/gss/rpms/kernelUpdates';
include 'common/gss/rpms/lsi_sas';
include 'common/gss/rpms/utils';
include 'common/gss/rpms/mellanox';

prefix "/software/packages";
"{kernel-devel}" = nlist();
"{kernel-headers}" = nlist();

