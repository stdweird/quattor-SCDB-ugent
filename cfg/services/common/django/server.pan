unique template common/django/server;

variable DJANGO_DATABASE ?= "postgresql";
variable DJANGO_DB_DB ?= 'django';
variable DJANGO_DB_USER ?= 'django';
variable DJANGO_DB_HOST ?= "localhost";
include 'common/django/'+DJANGO_DATABASE;
# Not sure if we should add this information to some config file that is readable by django
