#!/usr/bin/perl
use strict;
use warnings;

my %lookup = ();
my @cnv;

my $cell_line_file = "/Users/agulati/Desktop/lookup_mutation_table/intercell_cell_lines.txt";
my $gene_file = "/Users/agulati/Desktop/lookup_mutation_table/genes.txt";
#open FILESTOPROC, "> $intercell_cell_lines" or die "Can't write file $intercell_cell_lines: $!\n";  
my $cnv_file = "/Users/agulati/Desktop/lookup_mutation_table/processed_CosmicCLPv76_cnv_data_160418.details.txt";
my $mut_file = "/Users/agulati/Desktop/lookup_mutation_table/processed_cosmic_exome_160418.details.txt";
my $exprn_file = "/Users/agulati/Desktop/lookup_mutation_table/processed_WTSI_exprn_data_160418.details.txt";

my %cell_line_h = (); 
  
my @cell_lines;
open(CL, "< $cell_line_file") || die "Can't find file $!";
    while(<CL>){
       @cell_lines=$_;
       chomp @cell_lines;
       $cell_line_h{ $cell_lines[0] } = 2;
    }
close(CL);

my %gene_h = ();

my @genes;
open(GENE, "< $gene_file") || die "Can't find file $!";
    while(<GENE>){
       @genes=$_;
      chomp @genes;
      $gene_h { $genes[0] } = 3;
    }
close(GENE);

@genes = keys %gene_h;
@cell_lines = keys %cell_line_h;

open(CNV, "< $cnv_file") || die "Can't find file $!";
    while(<CNV>){
      chomp $_;
      if($_ =~ /^cell_line/){
        next;
      }
       @cnv=split(/\t/, $_);
       $lookup{$cnv[0].$cnv[1]}=$cnv[5].$cnv[6];
    }
close(CNV);

print @cnv;
print @genes;
print @cell_lines;

my $cell_line;
my $gene;
open OUT, "> /Users/agulati/Desktop/lookup_mutation_table/output.txt"; 
foreach $cell_line ( @cell_lines ) {
  print OUT "$cell_line\t";
  foreach $gene ( @genes ) {
    if ( exists ( $lookup{$cell_line.$gene} ) ) {
      print OUT "$lookup{$cnv[0].$cnv[1]}\t"; 
    }
    else {
      print OUT "NA\t";
    }
  }
  print OUT "\n";
}
close OUT;







