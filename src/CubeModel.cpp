#include "CubeModel.h"

CubeModel::CubeModel(QObject *parent) : QAbstractListModel(parent)
{
    m_objects.append(new CubeObject(QVector3D(-100, 100, -100), {Side::Up, Side::Back, Side::Left}));
    m_objects.append(new CubeObject(QVector3D(0, 100, -100),     { Side::Up, Side::Back }));
    m_objects.append(new CubeObject(QVector3D(100, 100, -100),   { Side::Up, Side::Right, Side::Back }));
    m_objects.append(new CubeObject(QVector3D(-100, 100, 0),     { Side::Up, Side::Left }));
    m_objects.append(new CubeObject(QVector3D(0, 100, 0),        { Side::Up }));
    m_objects.append(new CubeObject(QVector3D(100, 100, 0),      { Side::Up, Side::Right }));
    m_objects.append(new CubeObject(QVector3D(-100, 100, 100),   { Side::Up, Side::Front, Side::Left }));
    m_objects.append(new CubeObject(QVector3D(0, 100, 100),      { Side::Up, Side::Front }));
    m_objects.append(new CubeObject(QVector3D(100, 100, 100),    { Side::Up, Side::Front, Side::Right }));
    m_objects.append(new CubeObject(QVector3D(-100, 0, -100),    { Side::Back, Side::Left }));
    m_objects.append(new CubeObject(QVector3D(0, 0, -100),       { Side::Back }));
    m_objects.append(new CubeObject(QVector3D(100, 0, -100),     { Side::Right, Side::Back }));
    m_objects.append(new CubeObject(QVector3D(-100, 0, 0),       { Side::Left }));
    m_objects.append(new CubeObject(QVector3D(100, 0, 0),        { Side::Right }));
    m_objects.append(new CubeObject(QVector3D(-100, 0, 100),     { Side::Front, Side::Left }));
    m_objects.append(new CubeObject(QVector3D(0, 0, 100),        { Side::Front }));
    m_objects.append(new CubeObject(QVector3D(100, 0, 100),      { Side::Front, Side::Right }));
    m_objects.append(new CubeObject(QVector3D(-100, -100, -100), { Side::Back, Side::Left, Side::Down }));
    m_objects.append(new CubeObject(QVector3D(0, -100, -100),    { Side::Down, Side::Back }));
    m_objects.append(new CubeObject(QVector3D(100, -100, -100),  { Side::Down, Side::Right, Side::Back }));
    m_objects.append(new CubeObject(QVector3D(-100, -100, 0),    { Side::Down, Side::Left }));
    m_objects.append(new CubeObject(QVector3D(0, -100, 0),       { Side::Down }));
    m_objects.append(new CubeObject(QVector3D(100, -100, 0),     { Side::Down, Side::Right }));
    m_objects.append(new CubeObject(QVector3D(-100, -100, 100),  { Side::Front, Side::Left, Side::Down }));
    m_objects.append(new CubeObject(QVector3D(0, -100, 100),     { Side::Front, Side::Down }));
    m_objects.append(new CubeObject(QVector3D(100, -100, 100),   { Side::Front, Side::Right, Side::Down }));
}

int CubeModel::rowCount(const QModelIndex &) const
{
    return m_objects.count();
}

QVariant CubeModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_objects.count())
        return {};

    const CubeObject* object = m_objects[index.row()];

    if (role == MatrixRole)
        return object->matrix();
    else if (role == SideListRole)
        return object->sideList();

    return {};
}

void CubeModel::rotateCubeSide(const Side &side, const bool clockwise, const bool instant)
{
    for (int i = 0; i < m_objects.length(); i++) {
        CubeObject* cubeObject = m_objects.at(i);

        bool right  = cubeObject->matrix().column(3).x() >  10;
        bool top    = cubeObject->matrix().column(3).y() >  10;
        bool front  = cubeObject->matrix().column(3).z() >  10;
        bool left   = cubeObject->matrix().column(3).x() < -10;
        bool bottom = cubeObject->matrix().column(3).y() < -10;
        bool back   = cubeObject->matrix().column(3).z() < -10;

        switch (side) {
        case Side::Up:    if (!top)    continue; break;
        case Side::Front: if (!front)  continue; break;
        case Side::Right: if (!right)  continue; break;
        case Side::Back:  if (!back)   continue; break;
        case Side::Left:  if (!left)   continue; break;
        case Side::Down:  if (!bottom) continue; break;
        }

        int direction = clockwise ? -1 : 1;
        QVector3D axis;

        switch (side) {
        case Side::Up:    axis = QVector3D(0, direction, 0); break;
        case Side::Down:  axis = QVector3D(0, -direction, 0); break;
        case Side::Front: axis = QVector3D(0, 0, direction); break;
        case Side::Back:  axis = QVector3D(0, 0, -direction); break;
        case Side::Right: axis = QVector3D(direction, 0, 0); break;
        case Side::Left:  axis = QVector3D(-direction, 0, 0); break;
        }

        QMatrix4x4 m;
        m.rotate(90, axis);
        cubeObject->setMatrix(m * cubeObject->matrix());

        emit dataChanged(index(i), index(i), { MatrixRole });

        emit rotateCell(i, axis, instant);
    }
}

QHash<int, QByteArray> CubeModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[MatrixRole] = "role_matrix";
    roles[SideListRole] = "role_sideList";

    return roles;
}
