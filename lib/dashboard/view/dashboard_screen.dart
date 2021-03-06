import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_flutter_components/dashboard/cubit/dashboard_cubit.dart';

import 'package:mx_flutter_components/dashboard/view/widgets/category_widget.dart';
import 'package:mx_flutter_components/dashboard/view/widgets/chart_widget.dart';
import 'package:mx_flutter_components/dashboard/view/widgets/dashboard_widget.dart';
import 'package:mx_flutter_components/dashboard/view/widgets/drawer_widget.dart';
import 'package:mx_flutter_components/dashboard/view/widgets/search_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const route = "DASHBOARD_SCREEN";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            key: ValueKey('drawer-icon-key'),
            onTap: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(radius: 30, backgroundColor: Colors.grey.withOpacity(0.25)),
                  CircleAvatar(radius: 30, backgroundColor: Colors.grey.withOpacity(0.25)),
                  CircleAvatar(radius: 30, backgroundColor: Colors.grey.withOpacity(0.25)),
                ],
              ),
            ),
            const DrawerWidget(),
            const DrawerWidget(),
            const DrawerWidget(),
            DrawerWidget(
              key: const ValueKey('drawer-item-key'),
              color: Colors.blue.withOpacity(0.5),
              onTap: () {
                /// Handling close drawer menu first
                Navigator.pop(context);

                /// Navigate to MxCryptoScreen of mx_crypto_ui package
                Navigator.pushNamed(context, MxCryptoScreen.route);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: const [
              /// Search Bar
              SearchBar(),

              /// Dashboard Widget
              DashboardWidget(),

              /// Category View
              CategoryWidget(),

              /// Chart View
              ChartWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
