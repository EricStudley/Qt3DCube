#include "CubeObject.h"

CubeObject::CubeObject()
{

}

CubeObject::CubeObject(const QVector3D &translation, const QVariantList &sideList)
    : m_sideList(sideList)
{
    m_matrix.setColumn(3, QVector4D(translation, 1));
}

