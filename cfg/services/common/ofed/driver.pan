unique template common/ofed/driver;

# mlx4

variable MLX4_LOG_NUM_MTT ?= undef;
# use steering via ipoib
variable MLX4_LOG_NUM_MGM_ENTRY_SIZE ?= undef;
variable CONTENTS = '';
variable CONTENTS = {
    txt="";
    if(is_defined(MLX4_LOG_NUM_MTT) || is_defined(MLX4_LOG_NUM_MGM_ENTRY_SIZE)) {
        txt = "options mlx4_core";
        if(is_defined(MLX4_LOG_NUM_MTT)) {
            txt = format("%s log_num_mtt=%s", txt, MLX4_LOG_NUM_MTT);
        };
        if(is_defined(MLX4_LOG_NUM_MGM_ENTRY_SIZE)) {
            txt = format("%s log_num_mgm_entry_size=%s", txt, MLX4_LOG_NUM_MGM_ENTRY_SIZE);
        };
        txt = txt + "\n";
    };
    txt;
};

'/software/components/filecopy/services' =
  npush(escape("/etc/modprobe.d/quattor_mlx4.conf"),
        dict('config',CONTENTS,
              'owner','root:root',
              'perms', '0744',
              'backup',false));


# qlogic driver
variable QIB_SINGLEPORT ?= 1;
variable QIB_KRCVQS ?= -1;
variable QIB_RCVHDRCNT ?= 4096;
variable QIB_PCIECAPS ?= '0x51';
variable QIB_NUMA_AWARE ?= undef;

variable QIB_KRCVQS_TXT ?= { if(QIB_KRCVQS >=0) { format("krcvqs=%s",QIB_KRCVQS); } else {''}};

## no tuning needed?
variable CONTENTS = {
    moreopts='';
    if(is_defined(QIB_NUMA_AWARE)) {
        moreopts=moreopts+format(" numa_aware=%s", QIB_NUMA_AWARE);
    };
    txt=format("options ib_qib singleport=%s %s rcvhdrcnt=%s pcie_caps=%s%s\n",
                            QIB_SINGLEPORT,QIB_KRCVQS_TXT,QIB_RCVHDRCNT,QIB_PCIECAPS,moreopts);
    txt;
};

# Now actually add the file to the configuration.
# No backups for modprobe config files
'/software/components/filecopy/services' =
  npush(escape("/etc/modprobe.d/ib_qib.conf"),
        dict('config',CONTENTS,
              'owner','root:root',
              'perms', '0744',
              'backup',false));
