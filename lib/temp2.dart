// import 'dart:async';
// import 'dart:io'
// import 'dart:math';
// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
//
// class MyApp1 extends StatefulWidget {
//   const MyApp1({super.key});
//
//   @override
//release
//   State<MyApp1> createState() => _MyApp1State();
// }
//
// class _MyApp1State extends State<MyApp1> {
//   bool isCupertino = !kIsWeb && Platform.isIOS;
//
//   @override
//   Widget build(BuildContext context) {
//     if (!isCupertino) {
//       return MaterialApp(
//         title: 'flutter_typeahead demo',
//         scrollBehavior: const MaterialScrollBehavior().copyWith(
//             dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
//         home: DefaultTabController(
//           length: 3,
//           child: Scaffold(
//               appBar: AppBar(
//                 leading: IconButton(
//                   icon: const Icon(Icons.phone_iphone),
//                   onPressed: () => setState(() {
//                     isCupertino = true;
//                   }),
//                 ),
//                 title: const TabBar(tabs: [
//                   Tab(text: 'Example 1: Navigation'),
//                   Tab(text: 'Example 2: Form'),
//                   Tab(text: 'Example 3: Scroll')
//                 ]),
//               ),
//               body: GestureDetector(
//                 onTap: () => FocusScope.of(context).unfocus(),
//                 child: TabBarView(children: [
//                   const NavigationExample(),
//                   const FormExample(),
//                   ScrollExample(),
//                 ]),
//               )),
//         ),
//       );
//     } else {
//       return CupertinoApp(
//         title: 'Cupertino demo',
//         home: Scaffold(
//           appBar: CupertinoNavigationBar(
//             leading: IconButton(
//               icon: const Icon(Icons.android),
//               onPressed: () => setState(() {
//                 isCupertino = false;
//               }),
//             ),
//             middle: const Text('Cupertino demo'),
//           ),
//           body: const CupertinoPageScaffold(
//             child: FavoriteCitiesPage(),
//           ),
//         ), //MyHomePage(),
//       );
//     }
//   }
// }
//
// class NavigationExample extends StatelessWidget {
//   const NavigationExample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(32.0),
//       child: Column(
//         children: <Widget>[
//           const SizedBox(
//             height: 10.0,
//           ),
//           TypeAheadField(
//             textFieldConfiguration: TextFieldConfiguration(
//               autofocus: true,
//               style: DefaultTextStyle.of(context)
//                   .style
//                   .copyWith(fontStyle: FontStyle.italic),
//               decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'What are you looking for?'),
//             ),
//
//             suggestionsCallback: (pattern) async {
//               return await BackendService.getSuggestions(pattern);
//             },
//             itemBuilder: (context, Map<String, String> suggestion) {
//               return ListTile(
//                 leading: const Icon(Icons.shopping_cart),
//                 title: Text(suggestion['name']!),
//                 subtitle: Text('\$${suggestion['price']}'),
//               );
//             },
//             onSuggestionSelected: (Map<String, String> suggestion) {
//               Navigator.of(context).push<void>(MaterialPageRoute(
//                   builder: (context) => ProductPage(product: suggestion)));
//             },
//             suggestionsBoxDecoration: SuggestionsBoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               elevation: 8.0,
//               color: Theme.of(context).cardColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FormExample extends StatefulWidget {
//   const FormExample({super.key});
//
//   @override
//   FormExampleState createState() => FormExampleState();
// }
//
// class FormExampleState extends State<FormExample> {
//   final _formKey = GlobalKey<FormState>();
//
//   final _typeAheadController = TextEditingController();
//
//   String? _selectedCity;
//
//   final suggestionBoxController = SuggestionsBoxController();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // close the suggestions box when the user taps outside of it
//       onTap: () {
//         suggestionBoxController.close();
//       },
//       child: Container(
//         // Add zero opacity to make the gesture detector work
//         color: Colors.amber.withOpacity(0.2),
//         // Create the form for the user to enter their favorite city
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               children: <Widget>[
//                 const Text('What is your favorite city?'),
//                 TypeAheadFormField(
//                   textFieldConfiguration: TextFieldConfiguration(
//                     decoration: const InputDecoration(labelText: 'City'),
//
//                     controller: _typeAheadController,
//                   ),
//                   suggestionsCallback: (pattern) {
//                     return CitiesService.getSuggestions(pattern);
//                   },
//                   itemBuilder: (context, String suggestion) {
//                     return ListTile(
//                       title: Text(suggestion),
//                       leading: const Icon(Icons.add),
//
//                     );
//                   },
//                   // transitionBuilder: (context, suggestionsBox, controller) {
//                   //   return suggestionsBox;
//                   // },
//                   onSuggestionSelected: (String suggestion) {
//                     _typeAheadController.text = suggestion;
//                   },
//                   suggestionsBoxController: suggestionBoxController,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please select a city' : null,
//                   onSaved: (value) => _selectedCity = value,
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   child: const Text('Submit'),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                               'Your Favorite City is ${_selectedCity}'),
//                         ),
//                       );
//                     }
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ProductPage extends StatelessWidget {
//   final Map<String, String> product;
//
//   const ProductPage({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(50.0),
//         child: Column(
//           children: [
//             Text(
//               product['name']!,
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             Text(
//               '${product['price']!} USD',
//               style: Theme.of(context).textTheme.titleMedium,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// This example shows how to use the [TypeAheadField] in a [ListView] that
// /// scrolls. The [TypeAheadField] will resize to fit the suggestions box when
// /// scrolling.
// class ScrollExample extends StatelessWidget {
//   final List<String> items = List.generate(50, (index) => "Item $index");
//
//   ScrollExample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(children: [
//       const Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text("Suggestion box will resize when scrolling"),
//         ),
//       ),
//       const SizedBox(height: 200),
//       TypeAheadField<String>(
//         getImmediateSuggestions: true,
//         textFieldConfiguration: const TextFieldConfiguration(
//           decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'What are you looking for?'),
//         ),
//         suggestionsCallback: (String pattern) async {
//           return items
//               .where((item) =>
//                   item.toLowerCase().startsWith(pattern.toLowerCase()))
//               .toList();
//         },
//         itemBuilder: (context, String suggestion) {
//           return ListTile(
//             title: Text(suggestion),
//           );
//         },
//         onSuggestionSelected: (String suggestion) {
//           if (kDebugMode) {
//             print("Suggestion selected");
//           }
//         },
//       ),
//       const SizedBox(height: 500),
//     ]);
//   }
// }
//
// /// This is a fake service that mimics a backend service.
// /// It returns a list of suggestions after a 1 second delay.
// /// In a real app, this would be a service that makes a network request.
// class BackendService {
//   static Future<List<Map<String, String>>> getSuggestions(String query) async {
//     await Future<void>.delayed(const Duration(seconds: 1));
//
//     return List.generate(3, (index) {
//       return {
//         'name': query + index.toString(),
//         'price': Random().nextInt(100).toString()
//       };
//     });
//   }
// }
//
// /// A fake service to filter cities based on a query.
// class CitiesService {
//   static final List<String> cities = [
//     'Beirut',
//     'Damascus',
//     'San Fransisco',
//     'Rome',
//     'Los Angeles',
//     'Madrid',
//     'Bali',
//     'Barcelona',
//     'Paris',
//     'Bucharest',
//     'New York City',
//     'Philadelphia',
//     'Sydney',
//   ];
//
//   static List<String> getSuggestions(String query) {
//     List<String> matches = <String>[];
//     matches.addAll(cities);
//
//     matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
//     return matches;
//   }
// }
//
// class FavoriteCitiesPage extends StatefulWidget {
//   const FavoriteCitiesPage({super.key});
//
//   @override
//   _FavoriteCitiesPage createState() => _FavoriteCitiesPage();
// }
//
// class _FavoriteCitiesPage extends State<FavoriteCitiesPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _typeAheadController = TextEditingController();
//   final CupertinoSuggestionsBoxController _suggestionsBoxController =
//       CupertinoSuggestionsBoxController();
//   String favoriteCity = 'Unavailable';
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _suggestionsBoxController.close(),
//       child: Container(
//         color: Colors.amber.withOpacity(0),
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(32.0),
//             child: Column(
//               children: <Widget>[
//                 const SizedBox(
//                   height: 100.0,
//                 ),
//                 const Text('What is your favorite city?'),
//                 CupertinoTypeAheadFormField(
//                   getImmediateSuggestions: true,
//                   suggestionsBoxController: _suggestionsBoxController,
//                   suggestionsBoxDecoration: CupertinoSuggestionsBoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   textFieldConfiguration: CupertinoTextFieldConfiguration(
//                     controller: _typeAheadController,
//                   ),
//                   suggestionsCallback: (pattern) {
//                     return Future.delayed(
//                       const Duration(seconds: 1),
//                       () => CitiesService.getSuggestions(pattern),
//                     );
//                   },
//                   itemBuilder: (context, String suggestion) {
//                     return Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Text(
//                         suggestion,
//                       ),
//                     );
//                   },
//                   onSuggestionSelected: (String suggestion) {
//                     _typeAheadController.text = suggestion;
//                   },
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please select a city' : null,
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 CupertinoButton(
//                   child: const Text('Submit'),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       setState(() {
//                         favoriteCity = _typeAheadController.text;
//                       });
//                     }
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 Text(
//                   'Your favorite city is $favoriteCity!',
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class CreatePlanTripRequest {
  CreatePlanTripRequest({
    required this.name,
    required this.companyPathId,
    required this.companyId,
    required this.description,
    required this.driversIds,
    required this.startDate,
    required this.endDate,
    required this.days,
  });

  final String name;
  final num companyPathId;
  final num companyId;
  final String description;
  final List<num> driversIds;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> days;

  factory CreatePlanTripRequest.fromJson(Map<String, dynamic> json){
    return CreatePlanTripRequest(
      name: json["name"] ?? "",
      companyPathId: json["companyPathId"] ?? 0,
      companyId: json["companyId"] ?? 0,
      description: json["description"] ?? "",
      driversIds: json["driversIds"] == null ? [] : List<num>.from(json["driversIds"]!.map((x) => x)),
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      days: json["days"] == null ? [] : List<String>.from(json["days"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "companyPathId": companyPathId,
    "companyId": companyId,
    "description": description,
    "driversIds": driversIds.map((x) => x).toList(),
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "days": days.map((x) => x).toList(),
  };

}
