import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:movea_ticket_app/modules/booking/blocs/seat_info.dart';
import 'package:movea_ticket_app/modules/booking/widgets/seat_widget.dart';

final _full = <SeatInfo>[
  SeatInfo('A1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('B1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('C1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('D1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('E1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('F1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('G1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('H1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('I1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('J1', SeatPosition(1, 1), SeatStatus.available),
];
final _miss4 = <SeatInfo>[
  SeatInfo('A1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('B1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('C1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('D1', SeatPosition(1, 1), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
];

final _empty = <SeatInfo>[
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
  SeatInfo('', SeatPosition(0, 0), SeatStatus.available),
];

List<List<SeatInfo>>? _infos;
List<List<SeatInfo>> get infos {
  if (_infos != null) {
    return _infos!;
  }

  final infos = _infos = [];
  infos.add(_miss4);
  infos.add(_miss4);
  for (int i = 2; i < 6; i++) {
    infos.add(_full);
  }
  infos.add(_empty);
  for (int i = 0; i < 6; i++) {
    infos.add(_full);
  }
  infos.add(_empty);
  for (int i = 2; i < 6; i++) {
    infos.add(_full);
  }
  infos.add(_miss4);
  infos.add(_miss4);

  //Random some seat status for fun
  _full[Random().nextInt(9)].seatStatus = SeatStatus.occupied;

  return infos;
}

extension SeatInfoGrid on List<List<SeatInfo>> {
  List<Widget> toWidgets(SeatSize size) {
    return map((list) => Column(
          children: list
              .map((info) => Seat(
                    info: info,
                    size: size,
                  ))
              .toList(growable: false),
        )).toList(growable: false);
  }
}
