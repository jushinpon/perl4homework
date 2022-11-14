#dnf install perl-App-cpanminus* --> install cpanm

#(base) [root@MEME103 group_6]# stat -c ‘%y’ group_6.c
#‘2022-11-03 20:30:12.703822647 +0800’

#find /path ! -newermt "YYYY-MM-DD HH:MM:SS" | xargs rm -rf
#use DateTime;
#my $dt = DateTime->from_epoch(epoch => $unix_timestamp);
#print $dt->strftime('%Y-%s');#https://perldoc.perl.org/functions/stat (The epoch was at 00:00 January 1, 1970 GMT.)
#use DateTime;
#$dt = DateTime->new( year => 1974, month => 11, day => 30, hour => 13, minute => 30,
#	second => 0, nanosecond => 500000000, time_zone => 'Asia/Taipei' );
#$epoch_time  = $dt->epoch;

#If you can use anything else than perl, I would recommend diff(1) or comm(1)
use warnings;
use DateTime;
use strict;
no strict 'refs';
use Cwd;
use utf8;

my $score_over = 85;#
#create keys 
my %exam_dis;#exam distribution
$exam_dis{For_All} = [];
for (1..6){
	chomp;
	my $temp = "group_"."$_";
	$exam_dis{$temp} = [];
}
#print (keys %exam_dis);
my $currentPath = getcwd();
my $date = `date`;
chomp $date;
my $file_date = `date +\%Y\%m\%d\%H\%M\%S`;
chomp $file_date;

my $check_fold = "midterm";#folder name for this Homework

#check file modified time
my $test_dt = DateTime->new( year => 2022, month => 11, day => 02, hour => 16, minute => 11,
	second => 0, nanosecond => 500000000, time_zone => 'Asia/Taipei' );
my $test_end  = $test_dt->epoch;

#check account usage time
my $dt = DateTime->new( year => 2022, month => 10, day => 01, hour => 16, minute => 11,
	second => 0, nanosecond => 500000000, time_zone => 'Asia/Taipei' );
my $account_check  = $dt->epoch;

my @temp_dir = `find /home  -maxdepth 1 -mindepth 1 -type d -name "*"|grep -v Ben|egrep "/B|/M"|sort`;#all folders with ID under /home
chomp @temp_dir;
my @all_accounts;
#get all accounts
for (@temp_dir){
	#print "$_ \n";
	#my $check = `stat -c ‘%y’ $_`;
	my $check = (stat($_))[9];
	chomp $check;
	#print "$check, $account_check\n";
	
	if($check > $account_check){
		chomp $_;
		push @all_accounts,$_;
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
unlink "./summary.txt";

`touch summary.txt`;
`echo $date >> ./summary.txt`;
`echo "==Folder check==" >> ./summary.txt`;
for (@all_accounts){
	chomp;	
	my $ID = `basename $_`;# get basename of a path, currently for account name
	chomp $ID;
	my @temp = `ls $_/$check_fold`;
	chomp @temp;		
	unless(@temp){#when ls gets error!
		#print "inf: $?\n";
		`echo "***$ID has no $check_fold folder" >> ./summary.txt`;
	}
	else{#collect exam info
		for my $test (@temp){
			unless(exists $exam_dis{$test}){
				`echo "$ID has bad foldername $test" >> ./summary.txt`;
			}
			else{
				push @{$exam_dis{$test}},$ID;
				#print "$test,
			}
		}		
	}
}
`echo " " >> ./summary.txt`;

`echo "==Exam distribution==" >> ./summary.txt`;
`echo "Check exam_dist.txt for details" >> ./summary.txt`;
open (my $fh, "> exam_dist.txt");
for (sort keys %exam_dis){
	#print "key: $_\n";
	my @temp = @{$exam_dis{$_}};
	my $number = @temp;
	`echo "*$_: $number" >> ./summary.txt`;
	print $fh "***$_\n";
	for my $i (1..@temp){
		print $fh "$exam_dis{$_}->[$i-1] ";
		if($i%8 == 0 or $i == $number){print $fh "\n";}
	}		
}
close($fh);

`echo " " >> ./summary.txt`;

`echo "*****Similarity Check" >> ./summary.txt`;

for my $key (sort keys %exam_dis){
	chomp $key;
	`echo "*$key" >> ./summary.txt`;
	my @temp = @{$exam_dis{$key}};
	my $number = @temp;	
	for my $i (0..$#temp-1){
				
		for my $j ($i+1..$#temp){
			my $ifile = "/home/$exam_dis{$key}->[$i]/$check_fold/$key/$key.c";
			#print "\$ifile: $ifile,$i\n";			
			#unless (-e $ifile){
			#	`echo "*$exam_dis{$key}->[$i] does not have $key.c" >> ./summary.txt`;				
			#}
			my $jfile = "/home/$exam_dis{$key}->[$j]/$check_fold/$key/$key.c";
			#print "\$jfile: $jfile,$j\n";
			#if (!-e $jfile and $j == $#temp){
			#	`echo "*$exam_dis{$key}->[$j] does not have $key.c" >> ./summary.txt`;
			#	#`echo "*$exam_dis{$key}->[$j] does not have $key.c" >> ./summary.txt`;				
			#}
			
		if((!-z $ifile and -f $ifile) and (!-z $jfile and -f $jfile)){	
			if (-e $ifile and -e $jfile){
				#Text::Similarity::Overlaps
				my @itemp = `cat $ifile`;
				chomp @itemp;
				#my @ifile = grep {$_!~m{^\s*$|^\s*//}} @itemp;
				my @ifile1 = grep (($_!~m{^\s*$|^\s*\/\/|^\s*#|main}), @itemp);
				chomp @ifile1;
				my @ifile;
				for my $if (@ifile1){
					$if =~ s/^\s+|\s+$//;
					$if =~ s/^{|^}//;
					$if =~ s/^\s+|\s+$//;
					if($if ne ""){
						#print "if: $if\n";
						push @ifile, $if;
					}					
				}
								
				my @jtemp = `cat $jfile`;
				chomp @jtemp;
				my @jfile1 = grep (($_!~m{^\s*$|^\s*\/\/|^\s*#|main}),@jtemp);
				chomp @jfile1;
				
				my @jfile;
				for my $if (@jfile1){
					$if =~ s/^\s+|\s+$//;
					$if =~ s/^{|^}//;
					$if =~ s/^\s+|\s+$//;
					if($if ne ""){
						push @jfile, $if;
					}					
				}				
# j to i check				
				my %ifile = map {$_ => 1} @ifile;
				
				my @keys = keys %ifile;
				my $allNo = @keys;				
				my $score = 0;
				my @dup;
				for my $dup (@jfile){
					 chomp $dup;
					 if (exists $ifile{$dup}){						 
						 $score++;
						 push @dup, $dup;
					 };
				}
				
				if($allNo == 0){
					$score = "NaN";
				}
				else{
					#print "check: $score,$allNo\n";
					$score = (($score)/$allNo)*100.0;
					if ($score > 100){$score= 100.0;}
				}
				#print "1.\$score: $score\n";
# i to j check
				my %jfile = map {$_ => 1} @jfile;
				
				my @jkeys = keys %jfile;
				my $jallNo = @jkeys;				
				my $jscore = 0;
				my @jdup;
				for my $dup (@ifile){
					 chomp $dup;
					 if (exists $jfile{$dup}){						 
						 $jscore++;
						 push @jdup, $dup;
					 };
				}
				
				if($jallNo == 0){
					$jscore = "NaN";
				}
				else{
					#print "check: $score,$allNo\n";
					$jscore = (($jscore)/$jallNo)*100.0;
					if ($jscore > 100){$jscore= 100.0;}
				}

# end i to j check				
				#print "2.\$score: $score\n";
				
				if($score > $score_over and $jscore > $score_over){
					#print "$exam_dis{$key}->[$i] and $exam_dis{$key}->[$j] with Similarity $score%\n";
					my $temp = ($score + $jscore)/2.0;
					$score = sprintf("%.2f", $score);
					$jscore = sprintf("%.2f", $jscore);
					$temp = sprintf("%.2f", $temp);
					`echo "****$exam_dis{$key}->[$i] and $exam_dis{$key}->[$j]****, $score%, $jscore%, average => $temp%" >> ./summary.txt`;
					#die;
					#`echo '+++j to i file comparision' >> ./summary.txt`;
					#my $c1 = 0;
					#for my $d (@dup){
					#	chomp $d;
					#	$c1++;
					#	`echo '$c1 $d' >> ./summary.txt`;						
					#}
					#`echo '+++i to j file comparision' >> ./summary.txt`;
					#my $c2 = 0;
					#for my $d (@jdup){
					#	chomp $d;
					#	$c2++;
					#	`echo '$c2 $d' >> ./summary.txt`;						
					#}
					#`echo '' >> ./summary.txt`;										
				}
				
			#}#do
			}
			
		}###
			
		}		
	}
			
}

print "\n###Remeber to set correct permission to all files using permission_change.pl if needed.\n";


#my $mod = Text::Similarity::Overlaps->new;
#my $score = $mod->getSimilarity ($text_file1, $text_file2);
