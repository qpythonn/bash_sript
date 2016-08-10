# This is a small macro to list all the files contained in a directory.
#Syntax:
# source listOfFiles.sh arg1 arg2 [arg3]
# arg1 is the path to the directory in which we want to ls
# arg2 is the path to the target directory in which we want to copy the list of ile
# arg3 is an optionnal argument allowing to search for file containing "arg2" in their names 

if [ -f "$2/files.txt" ]
then
    echo "files.txt exist!"
    echo "Deleting old file ..."
    rm -f $2/files.txt
fi


if [ -f "$2/all.root" ]
then
    echo "all.root exist!"
    echo "Deleting old file ..."
    rm -f $2/all.root
fi


# make the txt file containing all the files
if [[ $3 ]]
then
    for file in `ls $1 | grep $3`
    do
	printf "dcap://maite.iihe.ac.be/$1$file " >> $2/files.txt
    done    
fi

if [[ ! $3 ]]
then
    for file in `ls $1`
    do
	printf "dcap://maite.iihe.ac.be/$1$file " >> $2/files.txt
    done    
fi





# hadding
rootfiles=`cat $2/files.txt`

hadd $2/all.root $rootfiles

