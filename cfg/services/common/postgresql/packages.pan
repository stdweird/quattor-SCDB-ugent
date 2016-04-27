unique template common/postgresql/packages;

include 'quattor/functions/repository';

variable PKG_ARCH_POSTGRES ?= PKG_ARCH_DEFAULT;

variable POSTGRES_VERSION ?= format("9.2.4-1PGDG.rhel%s", RPM_BASE_FLAVOUR_VERSIONID);
variable POSTGRES_PKG_VERSION ?= {
    versions = split('\.', POSTGRES_VERSION);
    return(format("%s%s", versions[0], versions[1]));
};

"/software/packages"=pkg_repl(format("postgresql%s*", POSTGRES_PKG_VERSION),POSTGRES_VERSION,PKG_ARCH_POSTGRES);


"/software/packages"={
    SELF[escape(format("postgresql%s-contrib", POSTGRES_PKG_VERSION))] = dict();
    SELF[escape(format("postgresql%s-devel", POSTGRES_PKG_VERSION))] = dict();
    SELF[escape(format("postgresql%s-docs", POSTGRES_PKG_VERSION))] = dict();
    SELF[escape(format("postgresql%s-libs", POSTGRES_PKG_VERSION))] = dict();
    SELF[escape(format("postgresql%s-plperl", POSTGRES_PKG_VERSION))] = dict();
    SELF[escape(format("postgresql%s-plpython", POSTGRES_PKG_VERSION))] = dict();
    SELF[escape(format("postgresql%s-server", POSTGRES_PKG_VERSION))] = dict();
    SELF[escape(format("postgresql%s-test", POSTGRES_PKG_VERSION))] = dict();
    SELF;
    };


"/software/packages/{uuid}" = dict();

variable OS_REPOSITORY_LIST = append("postgresql");
