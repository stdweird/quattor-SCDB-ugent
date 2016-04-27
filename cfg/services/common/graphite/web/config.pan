unique template common/graphite/web/config;

prefix "/software/packages";
"{graphite-web}" = dict();

include 'common/graphite/web/httpd';

include {if(GRAPHITE_WITH_CYANITE) {'common/cyanite/plugin'}};
