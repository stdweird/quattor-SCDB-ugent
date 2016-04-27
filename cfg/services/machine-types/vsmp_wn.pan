unique template machine-types/vsmp_wn;

variable KERNEL_FIRMWARE_ARCH = "x86_64";
#variable FILESYSTEM_DEFAULT_FS_TYPE = 'xfs';
variable VSMPUSEOFED = false;
variable VSMPUSEKNEM = false;
final variable USE_CPUSPEED = false;
variable AII_DHCP_CONFIG = 'site/aii_no_dhcp';

include 'machine-types/wn';

include 'common/vsmp/service';
