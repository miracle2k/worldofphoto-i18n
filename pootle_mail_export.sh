#!/bin/sh

# 
# Helper script to export the list of user's email addresses from a Pootle 
# in a format that can be used in an email program's BCC field.
#

echo "from django.contrib.auth.models import User; print ', '.join([u.email for u in User.objects.all() if u.email])" | /opt/pootle/source/Pootle/manage.py shell