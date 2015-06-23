# macro to get the status of all the crab jobs under the "crab_projects directory"
# syntax: source monitorJobs.sh
#

#!/bin/bash

rm -rf ongoing.txt
rm -rf done.txt

source $VO_CMS_SW_DIR/cmsset_default.sh
cmsenv
source /cvmfs/cms.cern.ch/crab3/crab.sh

for crabsamplename in `ls $PWD/crab_projects`
do
    echo $crabsamplename
    crab status crab_projects/$crabsamplename > temptextfile.txt
    if ["`grep COMPLETED temptextfile.txt`" -n ] ; then
	echo "++++++++++++++++++++++  still running " $crabsamplename
	cat temptextfile.txt
#        echo " rm -rf crab_projects/"$crabsamplename
#        rm -rf crab_projects/$crabsamplename
    else
	echo ">>>>>>>>>>>>>>>>>>>>>>>> found completed job " $crabsamplename
	cat temptextfile.txt
#        if ["`grep "SkipEvent = cms.untracked.vstring('ProductNotFound')" temptextfile.txt`" -n ] ; then
#            grep $crabsamplename allfiles.txt| awk '{print "| %N% | [[https://cmsweb.cern.ch/das/request?input="$1"]["$1"]] | ? | ? | fblekman | Missing Products! |"}' >> badsamples.txt
#
#            echo "corrupt sample: crab_projects/"$crabsamplename
#            cat badsamples.txt
#        else
#            if [ "`grep failed temptextfile.txt`" -n ] ; then
#                echo "resubmitting crab_projects/"$crabsamplename
#                crab resubmit crab_projects/$crabsamplename
#            fi
#        fi
#        crab status crab_projects/$crabsamplename
    fi
    rm -rf temptextfile.txt
done

#for datasetname in `ls /pnfs/iihe/cms/store/user/fblekman/TopTree/CMSSW_70X/phys14.v1/` 
#do
#    echo $datasetname
#    if [ `ls crab_projects | grep $datasetname` ] ; then
#	echo "NOT DONE " $datasetname
#  	crab status crab_projects/$datasetname                                                                                                                                           #        
#	grep $datasetname allfiles.txt| awk '{print "| running | [[https://cmsweb.cern.ch/das/request?input="$1"]["$1"]] | ? | ? | fblekman | /pnfs/iihe/cms/store/user/fblekman/TopTree/CMSSW_70X/phys14.v1/"$2"/*/*/*/*/*.root  |"}' >> ongoing.txt
#    else
#	echo "DONE " $datasetname
#	grep $datasetname allfiles.txt|	awk '{print "| %Y% | [[https://cmsweb.cern.ch/das/request?input="$1"]["$1"]] | ? | ? | fblekman | /pnfs/iihe/cms/store/user/fblekman/TopTree/CMSSW_70X/phys14.v1/"$2"/*/*/*/*/*.root  |"}' >> done.txt
#    fi

#done

echo "| *status* | *dataset name* | *number events* | *xsec* | *user* | *path (drill deeper into this directory to get the toptree files)* | "
cat done.txt
echo ""
echo "| *status* | *dataset name* | *number events* | *xsec* | *user* | *path (drill deeper into this directory to get the toptree files)* | "
cat ongoing.txt
echo ""
echo "| *status* | *dataset name* | *number events* | *xsec* | *user* | *path (drill deeper into this directory to get the toptree files)* | "
cat badsamples.txt



