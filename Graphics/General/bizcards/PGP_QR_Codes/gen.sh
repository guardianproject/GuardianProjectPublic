#!/bin/sh

for f in `gpg --fingerprint guardianproject.info | grep 'Key fingerprint' | cut -b56-90| sed 's, ,,g'` ; do
    echo OPENPGP4FPR:$f
    KEYNAME=`gpg --fingerprint $f | grep  -A1 'Key fingerprint' | sed -n 's,uid\s*,,p'`
    qrencode  -o "/tmp/qrkeys/${KEYNAME}_$f.png" -l H -i OPENPGP4FPR:$f
done
