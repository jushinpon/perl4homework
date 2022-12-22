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
my $HW_dir = "20221207";#folder name for this Homework
my $filename = "HW10.c";#folder name for this Homework

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
"n area",
"100 1.007833",
"200 1.003922",
"300 1.002616",
"400 1.001962",
"500 1.001570",
"600 1.001308",
"700 1.001122",
"800 1.000981",
"900 1.000872",
"1000 1.000785",
"1100 1.000714",
"1200 1.000655",
"1300 1.000604",
"1400 1.000561",
"1500 1.000524",
"1600 1.000490",
"1700 1.000461",
"1800 1.000436",
"1900 1.000414",
"2000 1.000393",
"2100 1.000374",
"2200 1.000358",
"2300 1.000342",
"2400 1.000328",
"2500 1.000314",
"2600 1.000302",
"2700 1.000290",
"2800 1.000280",
"2900 1.000271",
"3000 1.000262",
"3100 1.000253",
"3200 1.000246",
"3300 1.000239",
"3400 1.000230",
"3500 1.000225",
"3600 1.000218",
"3700 1.000213",
"3800 1.000206",
"3900 1.000202",
"4000 1.000196",
"4100 1.000192",
"4200 1.000186",
"4300 1.000184",
"4400 1.000178",
"4500 1.000175",
"4600 1.000171",
"4700 1.000166",
"4800 1.000163",
"4900 1.000160",
"5000 1.000157",
"5100 1.000154",
"5200 1.000152",
"5300 1.000147",
"5400 1.000145",
"5500 1.000143",
"5600 1.000141",
"5700 1.000137",
"5800 1.000136",
"5900 1.000134",
"6000 1.000130",
"6100 1.000128",
"6200 1.000126",
"6300 1.000125",
"6400 1.000123",
"6500 1.000120",
"6600 1.000119",
"6700 1.000116",
"6800 1.000116",
"6900 1.000114",
"7000 1.000113",
"7100 1.000112",
"7200 1.000109",
"7300 1.000107",
"7400 1.000105",
"7500 1.000105",
"7600 1.000103",
"7700 1.000102",
"7800 1.000102",
"7900 1.000100",
"8000 1.000098",
"8100 1.000096",
"8200 1.000097",
"8300 1.000095",
"8400 1.000092",
"8500 1.000091",
"8600 1.000090",
"8700 1.000090",
"8800 1.000089",
"8900 1.000089",
"9000 1.000087",
"9100 1.000087",
"9200 1.000085",
"9300 1.000086",
"9400 1.000085",
"9500 1.000083",
"9600 1.000082",
"9700 1.000082",
"9800 1.000081",
"9900 1.000081",
"10000 1.000078",
"10100 1.000077",
"10200 1.000078",
"10300 1.000076",
"10400 1.000077",
"10500 1.000076",
"10600 1.000074",
"10700 1.000074",
"10800 1.000072",
"10900 1.000074",
"11000 1.000073",
"11100 1.000070",
"11200 1.000071",
"11300 1.000069",
"11400 1.000070",
"11500 1.000069",
"11600 1.000069",
"11700 1.000065",
"11800 1.000066",
"11900 1.000066",
"12000 1.000065",
"12100 1.000066",
"12200 1.000064",
"12300 1.000064",
"12400 1.000063",
"12500 1.000061",
"12600 1.000061",
"12700 1.000062",
"12800 1.000062",
"12900 1.000062",
"13000 1.000060",
"13100 1.000062",
"13200 1.000057",
"13300 1.000056",
"13400 1.000060",
"13500 1.000059",
"13600 1.000059",
"13700 1.000059",
"13800 1.000058",
"13900 1.000057",
"14000 1.000054",
"14100 1.000056",
"14200 1.000057",
"14300 1.000057",
"14400 1.000055",
"14500 1.000051",
"14600 1.000055",
"14700 1.000055",
"14800 1.000054",
"14900 1.000055",
"15000 1.000054",
"15100 1.000051",
"15200 1.000054",
"15300 1.000048",
"15400 1.000051",
"15500 1.000050",
"15600 1.000049",
"15700 1.000050",
"15800 1.000052",
"15900 1.000045",
"16000 1.000050",
"16100 1.000051",
"16200 1.000050",
"16300 1.000051",
"16400 1.000050",
"16500 1.000048",
"16600 1.000047",
"16700 1.000049",
"16800 1.000048",
"16900 1.000044",
"17000 1.000046",
"17100 1.000046",
"17200 1.000046",
"17300 1.000043",
"17400 1.000045",
"17500 1.000046",
"17600 1.000041",
"17700 1.000047",
"17800 1.000044",
"17900 1.000042",
"18000 1.000044",
"18100 1.000045",
"18200 1.000046",
"18300 1.000044",
"18400 1.000041",
"18500 1.000040",
"18600 1.000045",
"18700 1.000041",
"18800 1.000045",
"18900 1.000039",
"19000 1.000043",
"19100 1.000044",
"19200 1.000041",
"19300 1.000036",
"19400 1.000036",
"19500 1.000035",
"19600 1.000041",
"19700 1.000043",
"19800 1.000041",
"19900 1.000037",
"20000 1.000041"
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
