#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "application.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //qmlRegisterType<fileData>("fileSettings", 1, 0, "FileData");

    QQmlApplicationEngine engine;
    Application myApplication;
    engine.rootContext()->setContextProperty("myApp", &myApplication);

    engine.rootContext()->setContextProperty("myFileData", myApplication.getFileData());

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("testAES", "Main");

    return app.exec();
}
