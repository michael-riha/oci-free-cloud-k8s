
# Setup DNS in advance:

- [MR Record e.g. `10 bmta.email.<REGION IDENTIFIER>.oci.oraclecloud.com` ](https://docs.oracle.com/en-us/iaas/Content/Email/Reference/gettingstarted_topic-create-email-domain.htm#:~:text=MX%20Record%20for%20Custom%20Domain)
    - [Regions (e.g. `eu-turin-1`)](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm)
- [SPF Record ( e.g. `v=spf1 include:eu.rp.oracleemaildelivery.com ~all`)](https://docs.oracle.com/en-us/iaas/Content/Email/Tasks/configurespf.htm)

## Test the `terraform` setup

`AUTH_STRING=$(echo -ne "\0${SMTP_USER_OCID}/${SMTP_FINGERPRINT}\0$(cat ./ed-oci.key)" | base64)`

`cat ./generated/ed-oci-smtp.conf | grep SMTP_HOST`



```bash
openssl s_client -starttls smtp -crlf -connect smtp.email.eu-turin-1.oci.oraclecloud.com:587 << EOF
EHLO localhost
AUTH PLAIN ${AUTH_STRING}
MAIL FROM: <cluster@oke1.bey.media>
RCPT TO: <michael.riha@gmail.com>
DATA
From: cluster@oke1.bey.media
To: michael.riha@gmail.com
Subject: Manual SMTP Test

Test body
.
QUIT
EOF
```
