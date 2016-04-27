structure template common/sysctl/struct/shm;

# shared memory
# settings needed for eg gamess-us
# shmmax 2GB (per core)
# shmall = all = 16GB in pages

'kernel.shmmax' = format('%s', SYSCTL_SHM_MULTIPLIER * 2 * get_num_of_cores() * 1024 * 1024 * 1024);
'kernel.shmmni' = format('%s', SYSCTL_SHM_MULTIPLIER * 16 * 1024);
'kernel.shmall' = format('%s', SYSCTL_SHM_MULTIPLIER * total_ram() * 1024 * 1024 / (4*1024)); # in pages (page size = getconf PAGE_SIZE)

# semaphore
'kernel.sem' = format('%s %s %s %s', 250, 32000, 100, 1024);
