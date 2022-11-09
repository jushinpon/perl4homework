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
my $HW_dir = "20221019";#folder name for this Homework
my $filename = "HW5.c";#folder name for this Homework

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
	system("gcc -o grade.x $filename -lm");
	if($?){#gcc gets error!
		`echo "gcc compiling failed!" >> $HW_dir-report_$file_date.txt`;
		next;
	}
	
	#check output
	#prepare answers first! you may use loop to do it.
	my @answer =(
"rad cos",

"0 1.000000",

"1 0.540302",  

"2 -0.416147",

"3 -0.989992",

"4 -0.653644",

"5 0.283662",

"6 0.960170",

"7 0.753902",

"8 -0.145500",

"9 -0.911130",

"10 -0.839072",

"11 0.004426",

"12 0.843854",

"13 0.907447",

"14 0.136737",

"15 -0.759688",

"16 -0.957659",

"17 -0.275163",

"18 0.660317",

"19 0.988705",

"20 0.408082",

"21 -0.547729",

"22 -0.999961",

"23 -0.532833",

"24 0.424179",

"25 0.991203",

"26 0.646919",

"27 -0.292139",

"28 -0.962606",

"29 -0.748058",

"30 0.154251",

"31 0.914742",

"32 0.834223",

"33 -0.013277",

"34 -0.848570",

"35 -0.903692",

"36 -0.127964",

"37 0.765414",

"38 0.955074",

"39 0.266643",

"40 -0.666938",

"41 -0.987339",

"42 -0.399985",

"43 0.555113",

"44 0.999843",

"45 0.525322",

"46 -0.432178",

"47 -0.992335",
"",
"48 -0.640144",

"49 0.300593",

"50 0.964966",

"51 0.742154",

"52 -0.162991",
"",
"53 -0.918283",

"54 -0.829310",

"55 0.022127",

"56 0.853220",

"57 0.899867",

"58 0.119180",

"59 -0.771080",

"60 -0.952413",

"61 -0.258102",

"62 0.673507",

"63 0.985897",

"64 0.391857",

"65 -0.562454",

"66 -0.999647",

"67 -0.517770",
"",
"68 0.440143",

"69 0.993390",

"70 0.633319",

"71 -0.309023",

"72 -0.967251",

"73 -0.736193",

"74 0.171717",

"75 0.921751",

"76 0.824331",

"77 -0.030975",

"78 -0.857803",

"79 -0.895971",

"80 -0.110387",

"81 0.776686",

"82 0.949678",

"83 0.249540",

"84 -0.680023",

"85 -0.984377",

"86 -0.383698",

"87 0.569750",

"88 0.999373",

"89 0.510177",

"90 -0.448074",

"91 -0.994367",

"92 -0.626444",

"93 0.317429",

"94 0.969459",

"95 0.730174",

"96 -0.180430",

"97 -0.925148",

"98 -0.819288",

"99 0.039821",

"100 0.862319",


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
