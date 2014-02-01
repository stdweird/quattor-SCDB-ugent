unique template common/ofed/driver;

# mlx4

variable MLX4_LOG_NUM_MTT ?= undef;
variable CONTENTS = '';
variable CONTENTS = { if(is_defined(MLX4_LOG_NUM_MTT)) {format("%soptions mlx4_core log_num_mtt=%s\n",CONTENTS, MLX4_LOG_NUM_MTT)} else {SELF}};

'/software/components/filecopy/services' =
  npush(escape("/etc/modprobe.d/quattor_mlx4.conf"),
        nlist('config',CONTENTS,
              'owner','root:root',
              'perms', '0744',
              'backup',false));


# qlogic driver
variable QIB_SINGLEPORT ?= 1;
variable QIB_KRCVQS ?= -1;
variable QIB_RCVHDRCNT ?= 4096;
variable QIB_PCIECAPS ?= '0x51';
variable QIB_NUMA_AWARE ?= 1;

variable QIB_KRCVQS_TXT ?= { if(QIB_KRCVQS >=0) { format("krcvqs=%s",QIB_KRCVQS); } else {''}};

## no tuning needed?
# numa_aware=%s , QIB_NUMA_AWARE : not in standard ofed drivers (yet)
variable CONTENTS = format("options ib_qib singleport=%s %s rcvhdrcnt=%s pcie_caps=%s\n",
                            QIB_SINGLEPORT,QIB_KRCVQS_TXT,QIB_RCVHDRCNT,QIB_PCIECAPS);

# Now actually add the file to the configuration.
# No backups for modprobe config files
'/software/components/filecopy/services' =
  npush(escape("/etc/modprobe.d/ib_qib.conf"),
        nlist('config',CONTENTS,
              'owner','root:root',
              'perms', '0744',
              'backup',false));
