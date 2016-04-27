@{
    Describes an nginx instance used as a caching proxy
}
structure template common/nginx/cache/base;

"proxy_cache_path/0/path" = "/var/cache/nginx/cache";
"proxy_cache_path/0/keys_zone/cache" = 1000;
"proxy_cache_path/0/max_size" = NGINX_CACHE_SIZE;
"proxy_cache_path/0/inactive" = 60*24;
