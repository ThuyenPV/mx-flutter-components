import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mx_crypto_ui/mx_crypto_ui.dart';
import 'package:mx_flutter_components/home/home.dart';
import 'package:mx_flutter_components/l10n/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = "HOME_SCREEN";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(l10n.counterAppBarTitle),
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
            DrawerWidget(),
            DrawerWidget(),
            DrawerWidget(),
            DrawerWidget(
              color: Colors.lightBlue,
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
      body: const Center(),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    this.onTap,
    this.color,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color ?? Colors.grey.withOpacity(0.25),
        ),
        title: Container(
          height: 30,
          decoration: BoxDecoration(
            color: color ?? Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
