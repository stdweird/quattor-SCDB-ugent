
# Maui server configuration

unique template common/moab/server/service;

variable MOAB_RPM_VERSION ?= "0.0.0";  ## don't use rpm
variable MOAB_USES_DB ?= match(MOAB_RPM_VERSION, '^[7-9]\.');

variable MOAB_RPMS_HOMEMADE = match(MOAB_RPM_VERSION, '^7\.0\.');
variable MOAB_RPMS_OFFICIAL = match(MOAB_RPM_VERSION, '^(7\.[1-9]|[89]\.*)');

## from 7.X, use rpms
include { 
    if (MOAB_RPMS_HOMEMADE) {
        'common/moab/server/rpms/packages';
    } else if (MOAB_RPMS_OFFICIAL) {
        'common/moab/server/rpms/official';
    };
};

## path where moab is installed
variable MOAB_PATH ?=  {
    if (MOAB_RPMS_HOMEMADE) {
        "/usr";
    } else {
        "/opt/moab";
    };
};
variable MOAB_HOME ?= {
    if (MOAB_RPMS_HOMEMADE) {
        "/var/spool/moab";
    } else {
        "/opt/moab";
    };
};

## include this before moab/server/config to reset GOLD_SERVER
variable USE_GOLDPROXY ?= false;
include { if(USE_GOLDPROXY) {return('common/goldproxy/service');}};

include { 'common/moab/server/config' };

include { 'components/etcservices/config' };
"/software/components/etcservices/entries" =
  push("moab 15004/tcp");

include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/moab" = nlist("on", "", "startstop", true);

include { 'components/ldconf/config' };
"/software/components/ldconf/paths" = {
    if (! (MOAB_PATH == '/usr')) {
        append(SELF,MOAB_PATH+"/lib");
    };
};

include { 'components/profile/config' };
"/software/components/profile" = {
    # official rpms have moab.sh in profile.d
    if (!((MOAB_PATH == '/usr') || MOAB_RPMS_OFFICIAL) ) {
        if ( !exists(SELF['path']) || !is_defined(SELF['path']) ) {
            SELF['path'] = nlist();
        };
        if ( !exists(SELF['path']['PATH']) || !is_defined(SELF['path']['PATH']) ) {
            SELF['path']['PATH'] = nlist();
        };
        if ( !exists(SELF['path']['PATH']['append']) || !is_defined(SELF['path']['PATH']['append']) ) {
            SELF['path']['PATH']['append'] = list();
        };

        SELF['path']['PATH']['append']=append(SELF['path']['PATH']['append'],MOAB_PATH+"/bin"); ## init if empty
        SELF['path']['PATH']['append']=append(SELF['path']['PATH']['append'],MOAB_PATH+"/sbin");
    };

    if ( !exists(SELF['env']) || !is_defined(SELF['env']) ) {
        SELF['env'] = nlist();
    };

    ## needed for v7
    SELF['env']['MOABHOMEDIR'] = MOAB_HOME;

    SELF;
};

include { 'components/accounts/config' };
"/software/components/accounts/groups/moab" =
  nlist("gid", 498);



variable MOAB_USE_UTILS_MONITORING ?= true;
include {if(MOAB_USE_UTILS_MONITORING) {'common/moab/server/utils/monitoring'}};

## from 7.x use DB backend
include { if (MOAB_USES_DB) { 'common/moab/server/database' } };

include {if_exists('site/backup')};

include 'common/moab/server/logstash';

variable MOAB_RELOCATE_HOME ?= false;
include {if(MOAB_RELOCATE_HOME) {'common/moab/server/relocate_home'}};

variable MOAB_DOWNLOAD_AUTH_KEY ?= false;
include {'common/download/service'};
"/software/components/download/files" = {
    if (MOAB_DOWNLOAD_AUTH_KEY) {
        auth_path=format("%s/etc/.moab.key", MOAB_HOME);
        SELF[escape(auth_path)] = create("common/download/auth",
                          "href", "share/moab/auth.key",
                          "perm", "0600");
    };
    SELF;
};
