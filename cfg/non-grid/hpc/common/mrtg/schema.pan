unique template common/mrtg/schema;

type mrtg_file = {
    "HtmlDir" : string
    "ImageDir" : string
    "LogFormat" : string
    "LogDir" : string
    "ThreshDir" : string
    "WorkDir" : string
    "LibAdd" : string
};

bind "/software/components/metaconfig/services/{/etc/mrtg/mrtg.cfg}/contents" = mrtg_file;
