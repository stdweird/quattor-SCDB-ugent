unique template common/bacula/config;

'/software/components/accounts/kept_users/bacula' = '';
'/software/components/accounts/kept_groups/tape' = '';

variable BACULA_SD ?= false;
variable BACULA_FD ?= false;
variable BACULA_DIRECTOR_PART ?= false;

include { 'common/bacula/schema' };

include {if(BACULA_SD) {'common/bacula/sd'}};
include {if(BACULA_FD) {'common/bacula/fd'}};
include {if(BACULA_DIRECTOR_PART) {'common/bacula/director_part'}};

variable OS_REPOSITORY_LIST = {
        append("bacula");
        append("systemsgroup");
};
