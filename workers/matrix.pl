use strict;
use warnings;

my %stations;
my %samples;
my @allSamples;
my $freq;
my $sample;
my $file;
my @stations;
my $filename;
for(my $i=0; $i < $#ARGV+1; $i++){
   %samples = ();
   $filename = $ARGV[$i];
   open($file, "<", $filename)
           or die "cannot open < $ARGV[$i]: $!";
   print STDERR "$filename\n";
   while ( ! eof($file) ) {
      my $line = readline($file);
      chomp($line);
      my @s = split(',', $line);
      $sample = $s[0];
      $freq = $s[1];
      push @allSamples, $sample;
      push @{$samples{$sample}}, $freq;
   }
   print STDERR "Done reading $filename\n";
   close $file;

   foreach my $key (keys %samples){
      my @freqs = @{$samples{$key}};
      my $totalFreqs = '0';
      map {$totalFreqs += $_} @freqs;
      $samples{$key} = $totalFreqs;
   }
   print STDERR "Done summing frequencies\n";
   %{$stations{$filename}} = %samples;
}
my @uniqSamples = sort (uniq(@allSamples));

my $output = "";
$output .= sprintf "Sample\t";
foreach my $key (keys %stations){ $output .= sprintf("%10s\t",$key); }
$output .= sprintf "\n";
foreach my $sample (@uniqSamples) {
   $output .= sprintf "$sample\t";
   foreach my $station (keys %stations){
      $freq = $stations{$station}{$sample};
      if (exists $stations{$station}{$sample}) {
         $output .= sprintf("%10d\t", $freq);
      } else {
         $output .= sprintf ("%10d\t", 0);
      }
   }
   $output .= sprintf "\n";
}
print $output;
#use Data::Dumper;
#print Dumper \@uniqSamples;


sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}
