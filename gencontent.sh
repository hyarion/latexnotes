#!/usr/loca/bin/bash

NOTES=`ls notes/*.tex`

for i in $NOTES
do
	echo \\input{$i} >> notes.tex
	echo \\clearpage >> notes.tex
done

