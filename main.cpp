#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "cipher.h"
#include "application.h"

void testAES()
{
    qDebug() << "Testing AES...";
    fileData myData;
    Cipher cWrapper;
    QString passphrase = "password";
    QByteArray plain = "The man in black fled into the desert and the gunslinger followed (with aes)...";
    //cWrapper.setFilePath(myData.path());
    QByteArray encrypted = cWrapper.encryptAES(passphrase.toLatin1(),plain);
    QByteArray decrypted = cWrapper.decryptAES(passphrase.toLatin1(),encrypted);


    qDebug() << plain;
    qDebug() << encrypted.toBase64();
    qDebug() << decrypted;
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //qmlRegisterType<fileData>("fileSettings", 1, 0, "FileData");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("testAES", "Main");

    Application myApplication;
    engine.rootContext()->setContextProperty("myApp", &myApplication);

    engine.rootContext()->setContextProperty("myFileData", myApplication.getFileData());

    //testAES();

    return app.exec();
}
