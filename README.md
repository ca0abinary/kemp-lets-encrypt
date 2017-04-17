Let's Encrypt for Kemp Load Balancers

The bound `/etc/letsencrypt/configs` folder should have:
- 1 or more *.conf files for `certbot` to consume
- 0 or more *.pre.sh files to to any changes before running `certbot`
- 0 or more *.post.sh files to push the certificate to the Kemp

##### Post files
The *.post.sh files should be executable (`chmod +x *.post.sh`) and look roughly like so:
```
#!/bin/sh
DIR=`ls -1dt /etc/letsencrypt/live/my.domain* | head -n1`
CERT="$DIR/cert.pem"
KEY="$DIR/privkey.pem"

cat $CERT $KEY > /tmp/comb.pem
curl -X POST --data-binary "@/tmp/comb.pem" -k "https://user:pass@my.kemp.address/access/addcert?cert=cert_name&replace=1"
rm /tmp/comb.pem
```
Sometimes `certbot` will generate directories with -#### appended, so the above script will use wildcards to find the most recently created directory.

##### To run:
```docker run -d -p 80:80 -v /non_container_storage/letsencrypt:/etc/letsencrypt kemp-lets-encrypt```
