declaration template common/build/schema;

type cbrpm_repo = {
    "destination" : type_hostname
    "yum_repo" : string
    "host" : type_hostname
};

type cbrpm_flags = {
    "repo_flags" : string
};

type cbdpm_cfg = {
    "public" : cbrpm_repo
    "private" : cbrpm_repo
    "public_testing" : cbrpm_repo
    "private_testing" : cbrpm_repo
    "savannahpublic" : cbrpm_repo
    "savannahprivate" : cbrpm_repo
    "fedorapkgs" : cbrpm_repo
    "centosrpms" : cbrpm_repo
    "build" : cbrpm_flags
};

bind "/software/components/metaconfig/services/{/etc/buildrpm.conf}/contents" = cbdpm_cfg;
