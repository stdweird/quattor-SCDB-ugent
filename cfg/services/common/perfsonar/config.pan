# This templates is based on reference-platform.ks used by standard NetInstall for
# perfSONAR-PS. Standard configuration modules are used as much as possible but
# some actions are implemented in a script installed by filecopy (configured
# by postconfig.tpl).

unique template common/perfsonar/config;

variable PERFSONAR_USER ?= 'perfsonar';
variable PERFSONAR_GROUP ?= 'perfsonar';
variable PERFSONAR_OWAMP_BWCTL_LOG ?= '/var/log/perfsonar/owamp_bwctl.log';
final variable PERFSONAR_BUOY_HOST ?= false;
final variable PERFSONAR_BUOY_COLLECTOR ?= false;

# Add RPMs
#include { 'rpms/perfsonar' };
include 'components/chkconfig/config';
include 'components/altlogrotate/config';
# ----------------------------------------------------------------------------
# Stop unwanted services
# ----------------------------------------------------------------------------

variable PERSFSONAR_UNWANTED_SERVICES ?= list('cups',
                                              'gpm',
                                              'portmap',
                                              'iptables',
                                              'ip6tables',
                                              'irqbalance',
                                              'bluetooth',
                                              'haldaemon',
                                              'cpuspeed',
                                              'pcscd',
                                              'nfslock',
                                              'ypbind',
                                              'mdmonitor',
                                              'rpcidmapd',
                                              'rpcgssd',
                                              'netfs',
                                              'yum-updatesd',
                                              'avahi-dnsconfd',
                                              'psacct',
                                              'nfs',
                                              'irda',
                                              'rpcsvcgssd',
                                              'mdmpd',
                                              'readahead_later',
                                              'readahead_early',
                                              'kudzu',
                                              'apmd',
                                              'hidd',
                                              'avahi-daemon',
                                              'firstboot',
                                             );


'/software/components/chkconfig/service' = {
  foreach (i;service;PERSFSONAR_UNWANTED_SERVICES) {
    SELF[service] = dict('off', '',
                          'startstop', true,
                         );
  };
  SELF;
};


# ----------------------------------------------------------------------------
# Stop unwanted services
# ----------------------------------------------------------------------------

variable PERSFSONAR_WANTED_SERVICES ?= list('sshd');
include if_exists("site/perfsonar");
'/software/components/chkconfig/service' = {
  foreach (i;service;PERSFSONAR_WANTED_SERVICES) {
    SELF[service] = dict('on', '',
                          'startstop', true,
                         );
  };
  SELF;
};


# ----------------------------------------------------------------------------
# Better tune the TCP defaults
# ----------------------------------------------------------------------------

include 'common/sysctl/service';

prefix "/software/components/metaconfig/services/{/etc/sysctl.conf}/contents";

# increase TCP max buffer size setable using setsockopt()
# 16 MB with a few parallel streams is recommended for most 10G paths
# 32 MB might be needed for some very long end-to-end 10G or 40G paths
'net.core.rmem_max' = '33554432';
'net.core.wmem_max' = '33554432';
# increase Linux autotuning TCP buffer limits
# min, default, and max number of bytes to use
# (only change the 3rd value, and make it 16 MB or more)
'net.ipv4.tcp_rmem' = '4096 87380 16777216';
'net.ipv4.tcp_wmem' = '4096 65536 16777216';
# recommended to increase this for 10G NICS
'net.core.netdev_max_backlog' = '30000';
# don't cache ssthresh from previous connection
'net.ipv4.tcp_no_metrics_save' = '1';
# Explicitly set htcp as the congestion control
'net.ipv4.tcp_congestion_control' = 'htcp';


# ----------------------------------------------------------------------------
# altlogrotate
# ----------------------------------------------------------------------------

variable CONTENTS = <<EOF;
/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
/bin/kill -HUP `cat /var/run/rsyslogd.pid 2> /dev/null` 2> /dev/null || true
EOF

"/software/components/altlogrotate/entries/owamp-logs" =
  dict("pattern", PERFSONAR_OWAMP_BWCTL_LOG,
        "compress", true,
        "missingok", true,
        "frequency", "weekly",
        "create", true,
        "ifempty", true,
        "rotate", 1,
        "sharedscripts", true,
        "scripts", dict('postrotate', CONTENTS),
        "createparams", dict('owner',PERFSONAR_USER,
                              'group',PERFSONAR_GROUP,
                              'mode', '0644'),
       );



# ----------------------------------------------------------------------------
# Install a few login scripts to add required path
# ----------------------------------------------------------------------------

variable PERFSONAR_PATHMUNGE_CONTENTS = <<EOF;
pathmunge () {
        if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
           if [ "$2" = "after" ] ; then
              PATH=$PATH:$1
           else
              PATH=$1:$PATH
           fi
        fi
}

EOF

variable PERFSONAR_LOGIN_SCRIPTS = dict(escape('/etc/profile.d/add_dbxml_dir.sh'), list('/usr/dbxml-2.3.11/bin'),
                                         escape('/etc/profile.d/add_toolkit_dirs.sh'), list('/opt/perfsonar_ps/toolkit/scripts'),
                                         escape('/etc/profile.d/add_sbin_dirs.sh'), list('/sbin','/usr/sbin','/usr/local/sbin'),
                                        );

'/software/components/filecopy/services' = {
  foreach (script;pathlist;PERFSONAR_LOGIN_SCRIPTS) {
    contents = PERFSONAR_PATHMUNGE_CONTENTS;
    foreach (i;path;pathlist) {
      contents = contents + 'pathmunge "' + path + '"' + "\n";
    };
    SELF[escape(script)] = dict('config', contents,
                                 'perms', '0644',
                                 'owner', 'root'
                                );
  };
  SELF;
};


# ----------------------------------------------------------------------------
# Disable the HTTP TRACE methods
# ----------------------------------------------------------------------------

variable CONTENTS = <<EOF;
# Disables the HTTP TRACE method
TraceEnable      Off
EOF


'/software/components/filecopy/services' = {
  SELF[escape('/etc/httpd/conf.d/disable_trace.conf')] = dict('config', CONTENTS);
  SELF;
};


# ----------------------------------------------------------------------------
# Hack: use a script for all the actions difficult to implement with
# Quattor configuration modules
# ----------------------------------------------------------------------------
#include { 'common/perfsonar/postconfig' };
include 'common/perfsonar/bwctl/service';
include 'common/perfsonar/owamp/service';
include { if (PERFSONAR_BUOY_HOST) {
	'common/perfsonar/buoy/service';
    };
};

include { if (exists("/software/components/icinga")) {
    "common/perfsonar/monitoring/icinga";
     };
};
include 'repository/config/perfsonar';
include 'common/nagios/checks/perfsonar';
"/software/components/accounts/users/perfsonar" = dict("uid", 493,
    "comment", "PerfSONAR account",
    "homeDir", "/var/lib/perfsonar",
    "createHome", false,
    "shell", "/sbin/nologin",
    "groups", list("perfsonar"));
"/software/components/accounts/groups/perfsonar/gid" = 503;
"/software/components/metaconfig/dependencies/pre" = append("accounts");
