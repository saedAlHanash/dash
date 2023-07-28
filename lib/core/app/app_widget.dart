import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_super_user/core/strings/app_color_manager.dart';

import '../../core/injection/injection_container.dart' as di;
import '../../features/qr/ui/pages/qr_page.dart';
import '../../router/app_router.dart';
import '../app_theme.dart';
import 'bloc/loading_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final loading = Builder(builder: (context) {
      return Visibility(
        visible: context.watch<LoadingCubit>().state.isLoading,
        child: const SafeArea(
          child: Column(
            children: [
              LinearProgressIndicator(),
            ],
          ),
        ),
      );
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LoadingCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        builder: (context, child) {
          DrawableText.initial(
            initialColor: AppColorManager.mainColor,
            initialSize: 16.0.sp,
            headerSizeText: 18.0.sp,
            titleSizeText: 16.0.sp,
            initialHeightText: 1.5.spMin,
          );
          return MaterialApp(
            builder: (context, child) {
              return Stack(
                children: [
                  Directionality(textDirection: TextDirection.rtl, child: child!),
                  loading,
                ],
              );
            },
            debugShowCheckedModeBanner: false,
            theme: appTheam,
            navigatorKey: di.sl<GlobalKey<NavigatorState>>(),
            onGenerateRoute: AppRoutes.routes,
            // home:  MyApp2(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DraggableScrollableSheet'),
      ),
      body: Stack(
        children: [
          Container(
            height: 300.0,
            color: AppColorManager.red,
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              maxChildSize: 0.5,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.blue[100],
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
