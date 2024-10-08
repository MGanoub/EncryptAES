#ifndef APPLICATION_H
#define APPLICATION_H

#include <QObject>
#include "fileData.h"
#include "cipher.h"

class Application : public QObject
{
    Q_OBJECT
public:
    explicit Application(QObject *parent = nullptr);
    fileData* getFileData();
    Q_INVOKABLE void encrypt();
    Q_INVOKABLE void decrypt();
    Q_INVOKABLE void saveFile();
signals:
private:
    fileData m_fileData;
    Cipher m_cipher;
    QByteArray m_data;
};

#endif // APPLICATION_H
