import 'package:get/get.dart';

class Message extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "vi_VI" : {
      "start": "Bắt đầu",
      "title_start": "Tàu chiến \n trên... Radar",
      "mode": "Chế độ",
      "pvco": "Đánh với máy",
      "bluetooh": "Qua Bluetooh",
      "pvp": "PvsP",
      "map": "Bản đồ",
      "select_ship": "Số lượng tàu",
      "play": "Chơi"
    },
    "en_US" : {
      "start": "Start",
      "title_start": "Battleship \n in... Radar",
      "mode": "Mode",
      "pvco": "Fighting against the computer",
      "bluetooh": "Via bluetooh",
      "pvp": "PvsP",
      "map": "Map",
      "select_ship": "Select Ship count",
      "play": "Play"
    }
  };
}