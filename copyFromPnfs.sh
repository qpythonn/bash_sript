#this is a macro to copy all files from a pnfs directory to a given directory
#syntax: source copyFromPnfs.sh arg1 arg2 arg3
# arg1 is the path to the directory from which we want to copy
# arg2 is the path to the directory in which we want to copy
# arg3 is the string that each file to be copied should contained in their names (typically "root")


# first creat the list of command
source createListOfCmd.sh $1 $2 $3 > preAwk.txt

# remove unnecessary line
awk '/^dccp/' preAwk.txt > postawk.txt

#create dir
mkdir $2

# copy the files
source postawk.txt

# move the txt files to the same location than the root files
mv preAwk.txt $2
mv postawk.txt $2
