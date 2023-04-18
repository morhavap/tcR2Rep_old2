#!/bin/bash
# ---------TCR pipeline------------------
# Author:  Mor Hava Pereg
# Date:    23.11.2022

echo "    "
echo "____________TCR Pipeline - Run Detail:________________"
#echo "Total arguments : $#"
echo "Input file = $1"
echo "Sample name = $2"
echo "Length threthold = $3"
echo "Quality threthold = $4"
echo "Cell kind = TCR"
echo "Organism = Human"
echo "output direcrory  = $5"
echo "igblastn path = $6"
echo "igblast dir path = $7"
echo "TcR2Rep dir path = $8"

#if need do dos2unix "/home/orz/T_cell_pipeline.bash"

#-------pre-processing--------------------
#filter by length and quality
python "/home/mor/TCR_pipeline/Filter_by_Length.py" $1 $2 $3 $5
echo "done-filter length"
python "/home/mor/TCR_pipeline/Filter_by_Quality.py" $5/$2_length-pass.fastq $2 $4 $5

#convert fastq to fasta
sed -n '1~4s/^@/>/p;2~4p' $5/$2_quality-pass.fastq > $5/$2_quality-pass.fasta
echo "Done - convert fastq to fasta"

#-------annotation------------------------
cd $7
#cd /home/mor/TCR_Pipeline_old/ncbi-igblast-1.20.0/

#path not good
#run igblastn on imgt database -  need fasta file format
#export $IGDATA="/home/mor/TCR_Pipeline_old/ncbi-igblast-1.20.0/internal_data/"
$6 -germline_db_V database/imgt_human_TRV_igblast -germline_db_J database/imgt_human_TRJ_igblast -germline_db_D database/imgt_human_TRD_igblast -organism human -query $5/$2_quality-pass.fasta  -ig_seqtype TCR -auxiliary_data optional_file/human_gl.aux -show_translation -outfmt 19  > $5/$2_after_annotation.tsv 
echo "Done - annotation step"

#-------R script for: 1.filter by length>145,productive=T and cdr3=T
#                     2.remove and count duplicate
#                     3.assign into clone

Rscript $8Assign_into_Clones_[T_CELL].R $5/$2_after_annotation.tsv $2 $5 > $5/Assign_into_Clones_log.txt
echo "Done - assign into clone step"

echo "TCR pip - Process DONE"


#trimomatic - trimming seq by quality and len
#~/TCR_Pipeline/Data/Batch1/fastq/AL11/trimmed$ java -jar "/data/software/trimmomatic/Trimmomatic-0.39/trimmomatic-0.39.jar" SE "/home/orz/TCR_Pipeline/Data/Batch1/fastq/AL11/AL11_S1_L001_R1_001.fastq" output.fastq ILLUMINACLIP:NexteraPE-PE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:245





#-------split by locus and productive-----

#ParseDb.py split -d $2_quality-pass_igblast.tsv -f productive
#ParseDb.py split -d $2_quality-pass_igblast_productive-T.tsv -f locus  