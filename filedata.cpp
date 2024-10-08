#include "fileData.h"
#include <QDebug>

fileData::fileData(QObject *parent)
    : QObject{parent}
{}

QString fileData::path() const
{
    qDebug() << "path to " << m_path;
    return m_path;
}

void fileData::setPath(const QString& path)
{
    m_path = path;
    qDebug() << "path to file" << path;
    updateFileInfo();
    emit pathChanged(path);
}

QString fileData::savePath() const
{
    qDebug() << "save path to " << m_savePath;
    return m_savePath;
}

void fileData::setSavePath(const QString& savePath)
{
    m_savePath = savePath;
    qDebug() << "save path to file" << savePath;
    emit savePathChanged(savePath);
}

void fileData::updateFileInfo()
{
    m_fileInfo.setFile(m_path);
    m_fileSize = m_fileInfo.size();
    m_fileExtension = m_fileInfo.completeSuffix();
}

QByteArray fileData::readFile(QString filename)
{
    QByteArray data;
    QFile file(filename);
    if(!file.open(QFile::ReadOnly))
    {
        qCritical() << file.errorString();
        return data;
    }

    data = file.readAll();
    file.close();
    return data;
}

void fileData::writeFile(QString filename, const QByteArray &data)
{
    const QString encryptedSuffix = "enc";
    if(filename.isEmpty())
    {
        return;
    }
    if(m_fileInfo.suffix() == encryptedSuffix)
    {
        m_fileExtension.remove(".enc");
    }
    else
    {
        m_fileExtension.append(".enc");
    }
    const QString filePath(filename + "." + m_fileExtension);
    QFile file(filePath);
    if(!file.open(QFile::WriteOnly))
    {
        qCritical() << file.errorString();
        return;
    }

    file.write(data);
    file.close();
}

