@{
    Machine type for burning tests.

    It will contain and enable a lot of
}

unique template machine-types/burning;

variable FILESYSTEM_LAYOUT_CONFIG_SITE = 'site/filesystems/burning';

include { 'machine-types/core' };

include { 'common/burning/service' };
#
# updates
#
include { 'update/config' };
