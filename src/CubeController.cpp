#include "CubeController.h"

#include "CubeEnums.h"

CubeController::CubeController(CubeModel *cubeModel, QObject *parent)
    : QObject(parent), m_cubeModel(cubeModel)
{
    QObject::connect(processCommands, &QTimer::timeout, this, &CubeController::onProcessCommands);

    processCommands->start(100);
}

void CubeController::shuffleCube()
{
    for (int i = 0; i < 50; i++) {
        const int random = rand();
        const Side randomSide = static_cast<Side>(random % Side::Down + 1);
        const bool randomDirection = random & 1;

        queueCommand(CubeCommand(randomSide, randomDirection));
    }
}

void CubeController::solveCube()
{
    m_incomingCommands.clear();

    while (!m_allCommands.isEmpty()) {
        CubeCommand cubeCommand = m_allCommands.pop();
        cubeCommand.reverse();
        m_incomingCommands.enqueue(cubeCommand);
    }
}

void CubeController::rotateCubeSide(const Side &side, const bool clockwise)
{
    queueCommand(CubeCommand(side, clockwise));
}

bool CubeController::processingCommands() const
{
    return !m_incomingCommands.isEmpty();
}

void CubeController::onProcessCommands()
{
    if (!m_incomingCommands.isEmpty()) {
        const CubeCommand& command = m_incomingCommands.dequeue();

        m_cubeModel->rotateCubeSide(command.side, command.clockwise);

        emit processingCommandsChanged();
    }
}

void CubeController::queueCommand(const CubeCommand& cubeCommand)
{
    m_allCommands.push(cubeCommand);
    m_incomingCommands.enqueue(cubeCommand);
}
