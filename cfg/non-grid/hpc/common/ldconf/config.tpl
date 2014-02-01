
unique template common/ldconf/config;

variable PKG_ARCH_CLUSTER ?= PKG_ARCH_DEFAULT;

variable LDCONF_ARCH_DIR = if ( PKG_ARCH_CLUSTER == 'x86_64') {
                             return('lib64');
                           } else {
                             return('lib');
                           };

# ----------------------------------------------------------------------------
# ldconf
# ----------------------------------------------------------------------------
include {'components/ldconf/config'};
variable LDCONF_USR_LOCAL_LIB ?= true;
"/software/components/ldconf/paths" = {
	append("/usr/kerberos/lib");
	append("/usr/X11R6/lib");
	append("/usr/lib/qt-3.1/lib");
	if (LDCONF_USR_LOCAL_LIB) {
        append("/usr/local/lib");
    };
    SELF;
};
