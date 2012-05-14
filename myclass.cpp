#include "myclass.h"
#include <HUpnpCore/HClientDevice>
#include <HUpnpCore/HDeviceInfo>


#include <QtDebug>

MyClass::MyClass(QObject* parent) :
QObject(parent), m_controlPoint(new Herqq::Upnp::HControlPoint(this))
{
    connect( m_controlPoint, SIGNAL(rootDeviceOnline(Herqq::Upnp::HClientDevice*)),
                this,
                SLOT(rootDeviceOnline(Herqq::Upnp::HClientDevice*)));

    connect( m_controlPoint, SIGNAL(rootDeviceOffline(Herqq::Upnp::HClientDevice*)),
                this,
                SLOT(rootDeviceOffline(Herqq::Upnp::HClientDevice*)));

    if (!m_controlPoint->init())
    {
        // the initialization failed, perhaps you should do something?
        // for starters, you can call error() to check the error type and
        // errorDescription() for a human-readable description of
        // the error that occurred.
        qDebug() << m_controlPoint->errorDescription();
        return;
    }

    qDebug() << "ControlPoint initialized properly";
    // the control point is running and any standard-compliant UPnP device
    // on the same network should now be discoverable.
    Herqq::Upnp::HClientDevices clientDevices = m_controlPoint->rootDevices();
    qDebug() << "Number of Devices:" << clientDevices.count();
    foreach( Herqq::Upnp::HClientDevice* clientDevice, clientDevices )
        qDebug() << "Deviceinfo:" << clientDevice->info().friendlyName();

    // remember also that the current thread has to have an event loop
}

void MyClass::rootDeviceOnline(Herqq::Upnp::HClientDevice* newDevice)
{
    // device discovered, should something be done with it? Perhaps we want
    // to learn something from it:
    Herqq::Upnp::HDeviceInfo info = newDevice->info();
    // do something with the info object
    //parent()->ui->plainTextEdit()->setPlainText(QString(info.friendlyName());
    qDebug() << QString(info.friendlyName());
}

void MyClass::rootDeviceOffline(Herqq::Upnp::HClientDevice* rootDevice)
{
    // device announced that it is going away and the control point sends
    // a notification of this. However, the device isn't removed from the
    // control point until explicitly requested:
    m_controlPoint->removeRootDevice(rootDevice);
}
