#!/bin/bash

SUBJECT="Automail-Service"
MESSAGE="No further informations given"

# Checking to ensure a subject was specified and that it exists
if [ "$1" != "" ]; then
	echo "Subject specified"
	SUBJECT=$1
fi

# Getting the Body for this e-mail
if [ -p /dev/stdin ]; then
        echo "Message-body was piped to this script!"
        MESSAGE="$( cat )"
fi

sendemail -f "EMAIL_FROM" \
-u "$SUBJECT" \
-m "$MESSAGE" \
-t "EMAIL_TO" \
-s "SMTP:PORT" \
-o tls=yes \
-xu "EMAIL" \
-xp "PASSWORD"
