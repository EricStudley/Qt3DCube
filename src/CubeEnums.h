#pragma once

#include <QObject>

class CubeEnums
{
    Q_GADGET
public:
    enum SideEnum {
        Up = 0,
        Front,
        Right,
        Back,
        Left,
        Down
    };
    Q_ENUM(SideEnum)

    enum ColorEnum {
        White,
        Green,
        Red,
        Blue,
        Orange,
        Yellow,
    };
    Q_ENUM(ColorEnum)

private:
    explicit CubeEnums() = delete;
};

typedef CubeEnums::SideEnum Side;
typedef CubeEnums::ColorEnum Color;
