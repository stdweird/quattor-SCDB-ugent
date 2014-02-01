unique template common/nfs/client/fstab;


# ---------------------------------------------------------------------------- 
# nfs
# ---------------------------------------------------------------------------- 
include { 'components/nfs/config' };

variable NFS_DEFAULT_MOUNT_OPTTIONS ?= "rw";  

# If WNs are using a shared (NFS) filesystem for home areas
# or VO SW areas, mount them on the worker nodes. 

"/software/components/nfs/" = { 
  if ( !( is_defined(SELF['mounts']) && is_list(SELF['mounts']) ) ) {
    SELF['mounts'] = list();
  };

  if ( is_defined(WN_SHARED_AREAS) ) {
    if ( ! is_nlist(WN_SHARED_AREAS) ) {
      error("WN_SHARED_AREAS must be a nlist");
    };
    if ( length(WN_SHARED_AREAS) > 0 ) {
      foreach(e_mnt_point; mnt_params;WN_SHARED_AREAS) {
        # An undefined mnt_path means mount must not be handled by NFS templates
        if ( is_defined(mnt_path) ) {
          mnt_path_toks = matches(mnt_path, '^((?:[\w\-]+\.*)*):?((?:/[\w\.\-]*)*)');
          # No match
          if ( length(mnt_path_toks) == 0 ) {
            error('Invalid mount point ('+mnt_path+')');
          };
          mnt_host = mnt_path_toks[1];
          if (( mnt_host != FULL_HOSTNAME )  && ( mnt_host != "")) {
            mnt_point = unescape(e_mnt_point);
            if ( (length(mnt_path_toks) < 3) || (length(mnt_path_toks[2]) == 0) ) {
              mnt_path = mnt_host + ':' + mnt_point;
            };
            mnt_ind = length(SELF['mounts']);
            SELF['mounts'][mnt_ind] =  nlist("device",mnt_path,
                                     "mountpoint",mnt_point,
                                     "fstype","nfs");
            if ( exists(NFS_MOUNT_OPTS[e_mnt_point]) && is_defined(NFS_MOUNT_OPTS[e_mnt_point]) ) {
              SELF['mounts'][mnt_ind]["options"] = NFS_MOUNT_OPTS[e_mnt_point];
            } else {
              SELF['mounts'][mnt_ind]["options"] = NFS_DEFAULT_MOUNT_OPTTIONS;
            };
          }; 
        }; 
      };  
    };
  };
  SELF;
};

