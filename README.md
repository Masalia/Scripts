Scripts
=======

These are various Perl and R scripts designed and created by myself for the purpose of bioinformatic and scientific research. 

Author: 

Rishi R. Masalia,
masalia at uga dot edu,
Univ. of Georgia,
Athens, GA, 30605,
Department of Plant Biology

=======
Top_Hits.pl:

Aug. 2013
Corresponding Authors: masalia@uga.edu or jennifer.r.mandel@gmail.com

The purpose of this script is to parse a blast output for a user specified best number of hits, determined by query, evalue and identity. Once this is accomplished, it will filter through a cleaned sequence fastq (cleaned by PRINSEQ-lite) to pull out the best blast hit query and that subsequent sequence.

Command:

perl top_hits.pl <Input> <Output File> <Num. top Hits> <Cleaned Seq.fastq>

The arguments are ARGV[n] in perl and should be treated as such.

=======
