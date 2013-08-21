#!/bin/sh

fpfile=fingerprints.txt

echo " fingerprint                                       | email" > $fpfile
echo "=======================================================================" >> $fpfile

for f in `gpg --fingerprint guardianproject.info | grep 'Key fingerprint' | cut -b25-90 | sed 's, ,,g'` ; do
    keyid=`echo $f | cut -b25-40`
    KEYNAME=`gpg --fingerprint $f | grep  -A1 'Key fingerprint' | sed -n 's,uid\s*,,p' | sed 's, ,_,g' | sed 's,[<>],,g'`
    echo $KEYNAME OPENPGP4FPR:$keyid
    fingerprint=`gpg --fingerprint $f | grep 'Key fingerprint' | cut -b25-90`
    echo "$fingerprint | $KEYNAME" >> $fpfile
    qrencode  -o "${KEYNAME}_$keyid.png" -l H -i OPENPGP4FPR:$keyid
done
