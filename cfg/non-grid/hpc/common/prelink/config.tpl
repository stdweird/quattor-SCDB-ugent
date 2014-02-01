unique template common/prelink/config;

variable PRELINK ?= "yes";
variable PRELINK_OPTS ?= {
    if (is_defined(USE_BLCR) && USE_BLCR) {
        return("-m");
    } else {
        return("-mR");
    };
};

variable CONTENTS = "PRELINKING="+PRELINK+"\n"+
    "PRELINK_OPTS="+PRELINK_OPTS+"\n"+
    "PRELINK_FULL_TIME_INTERVAL=14\n"+
    "PRELINK_NONRPM_CHECK_INTERVAL=7\n";

include {'components/filecopy/config'};
## restart what? is ran through cron.daily
'/software/components/filecopy/services' =
  npush(escape("/etc/sysconfig/prelink"),
        nlist('config',CONTENTS,
              'owner','root:root',
              'perms', '0644',
              ));



## example file with explanations
## not really used
variable CONTENTS = <<EOF;
# Set this to no to disable prelinking altogether
# (if you change this from yes to no prelink -ua
# will be run next night to undo prelinking)
PRELINKING=yes

# Options to pass to prelink
# -m    Try to conserve virtual memory by allowing overlapping
#       assigned virtual memory slots for libraries which
#       never appear together in one binary
# -R    Randomize virtual memory slot assignments for libraries.
#       This makes it slightly harder for various buffer overflow
#       attacks, since library addresses will be different on each
#       host using -R.
#PRELINK_OPTS=-mR
## SDW disable the randomness. it messes with BLCR
PRELINK_OPTS=-m

# How often should full prelink be run (in days)
# Normally, prelink will be run in quick mode, every
# $PRELINK_FULL_TIME_INTERVAL days it will be run
# in normal mode.  Comment it out if it should be run
# in normal mode always.
PRELINK_FULL_TIME_INTERVAL=14

# How often should prelink run (in days) even if
# no packages have been upgraded via rpm.
# If $PRELINK_FULL_TIME_INTERVAL days have not elapsed
# yet since last normal mode prelinking, last
# quick mode prelinking happened less than
# $PRELINK_NONRPM_CHECK_INTERVAL days ago
# and no packages have been upgraded by rpm
# since last quick mode prelinking, prelink
# will not do anything.
# Change to
# PRELINK_NONRPM_CHECK_INTERVAL=0
# if you want to disable the rpm database timestamp
# check (especially if you don't use rpm/up2date/yum/apt-rpm
# exclusively to upgrade system libraries and/or binaries).
PRELINK_NONRPM_CHECK_INTERVAL=7
EOF