#!/bin/sh

for f in `gpg --fingerprint guardianproject.info | grep 'Key fingerprint' | cut -b56-90| sed 's, ,,g'` ; do
    KEYNAME=`gpg --fingerprint $f | grep  -A1 'Key fingerprint' | sed -n 's,uid\s*,,p'`
    echo $KEYNAME OPENPGP4FPR:$f
    qrencode  -o "/tmp/qrkeys/${KEYNAME}_$f.png" -l H -i OPENPGP4FPR:$f
done
