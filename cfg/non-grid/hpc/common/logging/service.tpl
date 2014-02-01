unique template common/logging/service;

include {'site/monitoring/logs/receiver'};

include {if_exists('site/backup')};
