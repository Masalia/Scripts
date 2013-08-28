###################
#Author: Rishi R. Masalia, Burke Lab, Dept. Plant Biology, Univ. of Georgia
#Email: masalia@uga.edu
#August 2013
#
#Purpose: To take a blast output and parse the information for a best hit(s) determined by evalue and percent identity, print the output. Currently, this script is modified to fit into an IPlant Pipeline, the steps for this are labeled in the script. For this, once the blast output is parsed, only the query name is taken and compared to an origianl source file to extract query and sequence information from a cleaned Illumina sequence file. 
#
#Commands: perl top_hits.pl <in_file> <out_file> <# of hits wanted> <Cleaned Sequence File>
#
####################
#use strict;
use 5.14.1

my $in = $ARGV[0];
my $out = $ARGV[1];
my $hits = $ARGV[2];
open (OUT, ">$out"); #Normally, outfile for parsed best hit(s), but now co-opted for matching the query to the cleaned/trimmed sequences generated after PRINSEQ-lite 

### Open the blast file and get the corresponding number of hits, deteremined by evalue and percent identity ###

my %blasthash = ();
open (INFILE, $in);
while (<INFILE>){
        chomp();
        my $line = $_;
        my @row = split(/\t/,$line);
        my $query = $row[0];
        my $identity = $row[3];
        my $evalue = $row[10];
        $blasthash{$query}{$evalue}{$identity} = $line;
}
close IN;

### Get the # of top hits, by sorting query, evalue and identity ### 
%OrigSeqhash = ();
foreach my $query (sort keys %blasthash){
        my $hits_count = 0;
        foreach my $evalue (sort {$a<=>$b} keys %{$blasthash{$query}}){
                foreach my $identity (sort {$b<=>$a} keys %{$blasthash{$query}{$evalue}}){
                        if ($hits_count < $hits){
                        #print OUT "$blasthash{$query}{$evalue}{$identity}\n"; #Original line, prints the whole line of the best hit(s) to an outfile
                        $OrigSeqhash{$query} = 1; # puts the query into a hash, to be filtered through later
                        }
                my $hits_count++;
                }
        }
}

#print "$_\n" for keys %OrigSeqhash;
#close OUT;

### Match the query hash with original trimmed file to pull out query and sequence ###

my $cleanseq = $ARGV[3];
open (TRIMMED, $cleanseq);
while(<TRIMMED>){
        chomp();
        $line = $_;
        $part1 = $line;
        $part1 =~ s/\>//g;
        $part1 =~ s/\s.*//g;
        #print "$part1\n";
        $n = 1 if ($OrigSeqhash{$part1});
                if ($n >=1 and $n <=3){
                        print OUT "$line\n";
                        $n++;
                }
}

exit;
