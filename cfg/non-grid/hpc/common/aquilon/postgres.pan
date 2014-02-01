unique template common/aquilon/postgres;

include 'components/postgresql/config';
include 'common/postgresql/service';

"/software/components/postgresql/config/hba" = {
        prepend(nlist("database", list("aquilon"),
                      "host", "host",
                      "method", "trust",
                      "user", list("aquilon"),
                      "address", "127.0.0.1/32"));
};

"/software/components/postgresql/roles/aquilon" =
        "LOGIN NOCRERATEDB NOSUPERUSER NOCREATEROLE";

"/software/components/postgresql/databases/aquilon" = nlist(
        "user", "aquilon");
