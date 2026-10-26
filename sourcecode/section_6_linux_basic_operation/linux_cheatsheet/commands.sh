#!/bin/bash
# Các thao tác Linux thường dùng khác - tham khảo
# Copy từng lệnh và chạy thử trên EC2, không chạy cả file.

mkdir -p ~/linux-lab/cheatsheet
cd ~/linux-lab/cheatsheet

########## Download file từ Internet ##########
wget https://raw.githubusercontent.com/torvalds/linux/master/README
wget -O linux-readme.txt https://raw.githubusercontent.com/torvalds/linux/master/README
curl -o linux-readme-2.txt https://raw.githubusercontent.com/torvalds/linux/master/README
curl -I https://aws.amazon.com
curl -s https://checkip.amazonaws.com

########## Nén / giải nén tar.gz ##########
mkdir -p project/logs
echo "log 1" > project/logs/app.log
echo "config" > project/app.conf
tar -czvf project.tar.gz project
tar -tzvf project.tar.gz
mkdir extract
tar -xzvf project.tar.gz -C extract
ls -R extract

########## Nén / giải nén zip ##########
sudo dnf install -y zip unzip
zip -r project.zip project
unzip -l project.zip
unzip project.zip -d extract-zip
ls -R extract-zip

########## Xem nội dung file ##########
head -n 5 linux-readme.txt
tail -n 5 linux-readme.txt
less linux-readme.txt
wc -l linux-readme.txt
sudo tail -f /var/log/messages 2>/dev/null || sudo journalctl -f

########## Tìm kiếm ##########
grep -n "kernel" linux-readme.txt
grep -ri "PermitRootLogin" /etc/ssh/ 2>/dev/null
find ~ -name "*.log"
find /var/log -type f -size +1M 2>/dev/null

########## Dung lượng ##########
df -h
du -sh ~/linux-lab
du -h --max-depth=1 /var 2>/dev/null | sort -h
free -h

########## Pipe & Redirect ##########
ps aux | sort -k4 -nr | head -5
cat /etc/passwd | cut -d: -f1 | sort
ls /not-exist 2> error.txt
cat error.txt
ls ~ > output.txt 2>&1

########## Biến môi trường ##########
echo $HOME
echo $PATH
export APP_ENV=dev
echo $APP_ENV
env | grep APP_ENV

########## Mạng ##########
ip addr
ss -tulnp
ping -c 3 google.com
nslookup aws.amazon.com 2>/dev/null || getent hosts aws.amazon.com

########## Dọn dẹp ##########
rm -rf ~/linux-lab/cheatsheet
