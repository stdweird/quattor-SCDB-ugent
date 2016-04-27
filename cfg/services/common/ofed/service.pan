unique template common/ofed/service;


## is there IB hardware?
include {
    if (exists('/hardware/cards/ib')) {
        "common/ofed/config"
    }
};
