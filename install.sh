if [ -d "seqs" ]; then
  rm seqs -f -r
fi
mkdir seqs
cd seqs

echo "========================================================="
echo " Downloading from Ensembl"
echo "========================================================="
# Download fasta files of chr 1-22, X, Y, and MT
for chr in {1..22} X Y MT
do
  wget "ftp://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna.chromosome.$chr.fa.gz"
done
echo "========================================================="
echo ""

# rename fasta files 
# simply remove the prefix, e.g. Homo_sapiens.GRCh37.75.dna.chromosome.1.fa.gz ===> 1.fa.gz
rename 's/Homo_sapiens.GRCh37.75.dna.chromosome.//g' *


echo "========================================================="
echo " Extracting files"
echo "========================================================="
gunzip *.gz
echo "========================================================="
echo ""

cp ../seed_template ../seed
sed -i 's?PATH_TO_SEQS?'`pwd`'?g' ../seed

cd .. 

echo "========================================================="
echo " Forcing package"
echo "========================================================="
Rscript forge.R
echo "========================================================="
echo ""

echo "========================================================="
echo " Building package"
echo "========================================================="
R CMD build BSgenome.Sapiens.Ensembl.3775
echo "========================================================="
echo ""

echo "========================================================="
echo " Checking package"
echo "========================================================="
R CMD check BSgenome.Sapiens.Ensembl.3775_1.0.tar.gz --no-manual
echo "========================================================="
echo ""

echo "========================================================="
echo " Installing package"
echo "========================================================="
R CMD INSTALL BSgenome.Sapiens.Ensembl.3775_1.0.tar.gz 
echo "========================================================="
echo ""

rm seed
rm BSgenome.Sapiens.Ensembl.3775 -f -r
rm BSgenome.Sapiens.Ensembl.3775.Rcheck -f -r

# Notes:
# cd `echo 'cat(system.file(package="BSgenome"))' | R --vanilla --slave`
# cd pkgtemplates/BSgenome_datapkg/
# mkdir inst
# mkdir inst/extdata

