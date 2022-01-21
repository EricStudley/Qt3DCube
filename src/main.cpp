#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "CubeEnums.h"
#include "CubeModel.h"
#include "CubeController.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    CubeModel* cubeModel = new CubeModel(&app);
    CubeController *cubeController = new CubeController(cubeModel, &app);

    qRegisterMetaType<Side>("Side");
    qRegisterMetaType<Color>("Color");
    qmlRegisterUncreatableType<CubeEnums>("Cube", 1, 0, "Side", "Error: Side is an enum type.");
    qmlRegisterUncreatableType<CubeEnums>("Cube", 1, 0, "Color", "Error: Color is an enum type.");

    QVector<QQmlContext::PropertyPair> contextProperties;
    contextProperties.append(QQmlContext::PropertyPair{"cubeModel", QVariant::fromValue(cubeModel)});
    contextProperties.append(QQmlContext::PropertyPair{"cubeController", QVariant::fromValue(cubeController)});
    engine.rootContext()->setContextProperties(contextProperties);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
