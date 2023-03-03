#pragma once

#include <QStack>
#include <QQueue>
#include <QTimer>

#include "CubeModel.h"

class CubeCommand {
public:
    CubeCommand() {}
    CubeCommand(Side side, bool clockwise)
    {
        this->side = side;
        this->clockwise = clockwise;
    }

    void reverse() {
        clockwise = !clockwise;
    }

    Side side;
    bool clockwise;
};

class CubeController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool processingCommands READ processingCommands NOTIFY processingCommandsChanged)

public:
    explicit CubeController(CubeModel *cubeModel, QObject *parent = nullptr);

    Q_INVOKABLE void setCubeState(QString state);

    Q_INVOKABLE void shuffleCube();
    Q_INVOKABLE void solveCube();
    Q_INVOKABLE void rotateCubeSide(const Side &side, const bool clockwise);

    // Q_PROPERTY READ
    bool processingCommands() const;

signals:
    void rotateCell(const int cellIndex, const QVector3D &axis, const bool instant);

    // Q_PROPERTY NOTIFY
    void processingCommandsChanged();

private slots:
    void onProcessCommands();

private:
    void queueCommand(const CubeCommand& cubeCommand);

private:
    CubeModel* m_cubeModel = nullptr;

    QStack<CubeCommand> m_allCommands;
    QQueue<CubeCommand> m_incomingCommands;
    QTimer* processCommands = new QTimer(this);
};
