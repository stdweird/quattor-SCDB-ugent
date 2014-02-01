unique template common/aquilon/packages;

prefix "/software/packages";

# Deps of aquilon itself
"{git-daemon}" = nlist();
"{aquilon-protocols}" = nlist();
"{ant-contrib}" = nlist();
"{PyYAML}" = nlist();
"{zip}" = nlist();

# Deps of aquilon-protocols
"{protobuf-python}" = nlist();
"{protobuf}" = nlist();

"{java-1.6.0-openjdk}" = nlist();

"{python-psycopg2}" = nlist();
"{aquilon}" = nlist();
"{knc}" = nlist();
"{panc}" = nlist();
"{aquilon-build-xml}" = nlist();
"{aquilon-profile}" = nlist();
