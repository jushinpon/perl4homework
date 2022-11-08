=b
perl 4 c homework, by Prof. Shin-Pon Ju
chown -R user: folder     --> change permission when you are grading
=cut

use warnings;
use strict;
use Cwd;

my $currentPath = getcwd();
my $HW_dir = "midterm";#folder name for this Homework
my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "/B|/M"|sort`;#all folders with ID under /home

chomp @allID_dir;

#grading and make the report
for (@allID_dir){
	my $ID = `basename $_`;# get basename of a path, currently for account name
	chomp $ID;
	#`chown -R root: $_/$HW_dir`;#lock students' folder permission first
	`chmod -R 740 $_/$HW_dir`;#Let students have permission to read and download
	
	`chown -R root: $_/$HW_dir`;#release students' folders permission
		
}
