su - root
1.sh----------------
echo "%sudo ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "%admin ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
2.sh-----------------
yum -y update
yum -y install gcc
yum -y install kernel-devel
yum -y install epel-release
yum -y install dkms
yum -y install libaio
yum -y install libXpm
нет -y readahead-1.3-7.el5, java-1.4.2-gcj-compat-1.4.2.0-40jpp.112 , setarch-2.0-1.1
yum -y install compat-libcap1
yum -y install gcc-c++
yum -y install ksh
yum -y install libaio-devel
yum -y install libXi
yum -y install libXtst
yum -y install sysstat
yum -y install unixODBC
yum -y install up2date
yum -y install compat-libstdc++-33.x86_64
yum -y  install xclock
yum -y install xorg-x11-xauth
yum -y install ntfsprogs ntfsprogs-gnomevfs
yum -y install fuse
yum -y install unzip
yum -y install iptables-services 
yum -y provides ifconfig
yum -y install net-tools
3.sh-------------------
groupadd admin
usermod -a -G admin tagan
useradd oracle
useradd grid
groupadd oinstall
groupadd dba
groupadd oper
groupadd backupdba
groupadd kmdba
groupadd asmdba
groupadd asmoper
groupadd asmadmin
usermod -a -G admin,dba,oinstall,oper,asmdba,backupdba,kmdba oracle
usermod -a -G admin,dba,oinstall,asmadmin,asmdba grid
 --------------------------
 passwd oracle
4.sh-------------------
fdisk /dev/sdb
#КАК ЭТО СДЕЛАТЬ АВТОМАТИЧЕСКИ?

mkfs.ext4 /dev/sdb1
mkdir /u01
mount -t ext4 /dev/sdb1 /u01
echo "/dev/sdb1 /u01 ext4 defaults 0 2" >> /etc/fstab
echo "umask 022" >> /home/oracle/.bash_profile
5.sh-------------------------
mkdir -p /u01/app/oracle
chown -R oracle:oinstall /u01/app/oracle
chmod -R 775 /u01/app/oracle
mkdir /u01/oradata
chown oracle:oinstall /u01/oradata
chmod 775 /u01/oradata
mkdir /u01/fast_recovery_area
chown oracle:oinstall /u01/fast_recovery_area
chmod 775 /u01/fast_recovery_area
mkdir -p /u01/app/orauser
chown -R oracle:oinstall /u01/app/orauser
chmod -R 775 /u01/app/orauser
mkdir -p /u01/app/oraInventory
chown -R oracle:oinstall /u01/app/oraInventory
chmod -R 775 /u01/app/oraInventory
chown -R oracle:oinstall /u01/app
chmod -R 775 /u01/app
-----------------------------
#копируем дистриб оракла
#под рутом с другого сервера.
sudo scp -r /u01/V4* root@192.168.1.48:/u01/
7.sh--------------------------
cd /u01/
sudo unzip V46095-01_1of2.zip
sudo unzip V46095-01_2of2.zip
chown -R oracle:oinstall /u01/database
chmod -R 775 /u01/database
-----------------------------------------
-------------------------------------------
###########################################
-----------------------------------------
-------------------------------------------
#установка дистриба оракла

cd /u01/database/
./runInstaller
посмотреть позже
/etc/oratab - запуск при старте походу
/usr/local/bin - какое-то оракловое говно копируется
9.sh------------------
#postinstallation task

echo 'export ORACLE_BASE=/u01/app/oracle' >> /home/oracle/.bash_profile
echo 'export ORACLE_HOME=/u01/app/oracle/product/12.1.0/dbhome_1' >> /home/oracle/.bash_profile
echo 'export LD_LIBRARY_PATH=/u01/app/oracle/product/12.1.0/dbhome_1/lib' >> /home/oracle/.bash_profile
echo 'export ORACLE_SID=orcl' >> /home/oracle/.bash_profile
echo "export NLS_LANG='ENGLISH_UNITED KINGDOM.AL32UTF8'" >> /home/oracle/.bash_profile
echo "export NLS_DATE_FORMAT='DD.MM.YYYY HH24:MI:SS'" >> /home/oracle/.bash_profile
echo 'export LANG=en_GB.utf8' >> /home/oracle/.bash_profile
echo 'export JAVA_HOME=$ORACLE_HOME/jdk' >> /home/oracle/.bash_profile
echo 'PATH=$PATH:$HOME/.local/bin:$HOME/bin:$ORACLE_HOME/bin:$LD_LIBRARY_PATH' >> /home/oracle/.bash_profile
echo 'export PATH' >> /home/oracle/.bash_profile

#copy root.sh sript as oracle recomendation
sudo mkdir /u01/oracle_backup
sudo chown -R oracle:oinstall  /u01/oracle_backup
sudo chmod -R 775  /u01/oracle_backup
cp /u01/app/oracle/product/12.1.0/dbhome_1/root.sh /u01/oracle_backup/root.sh_$(date +%Y%m%d)
10.sh-----------------------------------------------------------------------


sudo iptables -I INPUT -i enp0s3 -p tcp --dport 1521 -j ACCEPT
sudo yum install iptables-services
sudo systemctl stop firewalld
sudo systemctl mask firewalld
sudo systemctl enable iptables
sudo systemctl start iptables
sudo service iptables save
sudo iptables -I INPUT -i enp0s3 -p tcp --dport 1521 -j ACCEPT
sudo service iptables save

sudo iptables -I INPUT -i enp0s3 -p tcp --dport 1522 -j ACCEPT
sudo yum install iptables-services
sudo systemctl stop firewalld
sudo systemctl mask firewalld
sudo systemctl enable iptables
sudo systemctl start iptables
sudo service iptables save
sudo iptables -I INPUT -i enp0s3 -p tcp --dport 1522 -j ACCEPT
sudo service iptables save

sudo iptables -I INPUT -i enp0s3 -p tcp --dport 5500 -j ACCEPT
sudo yum install iptables-services
sudo systemctl stop firewalld
sudo systemctl mask firewalld
sudo systemctl enable iptables
sudo systemctl start iptables
sudo service iptables save
sudo iptables -I INPUT -i enp0s3 -p tcp --dport 5500 -j ACCEPT
sudo service iptables save


---------------------
что-то лисенер с нестандартным именем не хочет работать. 
с нестандартным портом точнее.
вернее не работает конект к базе. что делать?


