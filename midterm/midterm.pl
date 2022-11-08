=b
perl 4 midterm exam, by Prof. Shin-Pon Ju
chown -R user: folder     --> change permission when you are grading
=cut

use warnings;
use strict;
use Cwd;

#setting some infomation
my $currentPath = getcwd();
my $date = `date`;#get date
chomp $date;
my $file_date = `date +\%Y\%m\%d\%H\%M\%S`;#get date with time
chomp $file_date;

my $answer_dir = "output4test";#folder name for all folders with output.txt
my $groupInfo = "Group4test.txt";# group with all corresponding student IDs

####prepare answers here
my @answer_dir = `find ./$answer_dir  -maxdepth 1 -mindepth 1 -type d -name "*"`;#all folders with the answer file (output.txt)
chomp @answer_dir;
my %answers;
for (@answer_dir){
	my $basename = `basename $_`;
	my @answer = 
	print "$_\n";
}
die;

my @temp = `cat ../output4test/output_all.txt|grep -v '^\$'`;#remove blank
chomp @temp;
  
#$answers->{For_All} = 
#
#
#########
#my $filename = "HW4.c";#folder name for this Homework
#
#unlink "$HW_dir.txt";#delete the old file 
#
#
#
#
#my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "/B|/M"|sort`;#all folders with ID under /home
##my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "jsp"|sort`;#all folders with ID under /home
#chomp @allID_dir;
#my @all_accounts;
#
##get all accounts
#for (@allID_dir){
#	#print "$_ \n";
#	my $temp = `basename $_`;# get basename of a path
#	chomp $temp;
#	push @all_accounts,$_;	
#}
#
##grading and make the report
#for (@allID_dir){
#	my $ID = `basename $_`;# get basename of a path, currently for account name
#	chomp $ID;
#	`chown -R root: $_/$HW_dir`;#lock students' folder permission first
#	`chmod -R 750 $_/$HW_dir`;#Let students have permission to read and download
#	#`chown -R $ID: $_/$HW_dir`;#release students' folders permission
#	#die;
#	#system("ls $_/$HW_dir");
#	`ls $_/$HW_dir`;
#	if($?){#when ls gets error!
#		#print "inf: $?\n";
#		print "$_ has no $HW_dir folder\n";
#		next;
#	}
#	#if folder exists
#	chdir("$_/$HW_dir");
#	unlink "$HW_dir-report_$file_date.txt";
#	`touch $HW_dir-report_$file_date.txt`;
#	`echo "$date" >> $HW_dir-report_$file_date.txt`;
#	`echo "" >> $HW_dir-report_$file_date.txt`;
#	####compile their code	
#	system("gcc -o grade.x $filename");
#	if($?){#gcc gets error!
#		`echo "gcc compiling failed!" >> $HW_dir-report_$file_date.txt`;
#		next;
#	}
#		
#	#my @answer =(
#	#"1. Hello World!",
#    #"2. Hello World!"
#	#);	
#	#match or not	
#	my @st_ans = `./grade.x`;
#	chomp @st_ans;
#	my $checkid = 1;
#	for my $ans (0..$#st_ans){
#		if($st_ans[$ans] ne $answer[$ans]){
#			$checkid = 0;#if answer is not correct, change it to 0
#			#print "output is not current!\n";
#			#print "$st_ans[$ans], $answer[$ans]\n";
#			`echo "++++output is not correct!++++" >> $HW_dir-report_$file_date.txt`;
#			`echo "" >> $HW_dir-report_$file_date.txt`;
#			`echo "*Yours: $st_ans[$ans]" >> $HW_dir-report_$file_date.txt`;
#			`echo "*Correct: $answer[$ans]" >> $HW_dir-report_$file_date.txt`;
#			`echo "***You may have further errors, which have not been checked!" >> $HW_dir-report_$file_date.txt`;
#			goto check;
#		}
#	}
#check:
#	next unless($checkid);
#	
#	`echo "All Good!!!" >> $HW_dir-report_$file_date.txt`;
#		
#}
#chdir("$currentPath");
###collect all students to make a summary report in /root/Perl4homework
#unlink "summary_$file_date.txt";
#`touch summary_$file_date.txt`;
#
#`echo "$date" >> summary_$file_date.txt`;
#`echo "ID Result" >> summary_$file_date.txt`;
#`echo "" >> summary_$file_date.txt`;
#for (@allID_dir){
#	my $ID = `basename $_`;# get basename of a path, currently for account name
#	chomp $ID;
#	my $temp = 0;
#	system("ls $_/$HW_dir/$HW_dir-report_$file_date.txt");
#	if($?){
#		`echo "$ID X, no homework files" >> summary_$file_date.txt`;
#		next;
#	}
#	$temp = `cat $_/$HW_dir/$HW_dir-report_$file_date.txt|grep All`;
#	chomp $temp;
#	print "\$temp: $temp\n";
#	if($temp){
#		`echo "$ID O" >> summary_$file_date.txt`;
#	}
#	else{
#		`echo "$ID X" >> summary_$file_date.txt`;
#	}
#}
#
#print "\n###Remeber to set correct permission to all files using permission_change.pl if needed.\n";
#
