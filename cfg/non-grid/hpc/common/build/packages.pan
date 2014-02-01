unique template common/build/packages;

prefix "/software/packages";

"{binutils-devel}" = nlist();
"{bzip2-devel}" = nlist();
"{cairo-devel}" = nlist();
"{cairo}" = nlist();
"{clusterbuildrpm-server}" = nlist();
"{db4-devel}" = nlist();
"{expat-devel}" = nlist();
"{expat}" = nlist();
"{gcc-c++}" = nlist();
"{gcc-gfortran}" = nlist();
"{gcc}" = nlist();
"{git}" = nlist();
"{glib-devel}" = nlist();
"{glibc-devel}" = nlist();
"{glibc-devel}" = nlist();
"{glibc-headers}" = nlist();
"{glib}" = nlist();
"{gmp-devel}" = nlist();
"{gmp}" = nlist();
"{libXaw-devel}" = nlist();
"{libXaw}" = nlist();
"{libXdamage-devel}" = nlist();
"{libXdamage}" = nlist();
"{libXfixes-devel}" = nlist();
"{libXfixes}" = nlist();
"{libXmu-devel}" = nlist();
"{libXmu}" = nlist();
"{libtool}" = nlist();
"{make}" = nlist();
"{ncurses-devel}" = nlist();
"{ncurses}" = nlist();
"{postgresql-libs}" = nlist();
"{python-setuptools}" = nlist();
"{readline-devel}" = nlist();
"{readline}" = nlist();
"{rpmdevtools}" = nlist();
"{rpmrebuild}" = nlist();
"{subversion}" = nlist();
"{tetex}" = nlist();
"{tmpwatch}" = nlist();
"{unixODBC}" = nlist();
"{xmlto}" = nlist();
"/software/packages" = {
    SELF[escape(format("glibc-devel.%s", LIBSTDC_32_ARCH))] = nlist();
    SELF;
};


include 'rpms/build';
