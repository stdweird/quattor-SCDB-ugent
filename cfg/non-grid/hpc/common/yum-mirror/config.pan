unique template common/yum-mirror/config;

variable UPSTREAM_REPOS_TEMPLATE ?= error("Template with upstream repositories must be defined by now");

@{
    Contains all the repositories in a yum_mirror_repo structure.
}

include 'components/metaconfig/config';
include 'common/yum-mirror/schema';

prefix "/software/components/metaconfig/services/{/etc/reposnap.conf}";

"module" = "tiny";
"mode" = 0644;
"owner" = "root";

"contents/YUM_CONFIG" ="/etc/yum.reposnap";
"contents/REPO_PACKAGE_DIR" ="/var/www/packages/public";
"contents/SNAPSHOT_PKG" ="";

prefix "/software/components/metaconfig/services/{/etc/yum.reposnap}";

"module" = "tiny";
"mode" = 0644;
"owner" = "root";

"contents/main/reposdir" = "/etc/reposnap.repos.d";
"contents/main/exclude" = "nexuiz* root-* naev-* wesnoth* xrootd* asterisk*";

prefix "/software/components/metaconfig/services/{/etc/reposnap.repos.d/repositories.repo}";

"module" = "tiny";

"mode" = 0644;
"owner" = "root";

"contents" = create(UPSTREAM_REPOS_TEMPLATE);
