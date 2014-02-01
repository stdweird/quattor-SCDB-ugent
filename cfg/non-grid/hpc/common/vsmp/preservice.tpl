unique template common/vsmp/preservice;

variable VSMP_SCALEMP ?= true;
include { if(VSMP_SCALEMP) { 'common/vsmp/scalemp/service'} };

final variable VSMP_PRESERVICE = true;
