=b
perl 4 c homework, by Prof. Shin-Pon Ju
chown -R user: folder     --> change permission when you are grading
=cut

use warnings;
use strict;
use Cwd;

my $currentPath = getcwd();
my $date = `date`;
chomp $date;
my $file_date = `date +\%Y\%m\%d\%H\%M\%S`;
chomp $file_date;
my $HW_dir = "20230914";#folder name for this Homework
my $filename = "HelloWorld.c";#folder name for this Homework
my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "/B|/M"|sort`;#all folders with ID under /home

chomp @allID_dir;

#grading and make the report
for (@allID_dir){
	my $ID = `basename $_`;# get basename of a path, currently for account name
	chomp $ID;
	print "$ID\n";
	`chown -R root: $_/$HW_dir`;#lock students' folder permission first
	`chmod -R 755  $_/$HW_dir`;#Let students have permission to read and download
	`ls $_/$HW_dir`;
    if($?){#when ls gets error!
	#print "inf: $?\n";
	print "$_ has no $HW_dir folder\n";
	next;
    }
	chdir("$_/$HW_dir");
	unlink "$HW_dir-report_$file_date.txt";
	`touch $HW_dir-report_$file_date.txt`;
	`echo "$date" >> $HW_dir-report_$file_date.txt`;
	`echo "" >> $HW_dir-report_$file_date.txt`;
	my $filecount = 0; 
	for my $i(1..3){
		# print "$i";
		`find /home/$ID/$HW_dir/test0$i`;
		if($?){
		`echo "no test0$i files" >> $HW_dir-report_$file_date.txt`;
		}
		else{
			$filecount++;
		}
	}
	`find /home/$ID/$HW_dir/test01/HelloWorld.c`;
	if($?){
		`echo "no HelloWorld.c files" >> $HW_dir-report_$file_date.txt`;
		}
	else{if($filecount==3){
		`echo "All Done!" >> $HW_dir-report_$file_date.txt`;
		next;
	}
	}
	#`chown -R $ID: $_/$HW_dir`;#release students' folders permission
		
}
chdir("$currentPath");
unlink "summary_$file_date.txt";
`touch summary_$file_date.txt`;

`echo "$date" >> summary_$file_date.txt`;
`echo "ID Result" >> summary_$file_date.txt`;
`echo "" >> summary_$file_date.txt`;

for (@allID_dir){
	my $ID = `basename $_`;# get basename of a path, currently for account name
	chomp $ID;
	my $temp = 0;
	system("ls $_/$HW_dir/$HW_dir-report_$file_date.txt");
	if($?){
		`echo "$ID X, no homework files" >> summary_$file_date.txt`;
		next;
	}
	$temp = `cat $_/$HW_dir/$HW_dir-report_$file_date.txt|grep All`;
	chomp $temp;
	print "\$temp: $temp\n";
	if($temp){
		`echo "$ID O" >> summary_$file_date.txt`;
	}
	else{
		`echo "$ID X" >> summary_$file_date.txt`;
	}
}
print "\n###Remeber to set correct permission to all files using permission_change.pl if needed.\n";