#!/bin/bash
# ---------TCR pipeline------------------
# Author:  Mor Hava Pereg
# Date:    23.11.2022

echo "    "
echo "____________TCR Pipeline - Run Detail:________________"
#echo "Total arguments : $#"
echo "Fastq file path = $1"
echo "Sample name = $2"
echo "length thresould = $3"
echo "quality thresould = $4"
echo "output path = $5"
echo "igblastn path = $6"
echo "igblast dir path = $7"
echo "TcR2Rep dir path = $8"
#if need do dos2unix "/home/mor/TCR_pipeline/Run_all_TCR_pip.bash"
echo "Start process - TCR_Lab_Pipeline"
echo $5
cd $5
mkdir -p $2
echo ________________________________________________________
bash $8TCR_Lab_Pipeline.bash $1 $2 $3 $4 $5$2 $6 $7 $8> $5$2/$2_TCR_pip_log.txt    #bash /home/mor/TCR_Pipeline/TCR_Lab_Pipeline.bash /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1_L001_R1_001.fastq $1 245 20 /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1/ > /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1/$1_TCR_pip_log.txt 
echo "process - TCR_Lab_Pipeline"
echo "DONE!"
echo "Start process - Clone_Freq_Summary"
Rscript $8Clone_Freq_Summary.R $5/$2/$2_after_clonnig.csv $2 $5/$2/ $8> $5$2/$2_TCR_Summary_clone_log.txt    #Rscript /home/mor/TCR_Pipeline/Clone_Freq_Summary.R /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1/$1_after_clonnig.xlsx $1 /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1/ > /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1/$1_TCR_Summary_clone_log.txt 
echo "process - Clone_Freq_Summary"
echo "DONE!"
echo "Start process - TCR_Lab_Pipeline"
bash $8TCR_analysis.bash $5/$2/$2_after_clonnig.csv $2 $5/$2/ $8> $5/$2/$2_TCR_analysis_log.txt    #bash /home/mor/TCR_Pipeline/TCR_analysis.bash /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1/$1_after_clonnig.xlsx $1 /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1/ > /mnt/project2/projects/Tcells/Batch3_jan2023/fastq/raw/$1/$1_TCR_analysis_log.txt 
echo "process - TCR_analysis"
echo "DONE!"