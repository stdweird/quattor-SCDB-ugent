structure template repository/epel;

include 'repository/basic';

"name" = "epel";
"protocols/0/url" = url_for_repo(format("epel_el%s", RPM_BASE_FLAVOUR_VERSIONID));

"excludepkgs" = append("nagios-plugins");
