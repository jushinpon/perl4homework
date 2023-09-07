
#Sure, you can also set the same limits for a group of users. To do this, you would use the @ symbol to represent the group name. For example, the following line would set a hard limit of 20% CPU usage and 100 MB RAM usage for all users in the group @student:
#
#@student hard cpu 20
#@student hard memory 100M
#To summarize, here are the steps on how to set a hard limit of 20% CPU usage and 100 MB RAM usage for all users in the group @student using the /etc/security/limits.conf file:
#
#Open the /etc/security/limits.conf file in a text editor.
#Add the following lines to the file:
#@student hard cpu 20
#@student hard memory 100M
#Save and close the file.

#groupadd students
#usermod -a -G students johndoe
#usermod -d -G students johndoe
#groups

open my $ss,"< ./username.dat" or die "No Server_setting.dat to open.\n $!";#one line for an username
my @temp_array = <$ss>;
close $ss; 
my @user_accounts = grep (($_!~m{^\s*$|^#}),@temp_array); # remove blank lines
map { s/^\s+|\s+$//g; } @user_accounts;
system("groupadd students");

for (@user_accounts){
    system("usermod -a -G students $_");
}

my $string = "
Please open /etc/security/limits.conf and paste the following into it:
\@students hard cpu 15
\@students hard memory 30M
";
print "$string\n";

