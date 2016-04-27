structure template common/quattor-proxy/pkg-cache;

include 'common/nginx/cache/location';

"cache/valid/0/period" = 60*24;
# I feel like I'm repeating myself
"cache/cache" = "cache";
