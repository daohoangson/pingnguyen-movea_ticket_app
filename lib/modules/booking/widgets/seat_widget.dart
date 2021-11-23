import 'package:flutter/material.dart';
import 'package:movea_ticket_app/values/seat_colors.dart';
import 'package:movea_ticket_app/modules/booking/blocs/seat_info.dart';

class Seat extends StatelessWidget {
  Seat({Key? key, required this.info}) : super(key: key);
  SeatInfo info;
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
          top: (info.seatSize == SeatSize.mini) ? 1 : 4,
          left: (info.seatSize == SeatSize.mini) ? 1 : 4),
      child: info.seatCode.isNotEmpty
          ? Container(
              width: (info.seatSize == SeatSize.mini) ? 8 : 44,
              height: (info.seatSize == SeatSize.mini) ? 8 : 44,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: color,
                ),
                borderRadius: BorderRadius.circular(
                    (info.seatSize == SeatSize.mini) ? 2 : 10),
              ),
              child: Center(
                  child: Text(
                info.seatCode,
                style: TextStyle(
                    fontSize: (info.seatSize == SeatSize.mini) ? 4 : 22,
                    color: Colors.white),
              )),
            )
          : SizedBox(
              width: (info.seatSize == SeatSize.mini) ? 8 : 44,
              height: (info.seatSize == SeatSize.mini) ? 8 : 44,
            ),
    );
  }
}
