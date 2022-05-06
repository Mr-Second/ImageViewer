#ifndef CURSOR_HPP
#define CURSOR_HPP
#include <QDebug>
#include <QObject>
#include <QCursor>
#include <QPixmap>
#include <QQuickItem>

class Cursor: public QObject {
    Q_OBJECT
public:
    Cursor() {
        cursor = QCursor(QPixmap(":/cursor.png").scaled(25,25, Qt::KeepAspectRatio));
    };
    ~Cursor() = default;

    Q_INVOKABLE void setHoveredCursor(QObject *obj) {
        if(nullptr == obj)
            return;
        QQuickItem *itemObj = qobject_cast<QQuickItem*>(obj);
        if(nullptr == itemObj)
            return;
        itemObj->setCursor(cursor);
    }

private:
    QCursor cursor;
};

#endif // CURSOR_HPP
