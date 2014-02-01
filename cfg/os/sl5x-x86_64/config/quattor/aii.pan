# This template acts as a wrapper to define some AII related variable
# from current configuration, in particular OS version.
#
# This template is not really OS version dependent but having it in the
# OS templates is easier in case some particular tweakening is required
# for an OS version.

template config/quattor/aii;

## disable
variable AII_OSINSTALL_OPTION_LANG_SUPP = list("none");
variable AII_OSINSTALL_OPTION_ZEROMBR_ARGS = list('');
variable AII_OSINSTALL_NEEDS_SECTION_END = true;

# Include base configuration for AII

include { 'quattor/aii/config' };

"/system/aii/osinstall/ks/mouse" = null;

"/system/aii/osinstall/ks/base_packages" = list(
    "perl-LC",
    "perl-IO-String",
    "perl-CAF",
    "perl-parent",
    "perl-common-sense",
    "perl-CDB_File",
    "perl-GSSAPI",
    "perl-JSON-XS",
    "ccm",
    "perl-Pod-POM",
    "perl-Template-Toolkit",
    "ncm-ncd",
    "ncm-query",
    "ncm-spma",
    "cdp-listend",
    "ncm-cdispd",
    "cabundle-hpcugent",
);

"/system/aii/osinstall/ks/packages_args" = list("--ignoremissing");

"/system/aii/osinstall/ks/end_script" = "%end";

"/system/aii/osinstall/ks/packages" = append("python-elementtree");

"/system/aii/osinstall/ks/disabled_repos" = list("*priv*", "*gpfs*");
