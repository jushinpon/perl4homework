#while true;do echo;done;
#sha1sum /dev/zero  cpu loading test
# ls -l /dev/sd* to check the dev range for cgconfig.conf
use strict;
use warnings;
#`yum install -y libcgroup-tools libcgroup-pam libcgroup`;
#resource you want to control (check cgconfig.conf)

`mkdir /sys/fs/cgroup/systemd/user.slice/user-1004`;
`echo "20000" > /sys/fs/cgroup/systemd/user.slice/user-1004/cpu.cfs_quota_us`;
`echo "100M" > /sys/fs/cgroup/systemd/user.slice/user-1004/memory.limit_in_bytes`;
`echo "1004" >> /sys/fs/cgroup/systemd/user.slice/user-1004/cgroup_access`;

# echo "1000000" > /sys/fs/cgroup/cpu/Example/cpu.cfs_period_us
# echo "200000" > /sys/fs/cgroup/cpu/Example/cpu.cfs_quota_us

#unless (-e "cgconfig.conf"){die "no cgconfig.conf!!\n";}
#`rm -f /etc/cgconfig.conf`;
#`cp ./cgconfig.conf /etc`;
#
#system("cgconfigparser -l /etc/cgconfig.conf");
#
#unless (-e "cgrules.conf"){die "no cgrules.conf!!\n";}
#`rm -f /etc/cgrules.conf`;
#`cp ./cgrules.conf /etc`;
#open my $ss,"< ./username.dat" or die "No Server_setting.dat to open.\n $!";#one line for an username
#my @temp_array = <$ss>;
#close $ss; 
#my @user_accounts = grep (($_!~m{^\s*$|^#}),@temp_array); # remove blank lines
#map { s/^\s+|\s+$//g; } @user_accounts;
#for my $u (@user_accounts){
#    `usermod -a -G users $u`;
#}
## 设置Cgroup服务开机启动
#`systemctl enable cgconfig`;
#`systemctl enable cgred`;
#
## 重启Cgroup服务
#`systemctl restart cgconfig`;
#`systemctl restart cgred`;