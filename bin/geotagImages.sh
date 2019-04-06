#!/bin/sh
CMD="exiftool"
NOOVERWRITE="-if 'not \$gps:all'"
PHOTO_DIR="."
GPSLOG_DIR="/home/aritz/locationLogs"

AUTHOR='Aritz Beraza'
RIGHTS="© \$CreateDate, $AUTHOR"

OPT_MAX_SEC=3600
TIME_ZONE="Z" #"+00:00" is usual format; Z means UTC

OVERWRITE=1

while getopts p:g:m:z:a:t:h option
do
  case "${option}"
  in
  p) PHOTO_DIR=${OPTARG};;
  g) GPSLOG_DIR=${OPTARG};;
  m) OPT_MAX_SEC=${OPTARG};;
  a) AUTHOR=${OPTARG};;
  t) TIME_ZONE=${OPTARG};;
  o) OVERWRITE=0;;
  esac
done

GPSLOG_FILES="'$GPSLOG_DIR/*.gpx'"

A_GEOLOC="-geotag '${GPSLOG_DIR}/*.gpx' -api GeoMaxExtSecs=$OPT_MAX_SEC"
A_GEOTIME="'-geotime<\${DateTimeOriginal#}$TIME_ZONE'"
#A_GEOTIME="'-geotime<\${DateTimeOriginal#}+00:00'"
A_RIGHTS="'-rights<$RIGHTS' '-CopyrightNotice<$RIGHTS' -author=\"$AUTHOR\" -artist=\"$AUTHOR\""
A_OPTIONS="-P -d %Y -overwrite_original"

A_OVERWRITE=$NOOVERWRITE
if [ "$OVERWRITE" -eq "0" ]; then
	A_OVERWRITE=""
fi

CMD="$CMD $A_OVERWRITE $A_GEOLOC $A_GEOTIME $A_OPTIONS $A_RIGHTS -r $PHOTO_DIR"
#CMD="$CMD $A_OVERWRITE $A_OPTIONS $A_RIGHTS -r $PHOTO_DIR"
echo $CMD
eval $CMD
