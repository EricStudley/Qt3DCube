#pragma once

#include "CubeEnums.h"
#include "CubeObject.h"

#include <QAbstractListModel>

class CubeModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit CubeModel(QObject *parent = nullptr);

    enum DisplayRoles {
        MatrixRole = Qt::UserRole + 1,
        SideListRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    void rotateCubeSide(const Side &side, const bool clockwise, const bool instant = false);

signals:
    void rotateCell(const int cellIndex, const QVector3D& axis, bool instant);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<CubeObject*> m_objects;
};
