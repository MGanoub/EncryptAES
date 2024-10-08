#ifndef CIPHER_H
#define CIPHER_H

#include <QObject>
#include <QDebug>
#include <QFile>
#include <openssl/rsa.h>
#include <openssl/engine.h>
#include <openssl/pem.h>
#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <openssl/aes.h>
#include <openssl/rand.h>

#define KEYSIZE 32
#define IVSIZE 32
#define BLOCKSIZE 256


class Cipher : public QObject
{
    Q_OBJECT
public:
    explicit Cipher(QObject *parent = 0);
    ~Cipher();

    /**
     * @brief Encrypt a byte array with AES 256 CBC
     * @param data The byte array to encrypt
     * @return QByteArray
     */
    QByteArray encryptAES(QByteArray passphrase, QByteArray &data);

    /**
     * @brief Decrypt a byte array with AES 256 CBC
     * @param data The byte array to decrypt
     * @return QByteArray
     */
    QByteArray decryptAES(QByteArray passphrase, QByteArray &data);

    /**
     * @brief Get a byte array filled with random information
     * @return QByteArray
     */
    QByteArray randomBytes();

private:
    /**
      * @brief Initalize the OpenSSL Lib
      */
    void initalize();

    /**
      * @brief Cleanup after the OpenSSL lib
      */
    void finalize();



    QString m_filePath;
};

#endif // CIPHER_H
