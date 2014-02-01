#!/usr/bin/perl

# This script read a submission script on the standard input, modifies
# it, and writes the modified script on standard output.  This script
# makes two modifications:
#
#   * correct the node specification to allow all cpus to be used
#   * adds a NOQUEUE flag if the job came in on the sdj queue
#

my $GLOBUS_LOCATION = '/opt/globus';

while (<STDIN>) {

    # By default just copy the line.
    $line = $_;

    # If there is a nodes line, then extract the value and adjust it
    # as necessary.  Only modify the simple nodes request.  If there
    # is a more complicated request assume that the user knows what
    # he/she is doing and leave it alone.
    if (m/#PBS\s+-l\s+nodes=(\d+)\s*$/) {
        $line = process_nodes($1);

        # If the line wasn't empty, then multiple CPUs have been 
        # requested.  Mark this as an MPI job.
        if ($line ne '') {
          $line .= "\n#PBS -A mpi\n";
        }
    }

    # If there is a queue option, check to see if it is "sdj".
    # If so, then add the option to not allow such jobs to be 
    # queued.
    if (m/#PBS\s+-q\s+sdj/) {
        $line .= "#PBS -W x=\"FLAGS:NOQUEUE\"\n";
    }


    # If there is an existing accounts line, delete it.  The account 
    # should not be set to the DN, because an internal maui table is
    # filled which prevents standing reservations from being defined.
    if (m/#PBS\s+-A/) {
        $line = '';
    }

    print $line;
}

# This takes the number specified in the "nodes" specification and
# returns a "PBS -l" line which can be allocated on the available
# resources.  This essentially does per-cpu allocation.
sub process_nodes {
    my $nodes = shift;
    my $line = "";
    
    # If the requested number of nodes is 1, just return an empty string.
    if ($nodes == 1) {
      return "";
    }

    # Collect information from the pbsnodes command on the number of
    # machine and cpus available.  Don't do anything with offline
    # nodes.
    open PBS, "pbsnodes -a |";
    my $state = 1;
    my %machines;
    while (<PBS>) {
        if (m/^\s*state\s*=\s*(\w+)/) {
            $state = ($1 eq "offline") ? 0 : 1;
        } elsif (m/^\s*status\s*=\s*.*ncpus=(\d+),/) {
            my $ncpus = $1;
            if ($state) {
                if (defined($machines{$ncpus})) {
                    $machines{$ncpus} = $machines{$ncpus}+1;
                } else {
                    $machines{$ncpus} = 1;
                }
            }
        }
    }
    close PBS;

    # Count the total number of machines and cpus.
    my $tnodes = 0;
    my $tcpus = 0;
    my $maxcpu = 0;
    foreach my $ncpus (sort num_ascending keys %machines) {
        $tnodes += $machines{$ncpus};
        $tcpus += $machines{$ncpus}*$ncpus;
        $maxcpu = $ncpus if ($tcpus>=$nodes);
    }

    if ($maxcpu==0) {

        # There aren't enough cpus to handle the request.  Just pass
        # the request through and let the job fail.
        $line .= "#PBS -l nodes=$nodes\n";

    } else {

        $line .="#PBS -l ";

        # We've already identified the largest machine we'll have to
        # allocate.  Start by allocating one of those and iterate until
        # all are used.
        my %allocated;
        my $remaining_cpus = $nodes;
        my $remaining_nodes = $tnodes;
        foreach my $ncpus (sort num_descending keys %machines) {
            if ($ncpus<=$maxcpu && $remaining_cpus>0) {
                my $nmach = $machines{$ncpus};
                for (my $i=0;
                     ($i<$nmach) && ($remaining_cpus>$remaining_nodes);
                     $i++) {

                    $remaining_cpus -= $ncpus;
                    $remaining_nodes -= 1;

                    # May only have to use part of a node.  Check here
                    # for that case.
                    my $used = ($remaining_cpus>=0)
                        ? $ncpus
                        : $ncpus+$remaining_cpus;

                    # Increase the allocation.
                    if (defined($allocated{$used})) {
                        $allocated{$used} += 1;
                    } else {
                        $allocated{$used} = 1;
                    }
                }

                # If we can fill out the rest without restricting the
                # number of cpus on a node, do so.
                if ($remaining_cpus<=$remaining_nodes &&
                    $remaining_cpus>0) {

                    my $used = 1;
                    if (defined($allocated{$used})) {
                        $allocated{$used} += $remaining_cpus;
                    } else {
                        $allocated{$used} = $remaining_cpus;
                    }
                    $remaining_cpus = 0;
                }
            }
        }

        my $first = 1;
        foreach my $i (sort num_descending keys %allocated) {
            $line .= "+" unless $first;
            $line .= "nodes=" if $first;
#           $line .= "nodes=";
            $line .= $allocated{$i};
#           $line .= ":ppn=" . $i unless ($i == 1);
            $line .= ":ppn=" . $i;
            $first = 0;
        }
        $line .= "\n";
    }

    return $line;
}


sub num_ascending { $a <=> $b; }


sub num_descending { $b <=> $a; }
