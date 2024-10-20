#!/bin/sh

#wget -q "--no-check-certificate" https://raw.githubusercontent.com/emil237/sherlockmod/main/installer.sh -O - | /bin/sh

##########################################
version="1.4.2"
#############################################################
TEMPATH=/tmp
OPKGINSTALL="opkg install --force-overwrite"
MY_IPK="enigma2-plugin-extensions-sherlockmod_1.4.2_all.ipk"
MY_DEB="enigma2-plugin-extensions-sherlockmod_1.4.2_all.deb"
MY_URL="https://raw.githubusercontent.com/emil237/sherlockmod/main"
#
if [ -f /etc/apt/apt.conf ]; then
    INSTALL="apt-get install -y"
    OPKGREMOV="apt-get purge --auto-remove -y"
    CHECK_INSTALLED="dpkg -l"
    OS="DreamOS"
elif [ -f /etc/opkg/opkg.conf ]; then
    INSTALL="opkg install --force-reinstall --force-depends"
    OPKGREMOV="opkg remove --force-depends"
    CHECK_INSTALLED="opkg list-installed"
    OS="Opensource"
else
    echo "Unsupported OS"
    exit 1
fi

# remove old version #
if [ -d /usr/lib/enigma2/python/Plugins/Extensions/Sherlockmod ]; then
$OPKGREMOV enigma2-plugin-extensions-sherlockmod 
 rm -rf /usr/lib/enigma2/python/Plugins/Extensions/Sherlockmod
fi;
if [ -f /usr/lib/enigma2/python/Components/Converter/ArBoxInfo.py ]; then
 rm -rf /usr/lib/enigma2/python/Components/Converter/ArBoxInf*
fi;
if [ -f /usr/lib/enigma2/python/Components/Converter/CamdRAED.py ]; then
 rm -rf /usr/lib/enigma2/python/Components/Converter/CamdRAED*
fi;
if [ -f /usr/lib/enigma2/python/Components/Converter/BServiceInfo2.py ]; then
 rm -rf /usr/lib/enigma2/python/Components/Converter/BServiceInfo2*
fi;
if [ -f /usr/lib/enigma2/python/Components/Converter/EvgIPChecker.py ]; then
 rm -rf /usr/lib/enigma2/python/Components/Converter/EvgIPChecke*
fi;
if [ -f /usr/lib/enigma2/python/Components/Converter/RaedQuickServName2.py ]; then
 rm -rf /usr/lib/enigma2/python/Components/Converter/RaedQuickServNam*
fi;
if [ -f /usr/lib/enigma2/python/Components/Converter/RouteInfo.py ]; then
 rm -rf /usr/lib/enigma2/python/Components/Converter/RouteInfo*
fi

echo ""
# Download and install plugin
cd /tmp
set -e
 if which dpkg > /dev/null 2>&1; then
  wget "$MY_URL/$MY_DEB"
		dpkg -i --force-overwrite $MY_DEB; apt-get install -f -y
wait
rm -f $MY_DEB
	else
  wget "$MY_URL/$MY_IPK"
		$INSTALL $MY_IPK
wait
rm -f $MY_IPK
	fi
echo "================================="
set +e
cd ..
wait
	if [ $? -eq 0 ]; then
echo ">>>>  SUCCESSFULLY INSTALLED <<<<"
fi
		echo "********************************************************************************"

clear
echo ""
echo "   UPLOADED BY  >>>>   EMIL_NABIL "   
sleep 4;
echo "#########################################################"
exit 0
