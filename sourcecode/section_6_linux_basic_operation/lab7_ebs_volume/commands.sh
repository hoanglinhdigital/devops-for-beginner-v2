#!/bin/bash
# Lab 7 - EBS Volume: partition, mount & mở rộng dung lượng
# Copy từng lệnh và chạy theo hướng dẫn trong bài lab, không chạy cả file.
# Lưu ý: instance Nitro (t3, t4g, m5...) hiển thị EBS dưới dạng NVMe: /dev/nvme0n1 (root), /dev/nvme1n1 (volume thứ 2)

########## Bước 1: Kiểm tra disk hiện tại ##########
lsblk
df -h
lsblk -f

########## Bước 2: Mở rộng ổ root (sau khi Modify volume 8GB -> 10GB trên Console) ##########
lsblk
sudo growpart /dev/nvme0n1 1
lsblk
sudo xfs_growfs -d /
df -h /

########## Bước 3: Ổ EBS mới (sau khi Attach volume 10GB trên Console) ##########
lsblk
sudo file -s /dev/nvme1n1

########## Bước 4: Tạo partition bằng fdisk ##########
sudo fdisk /dev/nvme1n1
# Trong fdisk gõ lần lượt:
#   n      -> tạo partition mới
#   p      -> primary
#   1      -> partition số 1
#   Enter  -> first sector mặc định
#   Enter  -> last sector mặc định (dùng toàn bộ dung lượng)
#   w      -> ghi thay đổi và thoát
lsblk

########## Bước 5: Format (tạo file system) & mount ##########
sudo mkfs -t xfs /dev/nvme1n1p1
sudo mkdir /data
sudo mount /dev/nvme1n1p1 /data
df -h /data
sudo chown ec2-user:ec2-user /data
echo "Hello EBS volume" > /data/test.txt
cat /data/test.txt
ls -l /data

########## Bước 6: Tự động mount khi khởi động lại (fstab) ##########
sudo blkid /dev/nvme1n1p1
sudo cp /etc/fstab /etc/fstab.bak
sudo vim /etc/fstab
# Thêm 1 dòng (thay <UUID> bằng UUID lấy từ lệnh blkid):
# UUID=<UUID>  /data  xfs  defaults,nofail  0  2

sudo umount /data
df -h | grep /data
sudo systemctl daemon-reload
sudo mount -a
df -h /data
cat /data/test.txt

sudo reboot
# SSH lại sau 1-2 phút
df -h /data
cat /data/test.txt

########## Bước 7: Mở rộng ổ /data (sau khi Modify volume 10GB -> 15GB trên Console) ##########
lsblk
sudo growpart /dev/nvme1n1 1
sudo xfs_growfs -d /data
df -h /data
cat /data/test.txt

########## Dọn dẹp ##########
sudo umount /data
sudo cp /etc/fstab.bak /etc/fstab
sudo systemctl daemon-reload
lsblk
# Sau đó trên Console: Detach volume -> Delete volume
