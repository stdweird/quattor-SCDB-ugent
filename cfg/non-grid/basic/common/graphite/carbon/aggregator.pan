unique template common/graphite/carbon/aggregator;

"/software/components/metaconfig/services/{/etc/carbon/carbon.conf}/daemon" = append("carbon-aggregator");

bind "/software/components/metaconfig/services/{/etc/carbon/aggregation-rules.conf}/contents" = carbon_aggregator_aggregation_rules;

prefix "/software/components/metaconfig/services/{/etc/carbon/aggregation-rules.conf}";
#"daemon/0" = "carbon-aggregator"; # picked-up when changed
"module" = "graphite/aggregation-rules";
"mode" = 0644;

prefix "/software/components/metaconfig/services/{/etc/carbon/aggregation-rules.conf}/contents";
"main/0" = nlist(
    "output", "<env>.applications.<app>.all.requests",
    "frequency", "60",
    "method", "avg",
    "input", "<env>.applications.<app>.*.requests"
);

