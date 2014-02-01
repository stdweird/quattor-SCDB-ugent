unique template common/quattor-proxy/service;

include {'common/nginx/service'};

include {'common/quattor-proxy/pkgs'};
include 'common/quattor-proxy/restricted-pkgs';
include {'common/quattor-proxy/profiles'};
include {'common/quattor-proxy/secure'};
include 'components/dirperm/config';
