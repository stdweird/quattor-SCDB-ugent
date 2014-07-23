unique template repository/config/ceph;


variable OS_REPOSITORY_LIST = append('ceph-extras');

prefix '/software/packages';
"{redhat-lsb-core}" = nlist();
