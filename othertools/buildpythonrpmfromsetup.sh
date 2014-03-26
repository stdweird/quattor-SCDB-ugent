#!/bin/bash

# Copyright 2009-2014 Ghent University
#
# This file is part of buildpythonrpmfromsetup.sh,
# originally created by the HPC team of Ghent University (http://ugent.be/hpc/en),
# with support of Ghent University (http://ugent.be/hpc),
# the Flemish Supercomputer Centre (VSC) (https://vscentrum.be/nl/en),
# the Hercules foundation (http://www.herculesstichting.be/in_English)
# and the Department of Economy, Science and Innovation (EWI) (http://www.ewi-vlaanderen.be/en).
#
# buildpythonrpmfromsetup.sh is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation v2.
#
# buildpythonrpmfromsetup.sh is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with buildpythonrpmfromsetup.sh.  If not, see <http://www.gnu.org/licenses/>.
# #

if [ -z "$1" ]
then
  echo "Need a name as first argument"
  exit 1
fi

python -c "import distutils"
if [ ! "$?" == "0" ]
then
   echo "Can't import distutils"
   exit 1
fi



name=$1

here=$PWD/$name
tempdir=`mktemp -d`
srcdir=$tempdir/$name



## a wrapper around
##  python setup.py bdist --formats=rpm
# needs a setup.py
if [ ! -d "$name" ]
then
  echo "no source found, downloading with easy_install -e "
  easy_install -e -b $tempdir $name
else # copy source code to temp
  mkdir -p $srcdir
  cd $here
  cp -va * $srcdir
fi

cd $srcdir

if [ ! -f "setup.py" ]
then
  echo "Build failed. in $here"
  echo "Need a setup.py script in $srcdir"
  exit 1
fi

# andy's script here
outputfile="$PWD/setup.out"
echo "Running setup.py (redirecting output to $outputfile)"
#python setup.py bdist --formats=rpm >& setup.out

## for el5, no harm om el6
## gets rid of Installed (but unpackaged) file(s) found for pyo files (should be default in el6)
cat >> setup.cfg <<EOF
[build_py]
optimize = 1
EOF
python ./setup.py bdist_rpm >& $outputfile
rpm_target=`ls dist/*{noarch,x86_64,i686,i386}.rpm 2> /dev/null |grep -v debuginfo`

if [ -z $rpm_target ]
then
    echo "Build failed. in $here."
    cat $outputfile
    echo "Build failed. in $here"
    echo "Unexpected rpm name. tmpdir $tempdir."
else
    rpm_target_name=`basename ${rpm_target}`

    # user specified requirements can be found in setup.cfg
    requirements=`grep "requires" setup.cfg | cut -d" " -f3- | tr "," "|"`
    if [ -z "$requirements" ]; then
        requirements="no-match-etc-etc-etc"
    fi

    if [ -z "$release" ]; then
      release="\\2"
    fi

    rpmrebuild --define "_rpmfilename %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm" \
               --change-spec-preamble="sed -e 's/^Name:\(\s\s*\)\(.*\)/Name:\1python-\2/'" \
               --change-spec-provides="sed -e 's/${name}/python-${name}/g'" \
               --change-spec-requires="sed -r 's/^Requires:(\s\s*)(${requirements})/Requires:\1python-\2/'" \
               --change-spec-preamble="sed -e 's/^\(Release:\s\s*\)\(.*\)\s*$/\1${release}.ug/'" \
                ${edit} -n -p ${rpm_target} >> $outputfile 2>&1


    echo "Checking result"
    if [ "$?" == "0" ]
    then
        rpm=`grep 'result:' $outputfile  |grep -v src.rpm |  cut -d " " -f2`
        if [ ! -f $rpm ]
        then
            ## in el5 rpmrebuild doesn't always write it where you'd expect it
            newrpm=/usr/src/redhat/RPMS/$rpm
            if [ -f $newrpm ]
            then
                echo "rpm not found in $rpm but in $newrpm"
                rpm=$newrpm
            else
                echo "Unexpected rpm name. in $here"
                cat $outputfile
                echo "Unexpected rpm name. in $here"
                echo "Unexpected rpm name. tmpdir $tempdir."
            fi
        fi



        echo "rpm created: $rpm"
        if [ -z "$rpm" ]
        then
            echo "Unexpected rpm name. in $here"
            cat $outputfile
            echo "Unexpected rpm name. in $here"
            echo "Unexpected rpm name. tmpdir $tempdir."
        else
            echo "rpm created: $rpm"
            rpmname=`basename $rpm`
            rm -f /tmp/$rpmname
            cp -a $rpm /tmp/$rpmname
            ## fake output for clusterbuild
            echo "Wrote: /tmp/$rpmname"
            #rm -Rf $tempdir
         fi
    else
        echo "Build failed. in $here."
        cat $outputfile
        echo "Build failed. in $here"
        echo "Unexpected rpm name. tmpdir $tempdir."
    fi
fi
