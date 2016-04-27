unique template common/torque2/client/packages;

variable TORQUE_X_FORWARDING ?= true;

include 'common/torque2/packages';

prefix '/software/packages';
"{torque-client}" = dict();
