unique template common/django/postgresql;

## setup a postgresql backend for django

include 'common/postgresql/service';

"/software/components/postgresql/roles" = npush(
    DJANGO_DB_USER, format("LOGIN CREATEDB NOSUPERUSER NOCREATEROLE ENCRYPTED PASSWORD '%s'", DJANGO_DB_PASSWORD),
);

"/software/components/postgresql/databases/" = npush(
    DJANGO_DB_DB,dict("user", DJANGO_DB_USER)
);

variable DJANGO_HBA = list(
    dict("host", "local",
          "database", list(DJANGO_DB_DB),
          "user", list(DJANGO_DB_USER),
          "method", "password"),
    dict("host","host",
          "database",list(DJANGO_DB_DB),
          "user",list(DJANGO_DB_USER),
          "address","127.0.0.1/32",
          "method","password"),
);

"/software/components/postgresql/config/hba" = {
    temp = DJANGO_HBA;
    foreach (k;v;SELF) {
        temp[length(temp)] = v;
    };
    temp;
};
