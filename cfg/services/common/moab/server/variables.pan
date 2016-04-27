unique template common/moab/server/variables;

variable MOAB_RPM_VERSION ?= "0.0.0";  # '0.0.0' don't use rpm
variable MOAB_USES_DB ?= match(MOAB_RPM_VERSION, '^[7-9]\.');

variable MOAB_RPMS_HOMEMADE = match(MOAB_RPM_VERSION, '^7\.0\.');
variable MOAB_RPMS_OFFICIAL = match(MOAB_RPM_VERSION, '^(7\.[1-9]|[89]\.*)');

# path where moab is installed
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
