#ifndef APPLICATION_H
#define APPLICATION_H

#include <QObject>
#include "fileData.h"
#include "cipher.h"

class Application : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QByteArray cipherPassword MEMBER m_cipherPassword NOTIFY cipherPasswordChanged)
public:
    explicit Application(QObject *parent = nullptr);
    fileData* getFileData();
    Q_INVOKABLE void encrypt();
    Q_INVOKABLE void decrypt();
    Q_INVOKABLE void saveFile();
signals:
    void cipherPasswordChanged(QByteArray password);
private:
    fileData m_fileData;
    Cipher m_cipher;
    QByteArray m_data;
    QByteArray m_cipherPassword;
};

#endif // APPLICATION_H
