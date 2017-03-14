Let's Encrypt for Kemp Load Balancers

The bound `/etc/letsencrypt/configs` folder should have:
- 1 or more *.conf files for `certbot` to consume
- 0 or more *.post.sh files to push the certificate to the Kemp

The *.post.sh files should be executable (`chmod +x *.post.sh`) and look roughly like so:
```
#!/bin/sh
cat /etc/letsencrypt/live/domainname/privkey.pem /etc/letsencrypt/live/domainname/cert.pem > /tmp/comb.pem
curl -X POST --data-binary "@/tmp/comb.pem" -k "https://bal:one4all@[LOADBALIP]/access/addcert?cert=cert_name_to_be_replaced&replace=1"
rm /tmp/comb.pem
```

To run:
```docker run -d -p 80:80 -v /non_container_storage/letsencrypt:/etc/letsencrypt kemp-lets-encrypt```
