!#/bin.bash
echo "making partition for our system"
(echo n; echo p; echo 1; echo 1; echo 200; echo w) | fdisk /dev/sdc
echo "making filesystem on the partition"
mkfs -v -t ext4 /dev/<xxx>
echo "assigning mount point to the LFS environment variable"
export LFS=/mnt/lfs
echo "create mount point"
mkdir -pv $LFS
echo "mount the LFS filesystem"
mount -v -t ext4 /dev/<xxx> $LFS

mkdir -v $LFS/tools

ln -sv $LFS/tools /

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF

source ~/.bash_profile

