CONT=chksize debootstrap deboowait lxpanel-config.tar.gz pandebian pandebian.sosume pandebian-share pandebian-share.sosume

all: pandebian.pnd

pandebian.pnd: $(CONT) PXML.xml debootstrap/debootstrap
	rm -rf pandebian.pnd.d
	mkdir pandebian.pnd.d
	cp -a $(CONT) pandebian.pnd.d/
	mksquashfs pandebian.pnd.d/ pandebian.pnd
	cat PXML.xml >> pandebian.pnd
	rm -rf pandebian.pnd.d/
