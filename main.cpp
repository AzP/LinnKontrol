#include "mainwindow.h"

#include <QtGui/QApplication>

int main(int argc, char *argv[])
{
	Herqq::Upnp::SetLoggingLevel(Herqq::Upnp::Warning);

	QApplication app(argc, argv);

	MainWindow mainWindow;
	mainWindow.setOrientation(MainWindow::ScreenOrientationAuto);
	mainWindow.showExpanded();

	return app.exec();
}
