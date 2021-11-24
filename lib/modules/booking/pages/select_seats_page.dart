import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movea_ticket_app/modules/booking/blocs/seat_info.dart';
import 'package:movea_ticket_app/modules/booking/repos/data.dart';
import 'package:movea_ticket_app/modules/booking/widgets/mini_map.dart';
import 'package:movea_ticket_app/values/app_colors.dart';
import 'package:movea_ticket_app/values/seat_colors.dart';

class SelectSeats extends StatefulWidget {
  SelectSeats({Key? key}) : super(key: key);

  @override
  State<SelectSeats> createState() => _SelectSeatsState();
}

class _SelectSeatsState extends State<SelectSeats> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mqd = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.veryDarkBackGround,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textColor,
            size: 32,
          ),
          onPressed: () {},
        ),
      ),
      backgroundColor: AppColors.veryDarkBackGround,
      body: Column(
        children: [
          _buildTitle(),
          _buildGuide(),
          const Spacer(),
          Stack(
            children: [
              Container(
                height: 480,
                color: Colors.black38,
                child: _buildSeatsMap(),
              ),
              Positioned(
                child: AnimatedBuilder(
                  animation: _scrollController,
                  builder: (context, child) {
                    const miniMapWidth = 180.0;
                    const miniMapHeight = 90.0;

                    final scroll = _scrollController.position;
                    final viewportDimension = scroll.hasViewportDimension
                        ? scroll.viewportDimension
                        : mqd.size.width;
                    final maxScrollExtent = scroll.hasContentDimensions
                        ? scroll.maxScrollExtent
                        : 0.0;
                    final fullMapWidth = viewportDimension + maxScrollExtent;

                    if (!scroll.hasContentDimensions) {
                      // hack: trigger rebuild if scroll info is incomplete
                      WidgetsBinding.instance
                          ?.addPostFrameCallback((_) => setState(() {}));
                    }

                    return Visibility(
                      visible: fullMapWidth > viewportDimension,
                      child: MiniMap(
                        dx: scroll.pixels / fullMapWidth,
                        mapSize: const Size(miniMapWidth, miniMapHeight),
                        flyBoxSize: Size(
                          viewportDimension / fullMapWidth * miniMapWidth,
                          miniMapHeight,
                        ),
                        onMoving: (dx) {
                          _scrollController.animateTo(
                            dx * fullMapWidth,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          const Spacer(),
          _buildScreen(),
          _buildFooter(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildSeatsMap() {
    return ListView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      children: infos.toWidgets(SeatSize.normal),
    );
  }

  Widget _buildScreen() {
    return Column(
      children: [
        const Text(
          'Screen',
          style: TextStyle(color: AppColors.textColor),
        ),
        Image.asset(
          'assets/images/Screen.png',
          height: 60,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const ListTile(
      dense: true,
      title: Text(
        'Ralph Breaks the Internet',
        style: TextStyle(fontSize: 18, color: AppColors.textColor),
      ),
      subtitle: Text(
        'FX Sudirman XXI',
        style: TextStyle(fontSize: 12, color: AppColors.textColor),
      ),
    );
  }

  Widget _buildGuide() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: SeatColors.available),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Available',
                    style: TextStyle(color: AppColors.textColor))
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: SeatColors.occupied),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Booked',
                    style: TextStyle(color: AppColors.textColor))
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: SeatColors.selected),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Your Seat',
                    style: TextStyle(color: AppColors.textColor))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: const [
              Text(
                'Total Price (3 tickets)',
                style: TextStyle(fontSize: 14, color: AppColors.textColor),
              ),
              Text(
                'Rp 150.000',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Book Ticket'),
            ),
          ),
        )
      ],
    );
  }
}
