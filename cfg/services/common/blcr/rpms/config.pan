unique template common/blcr/rpms/config;

variable PKG_ARCH_BLCR ?= PKG_ARCH_DEFAULT;

variable BLCR_RPM_VERSION ?= "0.8.6_b4-1";

variable BLCR_KERNEL_VERSION ?= KERNEL_VERSION;
variable BLCR_KERNEL_APPEND_ARCH ?= true;
variable BLCR_KERNEL_VERSION_FIXED ?= {
	txt=snr("-","_",BLCR_KERNEL_VERSION);
    if (BLCR_KERNEL_APPEND_ARCH && (RPM_BASE_FLAVOUR_NAME != 'el5')) {
        txt=txt+'.'+PKG_ARCH_DEFAULT;
    };
	txt;
};


'/software/packages'= {
    pkg_repl("blcr",BLCR_RPM_VERSION,PKG_ARCH_BLCR);
    SELF[escape(format("blcr-modules_%s",BLCR_KERNEL_VERSION_FIXED))] = dict();
    SELF;
};

prefix '/software/packages';
"{blcr-devel}" = dict();
"{blcr-libs}" = dict();
"{blcr-testsuite}" = dict();
