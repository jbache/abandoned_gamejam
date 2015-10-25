#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QFontDatabase fonts;
    fonts.addApplicationFont(":fonts/NEUROPOL.ttf");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

