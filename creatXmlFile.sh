# This macro takes a template.xml and spit out an usable xml file. This is useful as wild card are not allowed anymore when accessing file on /pnfs/ via root6.
#Syntax:  
# source listOfFiles.sh arg1 arg2 arg3
# arg1 is the path to the pnfs directory we want to use the listOfFiles.sh script
# arg2 is the name of template.xml
# arg3 is optionnal will set a max number of file to put in the xml
# example source creatXmlFile.sh /pnfs/iihe/cms/store/user/fblekman/TopTree/TopTree74v1/WJetsToLNu_TuneCUETP8M1_13TeV-amcatnloFXFX-pythia8/crab_TOPTREE-WJetsToLNu_TuneCUETP8M1_13TeV-amcatnloFXFX-pythia8-RunIISpring15DR74-Asympt25ns_MCRUN2_74_V9-v1-MINIAODSIM--TopTree74v1--MCRUN2_74_V9-All/150610_100438/0000 WToLNuTemplate.xml 10


# put all the files in a text files with the 
source listOfDccapFiles.sh $1 root > listout.txt

# if arg3 is set, the maximum number of file is set to $arg3
if [[ $3 ]]
then
    mv listout.txt listoutTemp.txt
    head -$3 listoutTemp.txt > listout.txt
fi


# replace end of line by comma
sed -i ':a;N;$!ba;s/\n/,/g' listout.txt


# remove the last characther of the file (which is a return to the line)) 
#head -c -1 listout.txt > listout.txt # removing everything right now! 


# make a copy of the template to keep the template.
cp $2 ToUse$2

# edit template xml and replace "ToBeReplaced" by listout.txt content
perl -pe 's/ToBeReplaced/`cat listout.txt`/ge' -i ToUse$2

