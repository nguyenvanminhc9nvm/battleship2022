//image
import 'dart:ui';

class ImageConst {
  static const String icStart = "assets/image/ic_start.png";
  static const String icPlay = "assets/image/ic_play.svg";
  static const String icMode = "assets/image/ic_mode.png";
  static const String icPvCo = "assets/image/ic_pvscomputer.svg";
  static const String icBluetooh = "assets/image/ic_bluetooh.svg";
  static const String icPvp = "assets/image/ic_pvp.svg";
  static const String icSetting = "assets/image/ic_setting.png";
  static const String icMap35 = "assets/image/ic_map_35.svg";
  static const String icMap45 = "assets/image/ic_map_45.svg";
  static const String icMap55 = "assets/image/ic_map_55.svg";
  static const String icShip1 = "assets/image/ic_ship_1.svg";
  static const String icShip2 = "assets/image/ic_ship_2.svg";
  static const String icShip3 = "assets/image/ic_ship_3.svg";
  static const String icShip4 = "assets/image/ic_ship_4.svg";
  static const String icMapRound35 = "assets/image/ic_map_round_35.svg";
}

class ColorConst {
  static Color convert(String color) {
    try {
      color = color.replaceAll("#", "");
      if (color.length == 6) {
        return Color(int.parse("0xFF" + color));
      } else if (color.length == 8) {
        return Color(int.parse("0x" + color));
      }
    } catch (ex) {}
    return const Color(0xFFEA2626);
  }
  static Color get colorBtn => convert("182F30");
  static Color get colorBorder => convert("00FFFF");
}