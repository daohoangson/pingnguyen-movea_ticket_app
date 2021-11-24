import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movea_ticket_app/modules/booking/blocs/seat_info.dart';
import 'package:movea_ticket_app/modules/booking/repos/data.dart';

class MiniMap extends StatefulWidget {
  const MiniMap({
    Key? key,
    required this.mapSize,
    required this.flyBoxSize,
    required this.onMoving,
  }) : super(key: key);

  final Size mapSize;
  final Size flyBoxSize;
  final Function(double dx) onMoving;

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  final GlobalKey containerKey = GlobalKey();
  Offset _pos = const Offset(0, 0);

  @override
  void initState() {
    // _pos = Offset(widget.mapSize.width / 2 - widget.flyBoxSize.width / 2,
    //     widget.mapSize.height / 2 - widget.flyBoxSize.height / 2);
    _pos = const Offset(0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.mapSize.width,
      height: widget.mapSize.height,
      child: Stack(children: [
        _buildBackgroundContainer(containerKey),
        Positioned(
            top: _pos.dy,
            left: _pos.dx,
            child: Draggable(
              child: _buildFlyBox(widget.flyBoxSize),
              feedback: _buildFlyBoxFeedBack(widget.flyBoxSize),
              onDragEnd: (dragDetail) {
                final pos = _calculatePositionFromDragging(dragDetail.offset);
                setState(() => _pos = pos);
                widget.onMoving(pos.dx / widget.mapSize.width);
              },
            ))
      ]),
    );
  }

  Offset _calculatePositionFromDragging(Offset dragOffset) {
    final rb = containerKey.currentContext!.findRenderObject() as RenderBox;
    final containerOffset = rb.localToGlobal(Offset.zero);
    final newX = dragOffset.dx - containerOffset.dx;
    final newY = dragOffset.dy - containerOffset.dy;
    final maxX = widget.mapSize.width - widget.flyBoxSize.width;
    final maxY = widget.mapSize.height - widget.flyBoxSize.height;
    return Offset(
      max(.0, min(maxX, newX)),
      max(.0, min(maxY, newY)),
    );
  }

  Widget _buildBackgroundContainer(Key key) {
    return Container(
      key: key,
      color: const Color(0xFF0B0F2F),
      child: _buildMiniMap(),
    );
  }

  Widget _buildFlyBox(Size sz) {
    return Container(
      width: sz.width,
      height: sz.height,
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.red, width: 2.0, style: BorderStyle.solid),
      ),
    );
  }

  Widget _buildFlyBoxFeedBack(Size sz) {
    return Container(
      width: sz.width,
      height: sz.height,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blue, width: 2.0, style: BorderStyle.solid),
      ),
    );
  }

  Widget _buildMiniMap() {
    return Row(
      children: infos.toWidgets(SeatSize.mini),
    );
  }
}
