unique template common/build/service;

include 'common/build/packages';

include 'common/build/clusterbuildrpm';

include {if (RPM_BASE_FLAVOUR_NAME == 'el6') {'common/build/mock'}};