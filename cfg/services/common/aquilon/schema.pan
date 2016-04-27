declaration template common/aquilon/schema;

type aquilon_database_section = {
    "server" : string
    "dbuser" : string = "%(user)s"
    "password_base" ? string
    "password_file" ? string
    "module" ? string
    "dsn" ? string
    "environment" : string = "prod"
};

type aquilon_database_sqlite = {
    "dbfile" : string
    "dsn" : type_absoluteURI = "sqlite:///%(dbfile)s"
};

type aquilon_protocols = {
    "directory" : string
};

type aquilon_broker = {
    "default_organization" : string
    "mode" : string = "readwrite" with match(SELF, "^read(only|write)$")
    "kcnport" : type_port = 6900
    "openport" : type_port = 6901
    "git_port" : type_port = 9418
    "bind_address" ? type_ip
    "cdp_send_port" ? type_port
    "git_templates_url" ? type_absoluteURI
    "git_daemon_basedir" : string = "%(basedir)s"
    "run_git_daemon" : boolean = false
    "gzip_level" : long(1..9) = 9
    "git_templates_url" : type_absoluteURI = "git://%(servername)s:%(git_port)s/quattor/template-king"
    "git_daemon_basedir" : string = "%(basedir)s"
    "run_git_daemon" : boolean = false
    "builddir" : string = "%(quattordir)s/cfg"
    "compiletooldir" : string = "%(srcdir)s/etc"
    "kingdir" : string = "%(quattordir)s/template-king"
    "templatesdir" : string = "%(quattordir)s/templates"
    "domainsdir" : string = "%(quattordir)s/domains"
    "rundir" : string = "%(quattordir)s/run"
    "sockdir" : string = "%(rundir)s/sockets"
    "logdir" : string = "%(quattordir)s/logs"
    "logfile" : string = "%(logdir)s/aqd.log"
    "http_access_log" : string = "%(logdir)s/aqd_access.log"
    "profilesdir" : string = "%(quattordir)s/web/htdocs/profiles"
    "plenarydir" : string = "%(quattordir)s/cfg/plenary"
    "swrepdir" : string = "%(quattordir)s/swrep"
    "git_base_dir" : string = "/usr"
    "git_path" : string = "%(git_base_dir)s/bin"
    "git_daemon" : string = "%(git_base_dir)s/libexec/git-core/git-daemon"
    "git_author_name" ? string
    "git_author_email" ? string
    "git_committer_name" ? string
    "git_committer_email" ? string
    "dsdb" ? string
    "dsdb_location_sync" : boolean = true
    "dsdb_use_testdb" : boolean = false
    "java_home" ? string
    "ant_home" ? string
    "ant" : string = "%(ant_home)s/bin/ant"
    "ant_options" ? string
    "ant_contrib_jar" ? string
    "service" : string = "%(user)s"
    "keytab" : string = "/var/spool/keytabs/%(service)s"
    "installfe" ? string
    "installfe_user" : string = "%(user)s"
    "installfe_sshdir" ? string
    "server_notifications" ? string
    "client_notifications" : boolean = true
    "CheckNet" ? string
    "CheckNet_module" ? string
    "sharedata" ? string
    "default_domain_start" : string = "prod"
    "authorization_error" : string = "Please contact an administrator for access."
    "namespaced_host_profiles" : boolean = false
    "flat_host_profiles" : boolean = true
    "windows_host_info" ? string
# See comments in aquilon.worker.resources.set_thread_pool_size
    "twisted_thread_pool_size" : long = 100
    "vlan2net" ? string
# The knc daemon can be run by the broker for development purposes.
# Will default to True until we migrate to a new configuration in prod.
    "run_knc" : boolean = true
    "mean" ? string
    "qip_dump_subnetdata" ? string
# Default and maximum numbers of audit (xtn table) rows returned by search audit
    "default_audit_rows" : long = 5000
    "max_audit_rows" : long = 20000
    "poll_helper_service" : string = "poll_helper"
    "poll_ssh" ? string
    "poll_ssh_options" ? string
    "grn_to_eonid_map_location" ? string
    "switch_discover" ? string
    "get_camtable" ? string
    "default_max_list_size" ? long = 1000
    "reconfigure_max_list_size" ? long(0..)
    "pxeswitch_max_list_size" ? long(0..)
    "manage_max_list_size" ? long(0..)
    "reset_advertised_status_max_list_size" ? long(0..)
    "map_grn_max_list_size" ? long(0..)
    "unmap_grn_max_list_size" ? long(0..)
    "umask" ? long
};

type aquilon_database = {
    "database_section" : string with exists("/software/components/metaconfig/services/{/etc/aqd.conf}/contents/" + SELF)
};

type aquilon_defaults = {
    "basedir" : string = "/var"
    "quattordir" : string = "%(basedir)s/quattor"
    "logdir" : string = "%(quattordir)s/logs"
    "dbdir" : string = "%(quattordir)s/aquilondb"
    "dblogfile" : string = "%(logdir)s/aqdb.log"
};

type aquilon_kerberos = {
    "krb5_keytab" : string
    "knc" : string
    "klist" : string
};

type aquilon_panc = {
    "default_version" : string = "prod"
    "version" : string = "%(default_version)s"
    "pan_compiler" : string
    "batch_size" : long = 1000
    "formatter" ? string
    "gzip_output" ? boolean  = false
    "transparent_gzip" ? boolean
    "template_extension" ? string
    "xml_profiles" : boolean = true
    "json_profiles" : boolean = false
};

type aquilon_network_section = {
    "default_gateway_offset" : long(0..255) = 1
    "reserved_offsets" ? string with match(SELF,'^(\d+|-1)(,(?:\d+|-1))*$')
    "first_usable_offset" ? long(0..255)
    "may_span_buildings" ? boolean
};

type aquilon = {
    "database_postgresql" ? aquilon_database_section
    "database_oracle" ? aquilon_database_section
    "database_sqlite" ? aquilon_database_sqlite
    "database" : aquilon_database
    "protocols" : aquilon_protocols
    "kerberos" ? aquilon_kerberos
    "broker" ? aquilon_broker
    "panc" ? aquilon_panc
    "DEFAULT" : aquilon_defaults = dict()
    "network_unknown" ? aquilon_network_section
    "network_ugent16" ? aquilon_network_section
};

bind "/software/components/metaconfig/services/{/etc/aqd.conf}/contents" = aquilon;
