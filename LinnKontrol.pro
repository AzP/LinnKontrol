# Add files and directories to ship with the application
# by adapting the examples below.
# file1.source = myfile
# dir1.source = mydir
DEPLOYMENTFOLDERS = # file1 dir1

symbian:TARGET.UID3 = 0xE7946A23

# Smart Installer package's UID
# This UID is from the protected range
# and therefore the package will fail to install if self-signed
# By default qmake uses the unprotected range value if unprotected UID is defined for the application
# and 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the
# MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=
QT      += network testlib xml
CONFIG  += warn_on

INCLUDEPATH += $$PWD/hupnp/include

# Section to install libHUpnp
contains(MEEGO_EDITION,harmattan):CONFIG(debug, debug|release): hupnp.files += $$PWD/hupnp/lib/harmattan/debug/libHUpnp.so.1
contains(MEEGO_EDITION,harmattan):CONFIG(release, debug|release): hupnp.files += $$PWD/hupnp/lib/harmattan/release/libHUpnp.so.1
contains(MEEGO_EDITION,harmattan):CONFIG(debug, debug|release):  hupnp.files += $$PWD/hupnp/lib/harmattan/debug/libQtSolutions_SOAP-2.7.so.1
contains(MEEGO_EDITION,harmattan):CONFIG(release, debug|release):  hupnp.files += $$PWD/hupnp/lib/harmattan/release/libQtSolutions_SOAP-2.7.so.1
contains(MEEGO_EDITION,harmattan):hupnp.path = /opt/LinnKontrol/hupnp/lib
contains(MEEGO_EDITION,harmattan):INSTALLS += hupnp

SOURCES += main.cpp mainwindow.cpp \
    myclass.cpp
HEADERS += mainwindow.h \
    myclass.h
FORMS += mainwindow.ui

# Please do not modify the following two lines. Required for deployment.
include(deployment.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/hupnp/lib/release -lHUpnp  -lQtSolutions_SOAP-2.7
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/hupnp/lib/debug -lHUpnp -lQtSolutions_SOAP-2.7
else:unix:!contains(MEEGO_EDITION,harmattan):CONFIG(release, debug|release): LIBS += -L$$PWD/hupnp/lib/unix/release -lHUpnp -lQtSolutions_SOAP-2.7
else:unix:!contains(MEEGO_EDITION,harmattan):CONFIG(debug, debug|release): LIBS += -L$$PWD/hupnp/lib/unix/debug -lHUpnp -lQtSolutions_SOAP-2.7
else:contains(MEEGO_EDITION,harmattan):CONFIG(release, debug|release): LIBS += -L$$PWD/hupnp/lib/harmattan/release -lHUpnp -lQtSolutions_SOAP-2.7
else:contains(MEEGO_EDITION,harmattan):CONFIG(debug, debug|release): LIBS += -L$$PWD/hupnp/lib/harmattan/debug -lHUpnp -lQtSolutions_SOAP-2.7
#else:symbian: LIBS += -lHUpnp -lQtSolutions_SOAP-2.7

contains(MEEGO_EDITION,harmattan):CONFIG(debug, debug|release): DEPENDPATH += -L$$PWD/hupnp/harmattan/lib/debug
contains(MEEGO_EDITION,harmattan):CONFIG(release, debug|release): DEPENDPATH += -L$$PWD/hupnp/harmattan/lib/release

contains(MEEGO_EDITION,harmattan):QMAKE_LFLAGS += -Wl,--rpath=/opt/LinnKontrol/hupnp/lib
else:unix:!contains(MEEGO_EDITION,harmattan):QMAKE_LFLAGS += -Wl,--rpath=./hupnp/lib
