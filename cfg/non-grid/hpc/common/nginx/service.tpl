unique template common/nginx/service;

variable NGINX_CACHE_SIZE ?= 20*GB;

include {'components/metaconfig/config'};
include {'common/nginx/config'};
include {'components/chkconfig/config'};

"/software/components/chkconfig/service/nginx" = nlist("on", "",
    "startstop", true);


"/software/packages/nginx" = nlist();
variable OS_REPOSITORY_LIST = append("nginx");
