unique template common/ptpd/service;

include "common/ptpd/packages";

variable IS_PTP_SERVER ?= false;

variable PTPD_SERVICE_NAME = format("ptpd%s",2);

variable PTP_SYSCONFIG = format("/etc/sysconfig/%s",PTPD_SERVICE_NAME);

variable PTP_INTERFACE ?= boot_nic();

variable PTP_DOMAIN_NUMBER ?= 1;


variable PTP_ANNOUNCE_INTERVAL = 3;
variable PTP_SYNC_INTERVAL = 3;
variable PTP_LOGFILE = '/var/log/ptpd2.log';
variable PTP_QUALITYFILE = '/var/log/ptpd2_sync.log';
variable PTP_DELAYFILTER = 10000;
variable PTP_STATISTICS ?= false; # rather verbose and big logs

"/software/components/sysconfig/files" = {
    if(IS_PTP_SERVER) {
        ptpmode="-G"; # -G expects/can use ntpd, else use -W
    } else {
        ptpmode="-g";
    };
    prologopts=format("-n %s -y %s -b %s -R %s -f %s -L -V 10 -i %s -w %s",
                     PTP_ANNOUNCE_INTERVAL,PTP_SYNC_INTERVAL,
                     PTP_INTERFACE,PTP_QUALITYFILE,PTP_LOGFILE,
                     PTP_DOMAIN_NUMBER,
                     PTP_DELAYFILTER,
                     );
    statstxt='';
    if (PTP_STATISTICS) {
        statstxt=' -D';
    };
    SELF[PTPD_SERVICE_NAME] = nlist("PTPDARGS",format('"%s %s%s"',ptpmode,prologopts,statstxt));
    SELF;
};

# chkconfig
include { 'components/chkconfig/config' };
"/software/components/chkconfig/service" = {
    SELF[PTPD_SERVICE_NAME] = nlist("on","","startstop", true);
    SELF;
};

# logrotate
include { 'components/altlogrotate/config' };

prefix "/software/components/altlogrotate/entries";
"ptpdlog" = nlist(
    "pattern", PTP_LOGFILE,
    "compress", true,
    "missingok", true,
    "frequency", "daily",
    "create", true,
    "ifempty", true,
    "rotate", 7,
    "olddir", "ptpd",
    "scripts", nlist(
        "postrotate",format("/etc/init.d/%s restart 2> /dev/null",PTPD_SERVICE_NAME)),
    );

"ptpdquality" = nlist(
    "pattern", PTP_QUALITYFILE,
    "compress", true,
    "missingok", true,
    "frequency", "weekly",
    "create", true,
    "ifempty", true,
    "rotate", 7,
    "olddir", "ptpd",
    "scripts", nlist(
        "postrotate",format("/etc/init.d/%s restart 2> /dev/null",PTPD_SERVICE_NAME)),
    );

"/software/components/dirperm/paths" = append(nlist(
    "path", "/var/log/ptpd",
    "owner", "root:root",
    "perm", "0755",
    "type", "d"
    ));
