#!/bin/bash

`which asciidoc > /dev/null 2>&1`;
if [ "$?" -ne "0" ]; then
    echo "please install the asciidoc package";
    exit 1;
fi

DOS2UNIX=$(which dos2unix || which fromdos)

cd docs || ( echo "please run from the project root dir"; exit 1; )

if [ THRUK_MANUAL.txt -nt THRUK_MANUAL.html ]; then
    asciidoc --unsafe -a toc -a toclevels=2 -a icons -a data-uri -a max-width=800 THRUK_MANUAL.txt
    chmod 644 THRUK_MANUAL.html
    $DOS2UNIX THRUK_MANUAL.html
fi

if [ FAQ.txt -nt FAQ.html ]; then
    asciidoc --unsafe -a toc -a toclevels=2 -a icons -a data-uri -a max-width=800 FAQ.txt
    chmod 644 FAQ.html
    $DOS2UNIX FAQ.html
fi


if [ thruk8.txt -nt thruk.8 ]; then
    a2x -d manpage -f manpage thruk8.txt
    chmod 644 thruk.8
    $DOS2UNIX thruk.8
fi

[ thruk   -nt thruk.3 ]   && pod2man -s 3 -n thruk   ../script/thruk   > thruk.3
[ naglint -nt naglint.3 ] && pod2man -s 3 -n naglint ../script/naglint > naglint.3

exit
