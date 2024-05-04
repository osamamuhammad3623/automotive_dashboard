#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "warnmgr.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/AutomotiveSpeedometer/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);


    WarnMgr *warnMgr (new WarnMgr);
    engine.rootContext()->setContextProperty("warnMgr", warnMgr);

    return app.exec();
}
