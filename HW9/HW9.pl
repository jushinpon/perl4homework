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
my $HW_dir = "20221123";#folder name for this Homework
my $filename = "HW9.c";#folder name for this Homework

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
"term Pi",
"500 3.139593",
"1000 3.140593",
"1500 3.140924",
"2000 3.141090",
"2500 3.141193",
"3000 3.141260",
"3500 3.141310",
"4000 3.141345",
"4500 3.141375",
"5000 3.141397",
"5500 3.141416",
"6000 3.141432",
"6500 3.141446",
"7000 3.141457",
"7500 3.141465",
"8000 3.141472",
"8500 3.141479",
"9000 3.141486",
"9500 3.141493",
"10000 3.141499",
"10500 3.141503",
"11000 3.141508",
"11500 3.141512",
"12000 3.141516",
"12500 3.141521",
"13000 3.141523",
"13500 3.141526",
"14000 3.141530",
"14500 3.141531",
"15000 3.141533",
"15500 3.141534",
"16000 3.141537",
"16500 3.141538",
"17000 3.141539",
"17500 3.141541",
"18000 3.141542",
"18500 3.141543",
"19000 3.141545",
"19500 3.141546",
"20000 3.141547",
"20500 3.141549",
"21000 3.141550",
"21500 3.141551",
"22000 3.141551",
"22500 3.141552",
"23000 3.141553",
"23500 3.141555",
"24000 3.141556",
"24500 3.141556",
"25000 3.141557",
"25500 3.141558",
"26000 3.141559",
"26500 3.141560",
"27000 3.141560",
"27500 3.141561",
"28000 3.141562",
"28500 3.141562",
"29000 3.141563",
"29500 3.141563",
"30000 3.141564",
"30500 3.141565",
"31000 3.141565",
"31500 3.141566",
"32000 3.141567",
"32500 3.141567",
"33000 3.141568",
"33500 3.141568",
"34000 3.141569",
"34500 3.141570",
"35000 3.141570",
"35500 3.141570",
"36000 3.141570",
"36500 3.141570",
"37000 3.141570",
"37500 3.141570",
"38000 3.141571",
"38500 3.141571",
"39000 3.141571",
"39500 3.141571",
"40000 3.141571",
"40500 3.141572",
"41000 3.141572",
"41500 3.141572",
"42000 3.141573",
"42500 3.141573",
"43000 3.141573",
"43500 3.141573",
"44000 3.141573",
"44500 3.141574",
"45000 3.141574",
"45500 3.141575",
"46000 3.141575",
"46500 3.141575",
"47000 3.141575",
"47500 3.141575",
"48000 3.141575",
"48500 3.141576",
"49000 3.141576",
"49500 3.141576",
"50000 3.141576",
"50500 3.141576",
"51000 3.141576",
"51500 3.141576",
"52000 3.141576",
"52500 3.141577",
"53000 3.141577",
"53500 3.141577",
"54000 3.141577",
"54500 3.141578",
"55000 3.141578",
"55500 3.141578",
"56000 3.141578",
"56500 3.141579",
"57000 3.141579",
"57500 3.141579",
"58000 3.141579",
"58500 3.141579",
"59000 3.141579",
"59500 3.141580",
"60000 3.141580",
"60500 3.141580",
"61000 3.141580",
"61500 3.141580",
"62000 3.141581",
"62500 3.141581",
"63000 3.141581",
"63500 3.141581",
"64000 3.141581",
"64500 3.141581",
"65000 3.141581",
"65500 3.141582",
"66000 3.141582",
"66500 3.141582",
"67000 3.141582",
"67500 3.141582",
"68000 3.141582",
"68500 3.141582",
"69000 3.141582",
"69500 3.141582",
"70000 3.141582",
"70500 3.141582",
"71000 3.141582",
"71500 3.141582",
"72000 3.141582",
"72500 3.141582",
"73000 3.141583",
"73500 3.141583",
"74000 3.141583",
"74500 3.141583",
"75000 3.141583",
"75500 3.141583",
"76000 3.141583",
"76500 3.141583",
"77000 3.141583",
"77500 3.141583",
"78000 3.141583",
"78500 3.141583",
"79000 3.141583",
"79500 3.141583",
"80000 3.141584",
"80500 3.141584",
"81000 3.141584",
"81500 3.141584",
"82000 3.141584",
"82500 3.141584",
"83000 3.141584",
"83500 3.141584",
"84000 3.141584",
"84500 3.141584",
"85000 3.141584",
"85500 3.141584",
"86000 3.141584",
"86500 3.141584",
"87000 3.141585",
"87500 3.141585",
"88000 3.141585",
"88500 3.141585",
"89000 3.141585",
"89500 3.141585",
"90000 3.141585",
"90500 3.141585",
"91000 3.141585",
"91500 3.141585",
"92000 3.141585",
"92500 3.141585",
"93000 3.141585",
"93500 3.141585",
"94000 3.141585",
"94500 3.141585",
"95000 3.141586",
"95500 3.141586",
"96000 3.141586",
"96500 3.141586",
"97000 3.141586",
"97500 3.141586",
"98000 3.141586",
"98500 3.141586",
"99000 3.141586",
"99500 3.141586",
"100000 3.141586"
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
