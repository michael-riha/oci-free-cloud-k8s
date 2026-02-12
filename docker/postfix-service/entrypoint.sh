#!/bin/sh

# Replace placeholders in main.cf with env vars or defaults
sed -e "s/HOSTNAME/${HOSTNAME:-postfix-relay}/g" \
    -e "s/DOMAIN/${DOMAIN:-localdomain}/g" \
    -e "s/RELAY_HOST/${RELAY_HOST:-smtp.email.us-ashburn-1.oci.oraclecloud.com}/g" \
    -e "s/RELAY_PORT/${RELAY_PORT:-465}/g" \
    /main.cf.template > /etc/postfix/main.cf

# Create sasl_passwd from env vars if provided
if [ -n "$SMTP_USER" ] && [ -n "$SMTP_PASSWORD" ]; then
    echo "[$RELAY_HOST]:${RELAY_PORT:-465} $SMTP_USER:$SMTP_PASSWORD" > /etc/postfix/sasl_passwd
    chmod 600 /etc/postfix/sasl_passwd
    postmap hash:/etc/postfix/sasl_passwd    # Exact Oracle format Creates .db with correct perms
fi

# Postfix's smtp process runs chrooted by default (in /var/spool/postfix), meaning it has a limited view of the filesystem and can't access /etc/resolv.conf properly.
# To ensure Postfix can resolve DNS, we need to provide it with a resolv.conf inside its chroot environment. We'll use Google's public DNS for simplicity.
echo "nameserver 8.8.8.8" > /var/spool/postfix/etc/resolv.conf

newaliases

# Execute the main command
exec "$@"
