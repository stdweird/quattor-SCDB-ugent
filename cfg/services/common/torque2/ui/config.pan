unique template common/torque2/ui/config;

include  {  if (match(TORQUE_RPM_VERSION,'^[4-9]\.')){ 'common/torque2/trqauthd' } };

include 'common/torque2/torque_cfg';
