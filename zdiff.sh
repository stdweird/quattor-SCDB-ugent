function zdiff {
    case `uname -s` in
        "Darwin") ZCAT=`which gzcat`;;
        "Linux") ZCAT=`which zcat`;;
    esac
    if [ ! -z "$4" ]
    then
        ZCAT2="ssh root@arceus.ugent.be zcat"
    else
        ZCAT2="$ZCAT"
    fi

    echo diff $3 $ZCAT $1 $ZCAT2 $2
    diff $3 <($ZCAT $1) <($ZCAT2 $2)
}

function qzdiff {
    suff=".json.gz"
    zdiff "$1$suff" "$2$suff" -u
}

function qzd {
    if [ `basename $PWD` == "build" ]
    then
        sub='.'
    else
        sub='build'
    fi
    if [ -z "$3" ]
    then
        pref1=$sub/xml
        pref2=$sub/$2
    else
        pref1=/var/www/https/profiles/
        pref2=$sub/xml
    fi
    suff=".json.gz"
    echo zdiff "$pref2/$1*$suff" "$pref1/$1*$suff" -u $3
    zdiff "$pref2/$1*$suff" "$pref1/$1*$suff" -u $3
}

