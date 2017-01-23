# requires: hydrogenases.fasta; .my.cnf; table blastresult
# Blast gegen SwissProt
echo "Starte BLAST ..."
/home/awkologist/BioLinux/ncbi-blast-2.5.0+/bin/blastp -db swissprot -remote -query /home/awkologist/BioLinux/hydrogenases.fasta -out h2ase-vs-swissprot.tab -outfmt '6 qseqid sgi length nident positive evalue stitle'
# Print date
date >> blastalert.txt
# Zähle Treffer
echo -n "Treffer bei BLAST:" | tee -a blastalert.txt
wc -l h2ase-vs-swissprot.tab | tee -a blastalert.txt
# Check if IDs in MySQL DB
echo "Starte Analyse ..."
touch tmp
awk -F"\t" 'BEGIN{c=0;cmd="mysql -u awkologist -pawkology blastalert -e \"select * from blastresult;\""; while(cmd | getline > 0){id[$2]++}}{if(id[$2]==0){c++;print $2" ist neu: "$7; print $0 > "tmp"}}END{print c" neue Sequenzen"}' h2ase-vs-swissprot.tab | tee -a blastalert.txt
echo "----------------------------" >> blastalert.txt
# Write new hits into MySQL
echo "Lade Daten ..."
mysql -u awkologist -pawkology blastalert -e "load data local infile 'tmp' into table blastresult;"
rm tmp
