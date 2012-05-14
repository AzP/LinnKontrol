#ifndef MYCLASS_H
#define MYCLASS_H

// myclass.h

#include <HUpnpCore/HControlPoint>
#include <HUpnpCore/HUpnp>

class MyClass : public QObject
{
	Q_OBJECT

public:
	void scanForNewDevices();
	MyClass(QObject* parent = 0);

private:

	Herqq::Upnp::HControlPoint* m_controlPoint;

private slots:

	void rootDeviceOnline(Herqq::Upnp::HClientDevice*);
	void rootDeviceOffline(Herqq::Upnp::HClientDevice*);

};

#endif // MYCLASS_H
