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
my $HW_dir = "20221003";#folder name for this Homework
my $filename = "HW4.c";#folder name for this Homework

unlink "$HW_dir.txt";#delete the old file 

my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "/B|/M"|sort`;#all folders with ID under /home
#my @allID_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|egrep "jsp"|sort`;#all folders with ID under /home
chomp @allID_dir;
my @all_accounts;

#get all accounts
for (@allID_dir){
	#print "$_ \n";
	my $temp = `basename $_`;# get basename of a path
	chomp $temp;
	push @all_accounts,$_;	
}

#grading and make the report
for (@allID_dir){
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
	system("gcc -o grade.x $filename");
	if($?){#gcc gets error!
		`echo "gcc compiling failed!" >> $HW_dir-report_$file_date.txt`;
		next;
	}
	
	#check output
	#prepare answers first! you may use loop to do it.
	my @answer =(
	"Year Money",
	"1 10000.000000",
    "2 10325.000000",
    "3 10660.562500",
	"4 11007.031250",
	"5 11364.759766",
	"6 11734.115234",
	"7 12115.474609",
	"8 12509.227539",
	"9 12915.777344",
	"10 13335.540039",
	"11 13768.945312",
	"12 14216.436523",
	"13 14678.470703",
	"14 15155.521484",
    "15 15648.076172",
    "16 16156.638672",
	"17 16681.730469",
	"18 17223.886719",
	"19 17783.664062",
	"20 18361.632812",
	"21 18958.386719",
	"22 19574.535156",
	"23 20210.708984",
	"24 20867.556641",
	"25 21545.751953",
	"26 22245.990234",
	"27 22968.986328",
    "28 23715.478516",
	"29 24486.232422",
	"30 25282.035156",
	"31 26103.701172",
	"32 26952.072266",
	"33 27828.015625",
	"34 28732.427734",
	"35 29666.232422",
	"36 30630.386719",
	"37 31625.875000",
	"38 32653.716797",
	"39 33714.964844",
    "40 34810.703125",
    "41 35942.050781",
	"42 37110.167969",
	"43 38316.250000",
	"44 39561.527344",
	"45 40847.277344",
	"46 42174.816406",
	"47 43545.500000",
	"48 44960.730469",
	"49 46421.957031",
	"50 47930.671875",
	"51 49488.421875",
	"52 51096.796875",
    "53 52757.445312",
    "54 54472.062500",
    "55 56242.406250",
    "56 58070.285156",
    "57 59957.570312",
    "58 61906.191406",
    "59 63918.144531",
    "60 65995.484375",
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
