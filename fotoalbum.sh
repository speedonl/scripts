#!/bin/bash

# Creating webpages from exported Lightroom images
# Command line: ./thumbnails.pl %SOURCE(f.e. uitje)%
# This script creates webpages from Lightroom exported images from $SOURCE
# See 20171225-fotoalbum-items-maken.txt for steps which need to be added here

# Step 1 - export from Adobe Lightroom (through App)
# Step 2 
# Date: 2017-12-25
# Author: Egbert Kappert

# commandline is: ./fotoalbum %source-subdirectory%
# S1 is the input selecter

# -------------- System variables ------------------
MKDIR="/bin/mkdir" ;
TOUCH="/usr/bin/touch" ;
CP="/bin/cp" ;
RM="/bin/rm";
RSYNC="/usr/bin/rsync";

# ------------- Applications -----------------------
# The thumbnails python script, checkout http://www.netpurgatory.com/downloads.html#thumbnail
THUMBNAILS="/Users/egbertkappert/bin/thumbnails.pl" ;
FTPAPP="/Applications/Transmit.app" ;

# ------------- Files ------------------------------

# --------------- File and Directory locations -------------------
TARGET="/Users/egbertkappert/bin/pictures"; #Folder used by the Thumnails script
WEBFOLDER="/Users/egbertkappert/1-Dev/sites/kaweb/www/html/pictures/"; # Local copy of the KaWEB website
SOURCE="/Users/egbertkappert/Pictures/deviantart/"; #Exports from Lightroom

# ---------------- The script ----------------------
# Test for existence of old folders in the thumbnails app folder
echo "$TARGET"
if [ -z "$(ls -A $TARGET)" ]; then
   echo "Empty"
else
   echo "Not Empty"
   $RM -rfv $TARGET/* # Remove all files and directories in TARGET without confirmation
fi

# Copy files from the Lightroom exports (/Users/Shared/foto/export/fotoalbum/verzameling) to the thumbnail generator subdir
$CP -vr $SOURCE/$1/. $TARGET/$1/

# Perform the webpage creation process
$THUMBNAILS pictures/$1

# Copy the result to the local website folder
$CP -vr $TARGET/. $WEBFOLDER/

clear
echo "Now pls do the rest with ftp'ing"
open $FTPAPP ;
#end






