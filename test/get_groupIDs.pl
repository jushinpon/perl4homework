use strict;
use warnings;

my $output = "Group103AIDs.txt";
my @name = `cat MEME103A.csv|awk -F"," '{print \$3}'`;
chomp @name;
my @id = `cat MEME103A.csv|awk -F"," '{print \$2}'`;
chomp @id;
my %name2id;
for (0..$#name){
	my $temp = $name[$_];
	my $temp1 = $id[$_];
	print "id: $temp1\n";
	$name2id{$temp} = $temp1;
}

my @nameG = `cat MEME103A_groups.csv`;
chomp @nameG;

open(DATA, ">$output");
for (@nameG){
	my @temp = split(/,/, $_);
	chomp @temp;
	my @final;
	for my $n (@temp){
		if (exists $name2id{$n}){
			print "1. \"$n test\"\n";
			print DATA "$name2id{$n} ";
			print "2. $n\n";
		}
	}
	print DATA "\n";
}

close(DATA);
