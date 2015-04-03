#!/bin/bash
# GTFS mirroring tool.  This allows us to keep the GTFS data from Transperth
# into a revision control system (so we could look up historical data).
#
# Copyright 2011, 2015 Michael Farrell <http://micolous.id.au>
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.

DATA_ZIP="http://www.transperth.wa.gov.au/TimetablePDFs/GoogleTransit/Production/google_transit.zip"
DATA_ZIPFILENAME="google_transit.zip"

# Create the target folder
mkdir -p "gtfs"

wget -N "${DATA_ZIP}"

unzip -ouL "${DATA_ZIPFILENAME}" -d "gtfs"
git add gtfs/*.txt

# Commit
DATE="`date`"
MSG="New data from upstream source on ${DATE}"

git commit -am "${MSG}"

# Push downstream to bitbucket
git push origin master

