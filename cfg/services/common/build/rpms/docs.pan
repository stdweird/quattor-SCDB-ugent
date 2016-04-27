unique template common/build/rpms/docs;

prefix "/software/packages";
"{doxygen}" = dict();
"{tetex-dvips}" = dict();
"{tetex-latex}" = dict();
"{texlive}" = dict();

include {if (RPM_BASE_FLAVOUR_NAME == 'el7') {'common/build/rpms/texlive'}};
