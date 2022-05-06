#ifndef IMAGE_UTIL_HPP
#define IMAGE_UTIL_HPP
#include <QImage>
#include <QStringList>
#include <QObject>
#include <QColor>
#include <QUrl>
#include <QRgb>
#include <QDebug>

class ImageUtil: public QObject{
    Q_OBJECT
public:
    ImageUtil() = default;
    ~ImageUtil() = default;

    Q_INVOKABLE void setImage(const QUrl& url) {
       this->cur_image = QImage(url.toLocalFile());
    }

    Q_INVOKABLE bool isReady() {
        return !cur_image.isNull();
    }

     Q_INVOKABLE QString getImagePixelsOfArea(int x, int y, int width, int height) {

        if(cur_image.isNull())
            return "";

        QStringList data;
        auto start_x = x >= 0 ? x : 0;
        auto start_y = y >= 0 ? y : 0;

        auto end_x = (x + width) > cur_image.width() ? cur_image.width() : (x + width);
        auto end_y = (y + height) > cur_image.height() ? cur_image.height() : (y + height);
//        QStringList data;

        for(int pixel_y = start_y; pixel_y < end_y; ++pixel_y) {
            QString _data;
            QString cur_value;
            for(int pixel_x = start_x; pixel_x < end_x; ++pixel_x) {
                auto color = cur_image.pixelColor(pixel_x, pixel_y);
                QRgb rgb = color.rgb();
                auto value = "#" + QString::number(rgb,16);
                if(pixel_x == start_x) {
                    _data.append(QString("<font color='%1'>").arg(value));
                    cur_value = value;
                } else if(value != cur_value) {
                    _data.append(QString("</font><font color='%1'>").arg(value));
                    cur_value = value;
                }
                _data.append(value + '\t');
            }
            _data = _data.trimmed() + "</font><br />";
            data.append(_data);
        }
//        auto res = data.join('\n');
//        qDebug() << res;
//        exit(0);
        return data.join("");
    }
private:
    QImage cur_image;
};

#endif // IMAGE_UTIL_HPP
