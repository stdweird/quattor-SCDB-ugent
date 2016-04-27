unique template common/stress/config;
include 'common/stress/rpms/config'+RPM_BASE_FLAVOUR;
variable CONTENTS = <<EOF;
#!/bin/bash

for i in `seq  1 16`
do
  burnP6 >& /tmp/cpuburn-$i &
done
memtester 20G >& /tmp/memtester &

EOF

"/software/components/filecopy/services" =
  npush(escape("/usr/bin/testnode"),
        dict("config",CONTENTS,
              "perms","0755"));
