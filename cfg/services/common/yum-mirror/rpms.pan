unique template common/yum-mirror/rpms;

prefix "/software/packages";

"{mod_ssl}" = dict();
"{httpd}" = dict();
"{reposnap}" = dict();
"{perl-Config-Tiny}" = dict();
"{createrepo}" = dict();
# for el7 rpms on el6
"{pyliblzma}" = dict();
