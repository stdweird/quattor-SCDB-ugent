unique template common/django/rpms/packages;

include {format("common/django/rpms/el%s", RPM_BASE_FLAVOUR_VERSIONID);};

prefix '/software/packages';

"{python-simplejson}" = dict();
"{python-six}" = dict();
"{pytz}" = dict();
"{python-oauthlib}" = dict();
"{python-django-secure}" = dict();
