=b
perl 4 c homework, by Prof. Shin-Pon Ju
chown -R user: folder     --> change permission when you are grading
=cut

use warnings;
use strict;
use Cwd;

my $currentPath = getcwd();
my $HW_dir = "c_lang123";#folder name for this Homework
unlink "$HW_dir.txt";#delete the old file 
open (my $fh4all, ">$HW_dir.txt");
#my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "/B|/M"|sort`;#all folders with ID under /home
my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "jsp"|sort`;#all folders with ID under /home
chomp @allID_dir;
my @all_accounts;

#get all accounts
for (@allID_dir){
	print "$_ \n";
	my $temp = `basename $_`;# get basename of a path
	chomp $temp;
	push @all_accounts,$_;	
}

#grading and make the report
for (@allID_dir){
	my $temp = `basename $_`;# get basename of a path, currently for account name
	chomp $temp;
	`chown -R root: $_/$HW_dir`;#lock students' folders first
	#`chown -R $temp: $_/$HW_dir`;#lock students' folders first
	#system("ls $_/$HW_dir");
	`ls $_/$HW_dir`;
	if($?){#when ls gets error!
		#print "inf: $?\n";
		print "$_ has no $HW_dir folder\n";
		next;
	}
	#if folder exists
	chdir("$_/$HW_dir");
	####check their code	
	system("ls");
	chdir("$currentPath");	
}
