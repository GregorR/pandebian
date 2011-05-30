CONT=chksize debootstrap deboowait lxpanel-config.tar.gz pandebian pandebian.sosume pandebian-share pandebian-share.sosume
DEBOOTSTRAP_VERSION=1.0.32

all: pandebian.pnd

pandebian.pnd: $(CONT) debootstrap.done PXML.xml
	rm -rf pandebian.pnd.d
	mkdir pandebian.pnd.d
	cp -a $(CONT) pandebian.pnd.d/
	mksquashfs pandebian.pnd.d/ pandebian.pnd
	cat PXML.xml >> pandebian.pnd
	rm -rf pandebian.pnd.d/

debootstrap.done: debootstrap_$(DEBOOTSTRAP_VERSION)_all.deb
	ar x debootstrap_$(DEBOOTSTRAP_VERSION)_all.deb data.tar.gz
	tar zxf data.tar.gz
	rm -rf debootstrap
	mv usr/share/debootstrap .
	mv usr/sbin/debootstrap debootstrap/
	rm -rf usr
	touch debootstrap.done

%.deb:
	wget http://ftp.us.debian.org/debian/pool/main/d/debootstrap/debootstrap_$(DEBOOTSTRAP_VERSION)_all.deb

clean:
	rm -rf pandebian.pnd.d/ pandebian.pnd
	rm -rf data.tar.gz debootstrap debootstrap.done
