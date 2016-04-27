unique template common/build/clusterbuildrpm;

include 'components/metaconfig/config';

include 'common/build/schema';

"/software/components/metaconfig/services/{/etc/buildrpm.conf}/module" = "tiny";

prefix "/software/components/metaconfig/services/{/etc/buildrpm.conf}/contents";

"public/destination" = "geodude";
"public/yum_repo" = format("public/homemade-%s", RPM_BASE_FLAVOUR_NAME);
"public/host" = "github.com";

"private/destination" = "geodude";
"private/yum_repo" = format("restricted/homemade-private-%s", RPM_BASE_FLAVOUR_NAME);
"private/host" = "github.ugent.be";

"public_testing/destination" = "geodude";
"public_testing/yum_repo" = format("public/homemade-testing-%s", RPM_BASE_FLAVOUR_NAME);
"public_testing/host" = "github.com";

"private_testing/destination" = "geodude";
"private_testing/yum_repo" = format("restricted/homemade-private-testing-%s", RPM_BASE_FLAVOUR_NAME);
"private_testing/host" = "github.ugent.be";

"savannahpublic/destination" = "geodude";
"savannahpublic/yum_repo" = format("public/homemade-%s", RPM_BASE_FLAVOUR_NAME);
"savannahpublic/host" = "savannah.ugent.be";

"savannahprivate/destination" = "geodude";
"savannahprivate/yum_repo" = format("restricted/homemade-private-%s", RPM_BASE_FLAVOUR_NAME);
"savannahprivate/host" = "savannah.ugent.be";

"fedorapkgs/destination" = "geodude";
"fedorapkgs/yum_repo" = format("public/fedora-rebuild-%s", RPM_BASE_FLAVOUR_NAME);
"fedorapkgs/host" = "fedorapkgs";

"centosrpms/destination" = "geodude";
"centosrpms/yum_repo" = format("public/centos-rebuild-%s", RPM_BASE_FLAVOUR_NAME);
"centosrpms/host" = "centosrpms";

"build/repo_flags" = {
    if (RPM_BASE_FLAVOUR_NAME == 'el5') {
        "-s md5";
    } else {
        "";
    }
};

prefix "/software/packages";
"{clusterbuildrpm-server}" = dict();
"{fedpkg}" = dict();
