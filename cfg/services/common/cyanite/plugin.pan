unique template common/cyanite/plugin;

prefix '/software/packages';
"graphite-cyanite" = dict(); 

include 'metaconfig/django/graphite-web';

variable CYANITE_URLS ?= list('http://localhost:8080');

prefix "/software/components/metaconfig/services/{/opt/graphite/webapp/graphite/local_settings.py}/contents/config";

"storage_finders" = list('cyanite.CyaniteFinder');
"cyanite_urls" = CYANITE_URLS;
