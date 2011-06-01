CONT=chksize deboowait lxpanel-config.tar.gz pandebian pandebian.sosume pandebian-share pandebian-share.sosume
DEBOOTSTRAP_VERSION=1.0.32

all: pandebian.pnd

pandebian.pnd: $(CONT) debootstrap.done PXML.xml
	rm -rf pandebian.pnd.d
	mkdir pandebian.pnd.d
	cp -a $(CONT) debootstrap pandebian.pnd.d/
	mksquashfs pandebian.pnd.d/ pandebian.pnd
	cat PXML.xml >> pandebian.pnd
	cat icon.png >> pandebian.pnd
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

lxpanel-config.tar.gz:
	mkdir -p .config/lxpanel/default/panels
	cp lxpanel/config .config/lxpanel/default/config
	cp lxpanel/panel .config/lxpanel/default/panels/panel
	tar zcf lxpanel-config.tar.gz .config/
	rm -rf .config

clean:
	rm -rf pandebian.pnd.d/ pandebian.pnd
	rm -rf data.tar.gz debootstrap debootstrap.done
	rm -rf .config lxpanel-config.tar.gz
