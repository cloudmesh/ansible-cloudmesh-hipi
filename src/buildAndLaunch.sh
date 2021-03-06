#! /bin/bash
echo
echo
echo "*******************Cleaning tools******************"
cd ~/hipi
gradle clean tools:hibImport:jar

echo
echo
echo "*******************Building tools******************"
cd ~/hipi/tools
gradle hibImport:jar


echo
echo
echo "*******************Configuring hadoop**************"
hdfs dfs -rm -r /input
hdfs dfs -rm -r sampleimages_average
hdfs dfs -mkdir /input
#sh ~/hipi/tools/hibImport.sh ~/INRIAPerson/Train/pos/ /input/sampleimages.hib
sh ~/hipi/tools/hibImport.sh ~/hipi/testdata/testimages/ /input/sampleimages.hib

echo
echo
echo "*******************Building Project****************"
cd ~/hipi/examples/pixelIntensity
gradle jar

echo
echo
echo "******************Executing Project****************"
hadoop jar ~/hipi/examples/pixelIntensity/build/libs/pixelIntensity.jar \
/input/sampleimages.hib sampleimages_average
hadoop fs -cat sampleimages_average/part-r-00000
