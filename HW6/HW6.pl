=b
perl 4 c homework, by Prof. Shin-Pon Ju
chown -R user: folder     --> change permission when you are grading
=cut

use warnings;
use DateTime;
use strict;
no strict 'refs';
use Cwd;
use utf8;


my $currentPath = getcwd();
my $date = `date`;
chomp $date;
my $file_date = `date +\%Y\%m\%d\%H\%M\%S`;
chomp $file_date;
my $HW_dir = "20221109_1";#folder name for this Homework
my $filename = "HW6.c";#folder name for this Homework

unlink "$HW_dir.txt";#delete the old file 

#check account usage time
my $dt = DateTime->new( year => 2022, month => 10, day => 01, hour => 16, minute => 11,
	second => 0, nanosecond => 500000000, time_zone => 'Asia/Taipei' );
my $account_check  = $dt->epoch;

my @temp_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|grep -v "Ben"|egrep "/B|/M"|sort`;#all folders with ID under /home
#my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "jsp"|sort`;#all folders with ID under /home
chomp @temp_dir;
my @all_accountpaths;
#get all accounts
for (@temp_dir){
	#print "$_ \n";
	#my $check = `stat -c ‘%y’ $_`;
	my $check = (stat($_))[9];
	chomp $check;
	#print "$check, $account_check\n";
	
	if($check > $account_check){
		chomp $_;
		push @all_accountpaths,$_;
	}
	else
	{
		my $temp = `basename $_`;# get basename of a path
		chomp $temp;
		my $dt = DateTime->from_epoch(epoch => $check);#epoch time to date
        my $date = $dt->ymd;#strftime('%Y-%s');
		#print "****The last date account has modified things is $date. $temp has no one to use it currently.\n";
	}	
}

my @all_accounts;

#get all accounts
for (@all_accountpaths){
	#print "$_ \n";
	my $temp = `basename $_`;# get basename of a path
	chomp $temp;
	push @all_accounts,$_;	
}
#die;
#grading and make the report
for (@all_accountpaths){
	my $ID = `basename $_`;# get basename of a path, currently for account name
	chomp $ID;
	`chown -R root: $_/$HW_dir`;#lock students' folder permission first
	`chmod -R 750 $_/$HW_dir`;#Let students have permission to read and download
	#`chown -R $ID: $_/$HW_dir`;#release students' folders permission
	#die;
	#system("ls $_/$HW_dir");
	`ls $_/$HW_dir`;
	if($?){#when ls gets error!
		#print "inf: $?\n";
		print "$_ has no $HW_dir folder\n";
		next;
	}
	#if folder exists
	chdir("$_/$HW_dir");
	unlink "$HW_dir-report_$file_date.txt";
	`touch $HW_dir-report_$file_date.txt`;
	`echo "$date" >> $HW_dir-report_$file_date.txt`;
	`echo "" >> $HW_dir-report_$file_date.txt`;
	####compile their code
	print "current path: $_/$HW_dir\n";	
	
######	For Halting problem
	if($ID eq "B113022030"){#gcc gets error!
		`echo "Halting problem (endless loop)!" >> $HW_dir-report_$file_date.txt`;
		next;
	}
#####
	if(-z $filename){#gcc gets error!
		`echo "empty file!" >> $HW_dir-report_$file_date.txt`;		
		next;
	}	
	system("gcc -o grade.x $filename -lm");
	if($?){#gcc gets error!
		`echo "gcc compiling failed!" >> $HW_dir-report_$file_date.txt`;
		next;
	}
	
	#check output
	#prepare answers first! you may use loop to do it.
	my @answer =(
"n area",
"100 1.007833",
"1000 1.000785",
"10000 1.000078",
"100000 0.999992"
	);	
	#my @answer =(
	#"1. Hello World!",
    #"2. Hello World!"
	#);	
	#match or not	
	my @st_ans = `./grade.x`;
	chomp @st_ans;
	my $checkid = 1;
	for my $ans (0..$#st_ans){
		if($st_ans[$ans] ne $answer[$ans]){
			$checkid = 0;#if answer is not correct, change it to 0
			#print "output is not current!\n";
			#print "$st_ans[$ans], $answer[$ans]\n";
			`echo "++++output is not correct!++++" >> $HW_dir-report_$file_date.txt`;
			`echo "" >> $HW_dir-report_$file_date.txt`;
			`echo "*Yours: $st_ans[$ans]" >> $HW_dir-report_$file_date.txt`;
			`echo "*Correct: $answer[$ans]" >> $HW_dir-report_$file_date.txt`;
			`echo "***You may have further errors, which have not been checked!" >> $HW_dir-report_$file_date.txt`;
			goto check;
		}
	}
check:
	next unless($checkid);
	
	`echo "All Good!!!" >> $HW_dir-report_$file_date.txt`;
		
}
chdir("$currentPath");
##collect all students to make a summary report in /root/Perl4homework
unlink "summary_$file_date.txt";
`touch summary_$file_date.txt`;

`echo "$date" >> summary_$file_date.txt`;
`echo "ID Result" >> summary_$file_date.txt`;
`echo "" >> summary_$file_date.txt`;
for (@all_accountpaths){
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
