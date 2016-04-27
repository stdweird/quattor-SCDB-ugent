unique template common/graphite/service;

variable GRAPHITE_GRAPHITE_WEB ?= true;

variable GRAPHITE_CARBON_CACHE ?= false;
variable GRAPHITE_CARBON_RELAY ?= false;
variable GRAPHITE_CARBON_AGGREGATOR ?= false;
variable GRAPHITE_WITH_CYANITE ?= true;
include 'common/graphite/config';
include {if(GRAPHITE_CARBON_CACHE || GRAPHITE_CARBON_RELAY || GRAPHITE_CARBON_AGGREGATOR) {'common/graphite/carbon/config'}};

include {if(GRAPHITE_GRAPHITE_WEB) {'common/graphite/web/config'}};

include {if(GRAPHITE_WITH_CYANITE) {'common/cyanite/service'}};
