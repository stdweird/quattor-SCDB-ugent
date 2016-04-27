unique template common/logging/service;

variable GPFS_FILEBEAT ?= true;

include 'site/monitoring/logs/receiver';
include if_exists('site/backup');
