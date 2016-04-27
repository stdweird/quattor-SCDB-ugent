unique template common/django/rpms/el6;

'/software/packages' = pkg_repl("Django14", "1.4.13-1.el6", "noarch");
'/software/packages' = pkg_repl("django-reversion", "1.6.6-1", "noarch");
'/software/packages' = pkg_repl("python-django-extensions", "1.3.7-1.el6", "noarch");
'/software/packages' = pkg_repl("django-braces", "1.3.1-1", "noarch");
'/software/packages' = pkg_repl("Django-Select2", "4.2.2-1", "noarch");

prefix '/software/packages';
"{django-oauth-toolkit}" = dict();
"{django-easy-select2}" = dict();
"{django-rest-framework-docs}" = dict();
"{django-model-utils}" = dict();
"{django-widget-tweaks}" = dict();
"{django-activelink}" = dict();
"{django-simple-history}" = dict();
"{djangorestframework}" = dict();
"{python-django-south}" = dict();
