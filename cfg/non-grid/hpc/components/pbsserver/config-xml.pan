# #
# Software subject to following license(s):
#   Apache 2 License (http://www.opensource.org/licenses/apache2.0)
#   Copyright (c) Responsible Organization
#

# #
# Current developer(s):
#   Charles Loomis <charles.loomis@cern.ch>
#

# #
# Author(s): Jane SMITH, Joe DOE
#

# #
      # pbsserver, 13.1.3-SNAPSHOT, SNAPSHOT20131017141437, 20131017-1614
      #

unique template components/pbsserver/config-xml;

include { 'components/pbsserver/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/pbsserver';

# Embed the Quattor configuration module into XML profile.
'code' = file_contents('components/pbsserver/pbsserver.pm'); 
