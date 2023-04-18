#!/bin/bash
# ---------TCR pipeline------------------
# Author:  Mor Hava Pereg
# Date:    23.11.2022

echo "    "
echo "____________TCR Pipeline - Run Detail:________________"
#echo "Total arguments : $#"
echo "Input file = $1"
echo "Sample name = $2"
echo "Cell kind = TCR"
echo "Organism = Human"
echo "output direcrory  = $3"

#if need do: dos2unix "/home/orz/T_cell_pipeline.bash"


#Clonal_Size_Distribition
Rscript "/home/mor/TCR_pipeline/Clonal_Size_Distribition.R" $1 $2 $3 
echo "process - Clonal_Size_Distribition"
echo "DONE!"


#CDR3_Length_distribution
Rscript "/home/mor/TCR_pipeline/CDR3_Length_distribution.R" $1 $2 $3 
echo "process - CDR3_Length_distribution"
echo "DONE!"


#VDJ_Segments_Frequencies
Rscript "/home/mor/TCR_pipeline/VDJ_Segments_Frequencies.R" $1 $2 $3
echo "process - VDJ_Segments_Frequencies"
echo "DONE!"