#! /bin/csh

# doc from : https://wiki.freebsd.org/FreeBSD/BuildingMIPS

setenv SRCROOT /home/local/FreeBSD/src
setenv TARGET mips
setenv TARGET_ARCH mips64
# not used:
# setenv TARGET_CPUTYPE mips32
setenv KERNCONF OCTEON_CN38XX_PASS3
setenv MAKEOBJDIRPREFIX /home/local/FreeBSD/obj/mips
set NFSROOT=/home/local/FreeBSD/nfsroot
set TFTPBOOT=/home/local/FreeBSD/tftpboot

# Select some subset: the following used to be good, but now isn't
set MAKEFLAGS=(-DWITHOUT_CDDL           \
               -DWITHOUT_GAMES         \
               -DWITHOUT_DOCS          \
#               -DWITHOUT_ACPI          \
               -DWITHOUT_KERBEROS      \
#               -DWITHOUT_RESCUE        \
               -DWITHOUT_MAN           \
               -DWITHOUT_PROFILE       \
               -DWITHOUT_BSNMP         \
               -DWITHOUT_NIS           \
               -DWITHOUT_IPX)
#               -DWITHOUT_ATM)

cd ${SRCROOT}
make ${MAKEFLAGS} kernel-toolchain
make ${MAKEFLAGS} buildkernel
make ${MAKEFLAGS} buildworld

sudo -E make ${MAKEFLAGS} DESTDIR=${TFTPBOOT} installkernel
sudo -E make DESTDIR=${NFSROOT} ${MAKEFLAGS} installworld
sudo -E make DESTDIR=${NFSROOT} ${MAKEFLAGS} distribution
