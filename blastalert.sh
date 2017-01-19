# Script for BlastAlert
# requires .my.cnf / blastalert DB / blastresult Table

# blast against SwissProt
echo "Started blasting ..."
/home/awkologist/BioLinux/ncbi-blast-2.5.0+/bin/blastp -db swissprot -remote -query /home/awkologist/BioLinux/hydrogenases.fasta -out h2asevsswissprot.tab -outfmt '6 qseqid sgi length nident positive evalue stitle'

# print size of h2asevsswissprot.tab
date >> blastalert.txt
echo -n "Lines of BLAST Result: " | tee -a blastalert.txt
wc -l h2asevsswissprot.tab | tee -a blastalert.txt


# check for hits already in blastresult table
# print new hits on screen and into blastalert.txt file
# cp new hits to tmp file
echo "Started processing ..."
touch tmp
awk -F"\t" 'BEGIN{cmd="mysql -u awkologist -pawkology blastalert -e \"select sgi from blastresult\""; while(cmd | getline > 0){ids[$0]++}}{if(ids[$2]==0){print "New hit "$2, $7; print $0 > "tmp"}}' h2asevsswissprot.tab | tee -a blastalert.txt

# load new hits into DB
echo "Started uploading to MySQL..."
mysql -u awkologist -pawkology blastalert -e 'LOAD DATA LOCAL INFILE "tmp" INTO TABLE blastresult'
echo "---------------------------------------------------------------------" >> blastalert.txt

# remove tmp
rm tmp
