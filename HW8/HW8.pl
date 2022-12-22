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
my $HW_dir = "20221116";#folder name for this Homework
my $filename1 = "HW8.c";#folder name for this Homework
my $filename2 = "area.c";#folder name for this Homework

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
	system("gcc -o grade.x $filename1 $filename2 -lm");
	if($?){#gcc gets error!
		`echo "gcc compiling failed!" >> $HW_dir-report_$file_date.txt`;
		next;
	}
	
	#check output
	#prepare answers first! you may use loop to do it.
	my @answer =(
"n area",
"100 1.007834",
"200 1.003922",
"300 1.002616",
"400 1.001962",
"500 1.001570",
"600 1.001309",
"700 1.001122",
"800 1.000982",
"900 1.000873",
"1000 1.000785",
"1100 1.000715",
"1200 1.000654",
"1300 1.000604",
"1400 1.000561",
"1500 1.000523",
"1600 1.000491",
"1700 1.000462",
"1800 1.000436",
"1900 1.000413",
"2000 1.000393",
"2100 1.000374",
"2200 1.000357",
"2300 1.000342",
"2400 1.000328",
"2500 1.000314",
"2600 1.000302",
"2700 1.000292",
"2800 1.000281",
"2900 1.000271",
"3000 1.000263",
"3100 1.000254",
"3200 1.000246",
"3300 1.000238",
"3400 1.000232",
"3500 1.000225",
"3600 1.000219",
"3700 1.000213",
"3800 1.000207",
"3900 1.000202",
"4000 1.000197",
"4100 1.000191",
"4200 1.000187",
"4300 1.000183",
"4400 1.000179",
"4500 1.000175",
"4600 1.000171",
"4700 1.000168",
"4800 1.000164",
"4900 1.000160",
"5000 1.000158",
"5100 1.000154",
"5200 1.000151",
"5300 1.000148",
"5400 1.000144",
"5500 1.000142",
"5600 1.000141",
"5700 1.000139",
"5800 1.000135",
"5900 1.000134",
"6000 1.000131",
"6100 1.000130",
"6200 1.000127",
"6300 1.000124",
"6400 1.000124",
"6500 1.000121",
"6600 1.000120",
"6700 1.000119",
"6800 1.000116",
"6900 1.000116",
"7000 1.000113",
"7100 1.000112",
"7200 1.000109",
"7300 1.000109",
"7400 1.000107",
"7500 1.000106",
"7600 1.000103",
"7700 1.000103",
"7800 1.000103",
"7900 1.000101",
"8000 1.000099",
"8100 1.000097",
"8200 1.000097",
"8300 1.000095",
"8400 1.000094",
"8500 1.000094",
"8600 1.000092",
"8700 1.000091",
"8800 1.000091",
"8900 1.000089",
"9000 1.000089",
"9100 1.000088",
"9200 1.000087",
"9300 1.000085",
"9400 1.000085",
"9500 1.000084",
"9600 1.000083",
"9700 1.000082",
"9800 1.000081",
"9900 1.000080",
"10000 1.000080",
"10100 1.000078",
"10200 1.000078",
"10300 1.000078",
"10400 1.000076",
"10500 1.000075",
"10600 1.000075",
"10700 1.000075",
"10800 1.000075",
"10900 1.000073",
"11000 1.000073",
"11100 1.000071",
"11200 1.000071",
"11300 1.000070",
"11400 1.000070",
"11500 1.000069",
"11600 1.000069",
"11700 1.000068",
"11800 1.000067",
"11900 1.000067",
"12000 1.000067",
"12100 1.000066",
"12200 1.000065",
"12300 1.000065",
"12400 1.000065",
"12500 1.000064",
"12600 1.000063",
"12700 1.000062",
"12800 1.000062",
"12900 1.000062",
"13000 1.000061",
"13100 1.000062",
"13200 1.000062",
"13300 1.000064",
"13400 1.000060",
"13500 1.000060",
"13600 1.000062",
"13700 1.000060",
"13800 1.000059",
"13900 1.000059",
"14000 1.000059",
"14100 1.000058",
"14200 1.000059",
"14300 1.000057",
"14400 1.000057",
"14500 1.000057",
"14600 1.000056",
"14700 1.000055",
"14800 1.000056",
"14900 1.000056",
"15000 1.000056",
"15100 1.000055",
"15200 1.000054",
"15300 1.000054",
"15400 1.000053",
"15500 1.000053",
"15600 1.000053",
"15700 1.000053",
"15800 1.000052",
"15900 1.000052",
"16000 1.000052",
"16100 1.000051",
"16200 1.000051",
"16300 1.000051",
"16400 1.000050",
"16500 1.000050",
"16600 1.000050",
"16700 1.000050",
"16800 1.000049",
"16900 1.000050",
"17000 1.000049",
"17100 1.000048",
"17200 1.000048",
"17300 1.000048",
"17400 1.000048",
"17500 1.000048",
"17600 1.000047",
"17700 1.000047",
"17800 1.000047",
"17900 1.000046",
"18000 1.000046",
"18100 1.000046",
"18200 1.000046",
"18300 1.000046",
"18400 1.000045",
"18500 1.000045",
"18600 1.000045",
"18700 1.000045",
"18800 1.000045",
"18900 1.000044",
"19000 1.000044",
"19100 1.000044",
"19200 1.000043",
"19300 1.000043",
"19400 1.000043",
"19500 1.000043",
"19600 1.000043",
"19700 1.000042",
"19800 1.000042",
"19900 1.000041",
"20000 1.000042"
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
