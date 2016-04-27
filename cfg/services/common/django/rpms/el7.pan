unique template common/django/rpms/el7;

# el7 versions from fedora rebuild
variable OS_REPOSITORY_LIST = append("fedora-rebuild");

'/software/packages' = pkg_repl("python-django*", "1.8.4-*", "noarch");
'/software/packages' = pkg_repl("python-django-extensions", "1.3.7-*", "noarch");
'/software/packages' = pkg_repl("Django-Select2", "4.3.2-*", "noarch");
'/software/packages' = pkg_repl("djangorestframework", "2.3.10-*", "noarch");
'/software/packages' = pkg_repl("django-oauth-toolkit", "0.7.1-*", "noarch");
'/software/packages' = pkg_repl("django-rest-framework-docs", "0.1.7-*", "noarch");
'/software/packages' = pkg_repl("django-easy-select2", "1.3.1-*", "noarch");
'/software/packages' = pkg_repl("django-model-utils", "2.4a2-*", "noarch");
'/software/packages' = pkg_repl("django-widget-tweaks", "1.4.1-*", "noarch");
'/software/packages' = pkg_repl("django-activelink", "0.4-*", "noarch");
'/software/packages' = pkg_repl("django-simple-history", "1.6.3-*", "noarch");
'/software/packages' = pkg_repl("django-braces", "1.8.0-*", "noarch");
'/software/packages' = pkg_repl("django-wayf", "0.1", "noarch");
