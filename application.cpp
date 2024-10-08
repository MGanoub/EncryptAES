#include "application.h"

Application::Application(QObject *parent)
    : QObject{parent}
    ,m_isProcessed(false)
{}

fileData* Application::getFileData()
{
    return &m_fileData;
}

void Application::encrypt()
{
    if(m_fileData.path().isEmpty())
    {
        return;
    }
    auto data = m_fileData.readFile(m_fileData.path());
    m_data = m_cipher.encryptAES(m_cipherPassword, data);
    m_isProcessed = true;
    emit isProcessedChanged(m_isProcessed);
}

void Application::decrypt()
{
    if(m_fileData.path().isEmpty())
    {
        return;
    }
    auto data = m_fileData.readFile(m_fileData.path());
    m_data = m_cipher.decryptAES(m_cipherPassword, data);
    m_isProcessed = true;
    emit isProcessedChanged(m_isProcessed);
}

void Application::saveFile()
{
    m_fileData.writeFile(m_fileData.savePath(), m_data);
}


