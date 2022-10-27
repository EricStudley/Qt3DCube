#pragma once

#include <QMatrix4x4>
#include <QVariantList>

class CubeObject
{
public:
    CubeObject();
    CubeObject(const QVector3D &translation, const QVariantList &sideList);

    QMatrix4x4 matrix() const { return m_matrix; }
    QVariantList sideList() const { return m_sideList; }

    void setMatrix(const QMatrix4x4 &matrix) { m_matrix = matrix; }
    void setSideList(const QVariantList &sideList) { m_sideList = sideList; }

private:
    QMatrix4x4 m_matrix;
    QVariantList m_sideList;
};
