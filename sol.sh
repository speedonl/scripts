#!/bin/bash
# Check to see if parameters are given, else display info on how to use
if [[ $# -ne 5 ]]; then
    echo "usage: $0 <Company Name> $1 <Location> $2 <Contact Name> $3 <Contact Phone> $5 <Job Title> "
    echo "Make sure you copy some job requirements to the clipboard!!"
    echo "2 textfiles will be opened, job details and job requirements."
    exit 1
fi   

# Job Hunting administration, a simple script to prepare the system
# for applying to a job
# Date: 2017-05-10
# Author: Egbert Kappert
# Commandline variable $1 for company name
# Commandline variable $2 for contact name
# Commandline variable $3 for phone number
# Commandline variable $4 for job requirements
# Commandline variable $5 for job title
# -------------- System variables ------------------
MKDIR="/bin/mkdir" ;
TOUCH="/usr/bin/touch" ;
CP="/bin/cp" ;
ECHO="/bin/echo" ;
PRINTF="/usr/bin/printf" ;
JOBDETAILS="" ;

# ------------- Applications -----------------------
PAGES="/Applications/Pages.app" ;
MAILAPP="/Applications/Mail.app" ;

# ------------- Files ------------------------------
CV="egbert-kappert-cv.pages" ;

# --------------- File locations -------------------
FOLDER="/Users/egbertkappert/A-Z/S/sollicitaties";

# ---------------- The script ----------------------

# Test for existence of current date folder
if [ -d $FOLDER/$(date '+%Y-%m-%d') ] ; then  \
	echo "Date directory allready exists!" ; \
	else 
	# Create the directory
	echo "Date directory creation" ; \
	$MKDIR $FOLDER/$(date '+%Y-%m-%d') ;
fi;
# Test for existence of the company name directory
if  [ -d $FOLDER/$(date '+%Y-%m-%d')/$1 ]  ; then \
	echo "Company name directory allready exists" ; \
	else
		# Create the company name directory
		# Use the first argument from the command "for example: ./sol.sh schiphol"
		# Create the directory with company name
		echo "Company name directory creation"
		$MKDIR $FOLDER/$(date '+%Y-%m-%d')/$1 ;
fi;
# Create a standard "egbert-kappert-motivatie.rtf" file, this is a copy from
# one of the motivation letters
$CP $FOLDER/egbert-kappert-motivatie.rtf $FOLDER/$(date '+%Y-%m-%d')/$1/egbert-kappert-motivatie.rtf ;
echo "Motivation letter copied!" ;
# Copy standard C.V.
$CP $FOLDER/$CV $FOLDER/$(date '+%Y-%m-%d')/$1/egbert-kappert-cv.pages ;
echo "Curriculum Vitae copied!" ;
# Create the environment
# --------------------------------------------------
# Create a desktop text file for pasting job requirements and contact details
$TOUCH $FOLDER/$(date '+%Y-%m-%d')/$1/jobdetails.txt
# Add the contact details to jobdetails.txt
$PRINTF '%s\n' 'Bedrijf: '$1. 'Plaats: '$2. 'Naam: '$3. 'Telefoon: '$4. 'Job title: '$5. > $FOLDER/$(date '+%Y-%m-%d')/$1/jobdetails.txt
# Open Pages for editing the Curriculum Vitae
open $FOLDER/$(date '+%Y-%m-%d')/$1/egbert-kappert-cv.pages $PAGES ;
# Open the folder in Finder
# Open $MAILAPP ; 
open $FOLDER/$(date '+%Y-%m-%d') ;
# Paste the clipboard info in the jobdetails file
pbpaste > $FOLDER/$(date '+%Y-%m-%d')/$1/jobrequirements.txt
# Open the jobdetails file
open $FOLDER/$(date '+%Y-%m-%d')/$1/jobdetails.txt
open $FOLDER/$(date '+%Y-%m-%d')/$1/jobrequirements.txt
