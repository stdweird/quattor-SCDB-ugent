unique template common/ptpd/service;

include 'metaconfig/ptpd/config';

variable IS_PTP_SERVER ?= false;

include 'common/ptpd/packages';

"/software/components/chkconfig/service/ptpd2" = dict("on", "", "startstop", true);

variable PTP_INTERFACE ?= {
    intf = boot_nic();
    netw = value(format('/system/network/interfaces/%s', intf));
    # part of bond
    if (exists(netw['master'])) {
        intf = netw['master'];
    };
    # part of bridge
    if (exists(netw['bridge'])) {
        intf = netw['bridge'];
    };
    intf;
};

"/software/components/sysconfig/files/ptpd2" = dict(
    'PTPD_PID_FILE', '/var/run/ptpd2.lock',
    'PTPD_STATUS_FILE', '/var/run/ptpd2.status',
    'PTPD_CONFIG_FILE', '/etc/ptpd2.conf',
    'PTPD_EXTRA_OPTIONS', '',
);

prefix "/software/components/metaconfig/services/{/etc/ptpd2.conf}/contents/ptpengine";
'interface' = PTP_INTERFACE;
'domain' = 0;
'preset' = if (IS_PTP_SERVER) {'masterslave'} else {'slaveonly'};
'ip_mode' = 'multicast';
'use_libpcap' = false;
'panic_mode' = true;
'panic_mode_duration' = 10;
'sync_outlier_filter_enable' = true;
'delay_outlier_filter_enable' = true;
'calibration_delay' = 5;
'ip_dscp' = 46;

prefix "/software/components/metaconfig/services/{/etc/ptpd2.conf}/contents/global";
'statistics_update_interval' = 5;
'log_file' = '/var/log/ptpd2.log';
'log_file_max_size' = 5000;
'log_file_max_files' = 5;
'log_status' = true;
'cpuaffinity_cpucore' = 0;

prefix "/software/components/metaconfig/services/{/etc/ptpd2.conf}/contents/clock";
'drift_handling' = 'file';
'drift_file' = '/var/log/ptpd2_kernelclock.drift';
