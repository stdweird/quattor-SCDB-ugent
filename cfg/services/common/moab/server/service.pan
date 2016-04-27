unique template common/moab/server/service;

# Moab server configuration

include 'common/moab/server/variables';

# from 7.X, use rpms
include {
    if (MOAB_RPMS_HOMEMADE) {
        'common/moab/server/rpms/packages';
    } else if (MOAB_RPMS_OFFICIAL) {
        'common/moab/server/rpms/official';
    };
};

# include this before moab/server/config to reset GOLD_SERVER
variable USE_GOLDPROXY ?= false;
include { if(USE_GOLDPROXY) {return('common/goldproxy/service');}};

include 'common/moab/server/config';

include 'components/etcservices/config';
"/software/components/etcservices/entries" =
  push("moab 15004/tcp");

include 'components/chkconfig/config';
"/software/components/chkconfig/service/moab" = dict("on", "", "startstop", true);
include { if (RPM_BASE_FLAVOUR_VERSIONID >= 7) {'common/moab/server/unit'}};

include 'components/ldconf/config';
"/software/components/ldconf/paths" = {
    if (! (MOAB_PATH == '/usr')) {
        append(SELF,MOAB_PATH+"/lib");
    };
};
include 'components/profile/config';
"/software/components/profile" = {
    # official rpms have moab.sh in profile.d
    if (!((MOAB_PATH == '/usr') || MOAB_RPMS_OFFICIAL) ) {
        if ( !exists(SELF['path']) || !is_defined(SELF['path']) ) {
            SELF['path'] = dict();
        };
        if ( !exists(SELF['path']['PATH']) || !is_defined(SELF['path']['PATH']) ) {
            SELF['path']['PATH'] = dict();
        };
        if ( !exists(SELF['path']['PATH']['append']) || !is_defined(SELF['path']['PATH']['append']) ) {
            SELF['path']['PATH']['append'] = list();
        };

        SELF['path']['PATH']['append']=append(SELF['path']['PATH']['append'],MOAB_PATH+"/bin"); ## init if empty
        SELF['path']['PATH']['append']=append(SELF['path']['PATH']['append'],MOAB_PATH+"/sbin");
    };

    if ( !exists(SELF['env']) || !is_defined(SELF['env']) ) {
        SELF['env'] = dict();
    };

    ## needed for v7
    SELF['env']['MOABHOMEDIR'] = MOAB_HOME;

    SELF;
};
include 'components/accounts/config';
"/software/components/accounts/groups/moab" =
  dict("gid", 498);



variable MOAB_USE_UTILS_MONITORING ?= true;
include {if(MOAB_USE_UTILS_MONITORING) {'common/moab/server/utils/monitoring'}};

## from 7.x use DB backend
include { if (MOAB_USES_DB) { 'common/moab/server/database' } };

variable BACKUP_DIRECTLY = false;
include if_exists('site/backup');
include 'common/moab/server/logstash';

variable MOAB_RELOCATE_HOME ?= false;
include {if(MOAB_RELOCATE_HOME) {'common/moab/server/relocate_home'}};

variable MOAB_DOWNLOAD_AUTH_KEY ?= false;
include 'common/download/service';
"/software/components/download/files" = {
    if (MOAB_DOWNLOAD_AUTH_KEY) {
        auth_path=format("%s/etc/.moab.key", MOAB_HOME);
        SELF[escape(auth_path)] = create("common/download/auth",
                          "href", "share/moab/auth.key",
                          "perm", "0600");
    };
    SELF;
};

"/system/licenses" = append(dict(
                "vendor", "Adaptive",
                "name", "Moab",
                "enddate", MOAB_SUPPORT_ENDDATE,
                ));
