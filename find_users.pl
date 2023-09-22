my @users = `ls /home`;
map { s/^\s+|\s+$//g; } @users;
for (@users){
	
print "$_\n";	
	
}
