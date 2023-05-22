import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/values/app_animation_assets.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widget/ticket_item.dart';
import '../../../data/models/student_trip_model.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_ticket_data_service.dart';
import '../views/tab_views/today_ticket_view.dart';
import '../views/tab_views/future_ticket_view.dart';
import '../views/tab_views/past_ticket_view.dart';
import 'ticket_data_service.dart';

class TicketController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final tabs = [
    const Tab(text: 'Hôm nay'),
    const Tab(text: 'Trước đó'),
    const Tab(text: 'Sau này'),
  ];

  Rx<int> tabIndex = 0.obs;
  final List<Widget> screens = [
    const TodayTicketView(),
    const PastTicketView(),
    const FutureTicketView(),
  ];

  void changeTab(int index) {
    tabController.index = index;
    tabIndex.value = index;
  }

  TicketDataService ticketDataService = TicketDataService();

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    ticketDataService.fetchTickets();
    super.onInit();
  }

  HomeTicketDataService homeTicketDataService =
      Get.find<HomeTicketDataService>();

  Widget todayTickets() {
    return Obx(
      () {
        if (ticketDataService.isLoading) {
          return Center(
            child: Lottie.asset(
              AppAnimationAssets.loading,
              height: 100.r,
            ),
          );
        }

        List<Widget> ticketList = [];

        for (Ticket ticket in ticketDataService.todayTickets) {
          ticketList.add(ticketItem(ticket, 'Hôm nay'));
          ticketList.add(SizedBox(
            height: 10.h,
          ));
        }

        if (ticketList.isEmpty) {
          return Center(child: Text('Không có vé', style: body2));
        }

        return Column(
          children: ticketList,
        );
      },
    );
  }

  Widget pastTickets() {
    return Obx(
      () {
        if (ticketDataService.isLoading) {
          return Center(
            child: Lottie.asset(
              AppAnimationAssets.loading,
              height: 100.r,
            ),
          );
        }

        List<Widget> ticketList = [];

        for (Ticket ticket in ticketDataService.pastTickets) {
          ticketList.add(ticketItem(ticket, 'Đã qua'));
          ticketList.add(SizedBox(
            height: 10.h,
          ));
        }

        if (ticketList.isEmpty) {
          return Center(child: Text('Không có vé', style: body2));
        }

        return Column(
          children: ticketList,
        );
      },
    );
  }

  Widget futureTickets() {
    return Obx(
      () {
        if (ticketDataService.isLoading) {
          return Center(
            child: Lottie.asset(
              AppAnimationAssets.loading,
              height: 100.r,
            ),
          );
        }

        List<Widget> ticketList = [];

        for (Ticket ticket in ticketDataService.futureTickets) {
          ticketList.add(ticketItem(ticket, 'Sắp tới'));
          ticketList.add(SizedBox(
            height: 10.h,
          ));
        }

        if (ticketList.isEmpty) {
          return Center(child: Text('Không có vé', style: body2));
        }

        return Column(
          children: ticketList,
        );
      },
    );
  }

  Widget ticketItem(Ticket ticket, String title) {
    Ticket? currentTicket = homeTicketDataService.ticket;

    if (currentTicket?.id == ticket.id) {
      ticket.isCurrent = true;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: TicketItem(
        title: ticket.title,
        ticket: ticket,
        state: TicketItemExpandedState.less,
        backgroundColor: ticket.backgroundColor,
        textColor: ticket.textColor,
        onPressed: () {
          Get.toNamed(Routes.TICKET_DETAIL, arguments: {'ticket': ticket});
        },
      ),
    );
  }
}
