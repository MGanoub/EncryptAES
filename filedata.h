#ifndef FILEDATA_H
#define FILEDATA_H

#include <QObject>
#include <QFileInfo>

class fileData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged)
    Q_PROPERTY(QString savePath READ savePath WRITE setSavePath NOTIFY savePathChanged)
    Q_PROPERTY(double fileSize MEMBER m_fileSize NOTIFY fileSizeChanged)
    Q_PROPERTY(QString fileExtension MEMBER m_fileExtension NOTIFY fileExtensionChanged)
public:
    explicit fileData(QObject *parent = nullptr);
    QString path() const;
    void setPath(const QString& path);
    QString savePath() const;
    void setSavePath(const QString& savePath);

    /**
     * @brief Loads a file and returns a byte array
     * @param filename The file to read from
     * @return QByteArray
     */
    QByteArray readFile(QString filename);

    /**
     * @brief Writes a byte array to a file
     * @param filename The name of the file to write to
     * @param data The byte array to write
     */
    void writeFile(QString filename, const QByteArray &data);

signals:
    void pathChanged(QString path);
    void savePathChanged(QString savePath);
    void fileSizeChanged(double size);
    void fileExtensionChanged(QString extension);

private:
    void updateFileInfo();
    QString m_path;
    QString m_savePath;
    QFileInfo m_fileInfo;
    double m_fileSize;
    QString m_fileExtension;
};

#endif // FILEDATA_H
