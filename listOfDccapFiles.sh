# This is a small macro to list all the files contained in a directory.
#Syntax:
# source listOfFiles.sh arg1 arg2
# arg1 is the path to the directory in which we want to ls
# arg2 is an optionnal argument allowing to search for file containing "arg2" in their names 
#

S_dccap="dcap://maite.iihe.ac.be/"
Slash='/'

if [[ $2 ]]
then
    for file in `ls $1 | grep $2`
    do
	echo $S_dccap$1$Slash$file
    done    
fi

if [[ ! $2 ]]
then
    for file in `ls $1`
    do
	echo $S_dccap$1$Slash$file
    done    
fi