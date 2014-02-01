unique template common/postgresql/packages;

include 'quattor/functions/repository';

variable PKG_ARCH_POSTGRES ?= PKG_ARCH_DEFAULT;

variable POSTGRES_VERSION ?= "9.2.4-1PGDG.rhel6";
variable POSTGRES_PKG_VERSION ?= "92";

"/software/packages"=pkg_repl(format("postgresql%s*", POSTGRES_PKG_VERSION),POSTGRES_VERSION,PKG_ARCH_POSTGRES);


"/software/packages"={
    SELF[escape(format("postgresql%s-contrib", POSTGRES_PKG_VERSION))] = nlist();
    SELF[escape(format("postgresql%s-devel", POSTGRES_PKG_VERSION))] = nlist();
    SELF[escape(format("postgresql%s-docs", POSTGRES_PKG_VERSION))] = nlist();
    SELF[escape(format("postgresql%s-libs", POSTGRES_PKG_VERSION))] = nlist();
    SELF[escape(format("postgresql%s-plperl", POSTGRES_PKG_VERSION))] = nlist();
    SELF[escape(format("postgresql%s-plpython", POSTGRES_PKG_VERSION))] = nlist();
    SELF[escape(format("postgresql%s-server", POSTGRES_PKG_VERSION))] = nlist();
    SELF[escape(format("postgresql%s-test", POSTGRES_PKG_VERSION))] = nlist();
    SELF;
    };


"/software/packages/{uuid}" = nlist();

variable OS_REPOSITORY_LIST = append("postgresql");
