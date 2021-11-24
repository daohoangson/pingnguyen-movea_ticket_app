class SeatInfo {
  String seatCode = '';
  SeatPosition seatPos = SeatPosition(1, 1);
  SeatStatus seatStatus = SeatStatus.available;
  SeatInfo(this.seatCode, this.seatPos, SeatStatus? seatStatus) {
    if (seatStatus != null) {
      this.seatStatus = seatStatus;
    }
  }
}

class SeatPosition {
  int seatX = 1;
  int seatY = 1;

  SeatPosition(this.seatX, this.seatY);
}

enum SeatStatus { available, occupied, selected }
enum SeatSize { mini, normal }
