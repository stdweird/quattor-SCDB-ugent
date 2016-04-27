# This template configures the current node as a NFS server if it is listed
# as a NFS server for any filesystem in WN_SHARED_AREAS. If it is not, this
# template does nothing to the current configuration.

unique template common/nfs/server/config;

# ----------------------------------------------------------------------------
# Check if this machine is a NFS server for some filesystems
# ----------------------------------------------------------------------------

variable NFS_ENABLED = {
  nfs_server = false;
  if ( is_defined(WN_SHARED_AREAS) ) {
    if ( ! is_nlist(WN_SHARED_AREAS) ) {
      error("WN_SHARED_AREAS must be a nlist");
    };

    foreach(e_mnt_point; mnt_path;WN_SHARED_AREAS) {
      # An undefined mnt_path means mount must not be handled by NFS templates
      if ( is_defined(mnt_path) ) {
        mnt_path_toks = matches(mnt_path, '^((?:[\w\-]+\.*)*):?((?:/[\w\.\-]*)*)');
        # No match
        if ( length(mnt_path_toks) == 0 ) {
          error('Invalid mount point ('+mnt_path+')');
        };
        mnt_host = mnt_path_toks[1];
        if ( mnt_host == FULL_HOSTNAME ) {
          nfs_server = true;
        };
      };
    };
  };

  return(nfs_server);
};


# ----------------------------------------------------------------------------
# Enable and configure NFS server
# ----------------------------------------------------------------------------

include 'components/chkconfig/config';
include 'components/filecopy/config';

"/software/components/chkconfig" = {
  if ( ! is_defined(SELF['service']) ) {
    SELF['service'] = dict();
  };
  if (NFS_ENABLED) {
    SELF['service']["nfs"] = dict("on", "", "startstop", false);
    SELF['service']["nfslock"] = dict("on", "", "startstop", false);
  };
  SELF;
};

"/software/components/filecopy" = {
  if ( ! is_defined(SELF['services']) ) {
    SELF['services'] = dict();
  };
  if (NFS_ENABLED && is_defined(NFS_THREADS[FULL_HOSTNAME])) {
    nfs_sysconfig = "/etc/sysconfig/nfs";
    SELF['services'][escape(nfs_sysconfig)] = dict("config","RPCNFSDCOUNT="+to_string(NFS_THREADS[FULL_HOSTNAME]),
                               "owner","root",
                               "perms","0644",
                               "restart","/etc/init.d/nfs restart");
  };
  SELF;
};


# ----------------------------------------------------------------------------
# NFS exports
# ----------------------------------------------------------------------------

variable NFS_SERVER_COMPONENT_INCLUDE = if ( NFS_ENABLED ) {
                                          return('components/nfs/config');
                                        } else {
                                          return(null);
                                        };
include NFS_SERVER_COMPONENT_INCLUDE;
"/software/components/nfs" = {
  if (NFS_ENABLED) {
    if ( !( is_defined(SELF['exports']) && is_list(SELF['exports']) ) ) {
        SELF['exports'] = list();
    };
    foreach(e_mnt_point; mnt_path;WN_SHARED_AREAS) {
      # An undefined mnt_path means mount must not be handled by NFS templates
      if ( is_defined(mnt_path) ) {
        mnt_path_toks = matches(mnt_path, '^((?:[\w\-]+\.*)*):?((?:/[\w\.\-]*)*)');
        # No match
        if ( length(mnt_path_toks) == 0 ) {
          error('Invalid mount point ('+mnt_path+')');
        };
        mnt_host = mnt_path_toks[1];
        if ( mnt_host == FULL_HOSTNAME ) {
          mnt_point = unescape(e_mnt_point);
          if ( (length(mnt_path_toks) < 3) || (length(mnt_path_toks[2]) == 0) ) {
            mnt_path = mnt_point;
          } else {
            mnt_path = mnt_path_toks[2];
          };
          SELF['exports'][length(exports)] = dict("path",mnt_path,
                                                   "hosts",SITE_NFS_ACL);
        };
      };
    };
  };

  SELF;
};
