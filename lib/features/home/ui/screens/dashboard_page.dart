//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:intl/intl.dart';
//
// import 'package:qareeb_dash/main.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
//
// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});
//
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }
//
// class _DashboardPageState extends State<DashboardPage> {
//   int selectedIndex = 0;
//
//   ChartSeriesController? _chartSeriesController2;
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           //  title: SelectableText(('dashboard_title'.locale)),
//           ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//           16.0.verticalSpace,
//
//             const SelectableText(
//                 "الجدول يوضح عدد الكيلومترات المقطوعة من قبل كل السائقين و عدد الكيلومترات التي تم تعويض السائقين بها حسب نظام قريب الولاء"),
//             GetBuilder<LoyaltyController>(
//               builder: (controller) {
//                 if (controller.status != Status.Loaded)
//                   return const CircularProgressIndicator();
//
//                 int oil = controller.redeems.totals!
//                             .where((element) => element.key == "Oil")
//                             .toList()
//                             .length >
//                         0
//                     ? controller.redeems.totals!
//                         .where((element) => element.key == "Oil")
//                         .first
//                         .value!
//                     : 0;
//                 int gold = controller.redeems.totals!
//                             .where((element) => element.key == "Gold")
//                             .toList()
//                             .length >
//                         2
//                     ? controller.redeems.totals!
//                         .where((element) => element.key == "Gold")
//                         .first
//                         .value!
//                     : 0;
//                 int tire = controller.redeems.totals!
//                             .where((element) => element.key == "Tire")
//                             .toList()
//                             .length >
//                         0
//                     ? controller.redeems.totals!
//                         .where((element) => element.key == "Tire")
//                         .first
//                         .value!
//                     : 0;
//                 var chartData = <LoyaltyData>[
//                   LoyaltyData(
//                     type: "",
//                     Meters: controller.redeems.totalMeters!,
//                     oilRedeemedMeters: oil,
//                     tiresRedeemedMeters: tire,
//                     goldRedeemedMeters: gold,
//                   ),
//                 ];
//                 return Container(
//                   height: 200,
//                   child: SfCartesianChart(
//                     plotAreaBorderWidth: 0,
//                     legend: const Legend(isVisible: true),
//                     primaryXAxis: CategoryAxis(
//                       majorGridLines: const MajorGridLines(width: 0),
//                     ),
//                     primaryYAxis: NumericAxis(
//                       majorGridLines: const MajorGridLines(width: 0),
//                       numberFormat: NumberFormat.compact(),
//                     ),
//                     series: getDefaultBarSeries(chartData),
//                     tooltipBehavior: TooltipBehavior(enable: true),
//                   ),
//                 );
//               },
//             ),
//
//             GetBuilder<HomeController>(builder: (controller) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     child: Container(
//                       width: 200.w,
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SelectableText(
//                             "أفضل سائق",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                           const Divider(
//                             thickness: 2,
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Column(
//                                 children: [
//                                   const SelectableText(
//                                     "الاسم",
//                                     style: TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                   SelectableText(
//                                     homeController.bestDriver?.name ?? "",
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               Column(
//                                 children: [
//                                   const SelectableText(
//                                     "عدد الرحلات",
//                                     style: TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                   SelectableText(
//                                     "${homeController.bestDriver.count != null ? homeController.bestDriver.count!.round() : 0}",
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   const SelectableText(
//                                     "عدد الساعات",
//                                     style: TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                   SelectableText(
//                                     "${homeController.bestDriver?.clocks ?? 0}",
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   const SelectableText(
//                                     "عدد الكيلومترات",
//                                     style: TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                   SelectableText(
//                                     "${homeController.bestDriver?.clocks ?? 0}",
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     child: Container(
//                       width: 200.w,
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SelectableText(
//                             "عدد المستخدمين الجدد",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                           const Divider(
//                             thickness: 2,
//                           ),
//                           const SizedBox(height: 8),
//                           SelectableText("${homeController.newCustomers.round() ?? 0}"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             })
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 16),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: [
//             //       Spacer(),
//             //       SizedBox(
//             //         width: 200,
//             //         child: CupertinoSlidingSegmentedControl<int>(
//             //           children: {
//             //             0: SelectableText(('daily'.locale)),
//             //             1: SelectableText(('monthly'.locale)),
//             //             2: SelectableText(('all_time'.locale)),
//             //           },
//             //           onValueChanged: (value) {
//             //             setState(() {
//             //               _selectedIndex = value!;
//             //               _chartSeriesController2?.animate();
//             //             });
//             //           },
//             //           groupValue: _selectedIndex,
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(16),
//             //   child: SfCartesianChart(
//             //     title: ChartTitle(text: ('trip_count_title'.locale)),
//             //     legend: Legend(
//             //       isVisible: true,
//             //       position: LegendPosition.top,
//             //       textStyle: TextStyle(fontSize: 14),
//             //       borderColor: Colors.grey[300],
//             //     ),
//             //     primaryXAxis: CategoryAxis(
//             //       labelStyle: TextStyle(fontSize: 12),
//             //       labelIntersectAction: AxisLabelIntersectAction.rotate45,
//             //     ),
//             //     primaryYAxis: NumericAxis(
//             //       labelFormat: '{value} ${('trips'.locale)}',
//             //       labelStyle: TextStyle(fontSize: 12),
//             //     ),
//             //     series: <ChartSeries>[
//             //       LineSeries<TripData, String>(
//             //         dataSource: getTripData(),
//             //         xValueMapper: (TripData trip, _) => trip.date,
//             //         yValueMapper: (TripData trip, _) => trip.trips,
//             //         enableTooltip: true,
//             //         animationDuration: 2000,
//             //         onRendererCreated: (ChartSeriesController controller) {
//             //           _chartSeriesController2 = controller;
//             //         },
//             //         markerSettings: MarkerSettings(isVisible: true),
//             //         yAxisName: ('trips'),
//             //         name: ('trips'),
//             //       )
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<TripData> getTripData() {
//     // TODO: Implement your data retrieval logic here
//     // This is an example data set
//     switch (selectedIndex) {
//       case 0:
//         return [
//           TripData('May 1', 4),
//           TripData('May 2', 6),
//           TripData('May 3', 10),
//           TripData('May 4', 8),
//           TripData('May 5', 12),
//           TripData('May 6', 14),
//           TripData('May 7', 16),
//         ];
//       case 1:
//         return [
//           TripData('May', 44),
//           TripData('June', 56),
//           TripData('July', 78),
//           TripData('August', 62),
//           TripData('September', 88),
//         ];
//       case 2:
//         return [
//           TripData('2020', 424),
//           TripData('2021', 564),
//           TripData('2022', 786),
//           TripData('2023', 622),
//         ];
//       default:
//         return [];
//     }
//   }
// }
//
// class TripData {
//   final String date;
//   final int trips;
//
//   TripData(this.date, this.trips);
// }
//
// class LoyaltyData {
//   String type;
//   int Meters;
//   int oilRedeemedMeters;
//   int tiresRedeemedMeters;
//   int goldRedeemedMeters;
//
//   LoyaltyData({
//     required this.type,
//     required this.Meters,
//     required this.oilRedeemedMeters,
//     required this.tiresRedeemedMeters,
//     required this.goldRedeemedMeters,
//   });
// }
//
// /// Returns the list of chart series which need to render on the barchart.
// List<BarSeries<LoyaltyData, String>> getDefaultBarSeries(List<LoyaltyData> chartData) {
//   return <BarSeries<LoyaltyData, String>>[
//     BarSeries<LoyaltyData, String>(
//         dataSource: chartData!,
//         xValueMapper: (LoyaltyData sales, _) => sales.type as String,
//         yValueMapper: (LoyaltyData sales, _) => sales.Meters,
//         name: 'km'.locale),
//     BarSeries<LoyaltyData, String>(
//         dataSource: chartData!,
//         xValueMapper: (LoyaltyData sales, _) => sales.type as String,
//         yValueMapper: (LoyaltyData sales, _) => sales.oilRedeemedMeters,
//         name: 'oil'.locale),
//     BarSeries<LoyaltyData, String>(
//         dataSource: chartData!,
//         xValueMapper: (LoyaltyData sales, _) => sales.type as String,
//         yValueMapper: (LoyaltyData sales, _) => sales.tiresRedeemedMeters,
//         name: 'tires'.locale),
//     BarSeries<LoyaltyData, String>(
//         dataSource: chartData!,
//         xValueMapper: (LoyaltyData sales, _) => sales.type as String,
//         yValueMapper: (LoyaltyData sales, _) => sales.goldRedeemedMeters,
//         name: 'gold'.locale)
//   ];
// }
