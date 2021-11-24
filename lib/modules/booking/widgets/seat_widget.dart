import 'package:flutter/material.dart';
import 'package:movea_ticket_app/values/seat_colors.dart';
import 'package:movea_ticket_app/modules/booking/blocs/seat_info.dart';

class Seat extends StatelessWidget {
  final SeatInfo info;
  final SeatSize size;

  const Seat({
    Key? key,
    required this.info,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Color color;

    switch (info.seatStatus) {
      case SeatStatus.selected:
        color = SeatColors.selected;
        break;
      case SeatStatus.occupied:
        color = SeatColors.occupied;
        break;
      default:
        color = SeatColors.available;
    }
    return Padding(
      padding: EdgeInsets.only(
          top: (size == SeatSize.mini) ? 1 : 4,
          left: (size == SeatSize.mini) ? 1 : 4),
      child: info.seatCode.isNotEmpty
          ? Container(
              width: (size == SeatSize.mini) ? 8 : 44,
              height: (size == SeatSize.mini) ? 8 : 44,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: color,
                ),
                borderRadius:
                    BorderRadius.circular((size == SeatSize.mini) ? 2 : 10),
              ),
              child: Center(
                  child: Text(
                info.seatCode,
                style: TextStyle(
                    fontSize: (size == SeatSize.mini) ? 4 : 22,
                    color: Colors.white),
              )),
            )
          : SizedBox(
              width: (size == SeatSize.mini) ? 8 : 44,
              height: (size == SeatSize.mini) ? 8 : 44,
            ),
    );
  }
}
