import 'package:financial/application.dart';
import 'package:financial/authentication/authentication.dart';
import 'package:financial/authentication/authentication_bloc.dart';
import 'package:financial/pages/add_record/add_record_page.dart';
import 'package:financial/pages/overview/overview_page.dart';
import 'package:financial/styling.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final GlobalKey _fabKey = GlobalKey();

  int _selectedIndex;
  AuthenticationBloc authenticationBloc;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  selectTab(index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(_selectedIndex,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          selectTab(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("Overview"),
            icon: Icon(Icons.pie_chart),
            backgroundColor: AppTheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text("Transactions"),
            backgroundColor: AppTheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            title: Text("Bills"),
            backgroundColor: AppTheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text("Reports"),
            backgroundColor: AppTheme.primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
            backgroundColor: AppTheme.primary,
          ),
        ],
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (BuildContext context, state) {
          if (state is AuthenticationUnauthenticated) {
            Application.router.navigateTo(context, '/',
                transition: TransitionType.cupertino, replace: true);
          }
        },
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            OverviewPage(),
            Container(),
            Container(
              child: RaisedButton(
                color: AppTheme.green,
                onPressed: () {
                  authenticationBloc.dispatch(LoggedOut());
                },
                child: Text("Logout"),
              ),
            ),
            Container(
              child: Text("Tab 4"),
            ),
            Container(
              child: Text("Tab 5"),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _fab,
    );
  }

  Widget tabBarItem(
      String text, IconData iconData, bool isSelected, int index) {
    return Expanded(
      flex: isSelected ? 5 : 2,
      child: InkWell(
        onTap: () {
          selectTab(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                isSelected
                    ? getAppBarIcon(8, iconData, AppTheme.nearlyWhite)
                    : getAppBarIcon(0, iconData, AppTheme.whiteGrey),
                getAppBarText(isSelected, text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedSwitcher getAppBarText(bool isSelected, String text) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 0),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          SizeTransition(
        child: child,
        sizeFactor: animation,
        axis: Axis.horizontal,
        axisAlignment: -1.0,
      ),
      child: isSelected
          ? Container(
              key: ValueKey(1),
              child: Text(
                text,
                style: TextStyle(
                    color: AppTheme.nearlyWhite, fontWeight: FontWeight.bold),
              ),
            )
          : Container(
              key: ValueKey(2),
              child: Text(""),
            ),
    );
  }

  Widget getAppBarIcon(double padding, IconData iconData, Color color) {
    return Padding(
      padding: EdgeInsets.only(right: padding),
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }

  // Widget get _bottomNavigation {
  //   final Animation<Offset> slideIn =
  //       Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
  //           CurvedAnimation(
  //               parent: ModalRoute.of(context).animation, curve: Curves.ease));
  //   final Animation<Offset> slideOut =
  //       Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1)).animate(
  //           CurvedAnimation(
  //               parent: ModalRoute.of(context).secondaryAnimation,
  //               curve: Curves.fastOutSlowIn));

  //   return SlideTransition(
  //     position: slideIn,
  //     child: SlideTransition(
  //       position: slideOut,
  //       child: BottomAppBar(
  //         color: AppTheme.primary,
  //         shape:
  //             AutomaticNotchedShape(RoundedRectangleBorder(), CircleBorder()),
  //         notchMargin: 8,
  //         child: SizedBox(
  //           height: 48,
  //           child: Row(
  //             children: <Widget>[
  //               IconButton(
  //                 iconSize: 48,
  //                 icon: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     const Icon(
  //                       Icons.arrow_drop_up,
  //                       color: Colors.white,
  //                       size: 20,
  //                     ),
  //                     const SizedBox(width: 4),
  //                     Image.asset(
  //                       'assets/images/logo.png',
  //                       width: 21,
  //                       height: 21,
  //                     ),
  //                   ],
  //                 ),
  //                 onPressed: () => print('Tap!'),
  //               ),
  //               Spacer(),
  //               _actionItems,
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget get _actionItems {
  //   return Consumer<EmailModel>(
  //     builder: (BuildContext context, EmailModel model, Widget child) {
  //       final bool showSecond = model.currentlySelectedEmailId >= 0;

  //       return AnimatedCrossFade(
  //         firstCurve: Curves.fastOutSlowIn,
  //         secondCurve: Curves.fastOutSlowIn,
  //         sizeCurve: Curves.fastOutSlowIn,
  //         firstChild: IconButton(
  //           icon: const Icon(Icons.search, color: Colors.white),
  //           onPressed: () => print('Tap'),
  //         ),
  //         secondChild: showSecond
  //             ? Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   IconButton(
  //                     icon: Image.asset('assets/images/ic_important.png',
  //                         width: 28),
  //                     onPressed: () => print('Tap!'),
  //                   ),
  //                   IconButton(
  //                     icon: Image.asset('assets/images/ic_more.png', width: 28),
  //                     onPressed: () => print('Tap!'),
  //                   ),
  //                 ],
  //               )
  //             : const SizedBox(),
  //         crossFadeState:
  //             showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
  //         duration: Duration(milliseconds: 450),
  //       );
  //     },
  //   );
  // }

  Widget get _fab {
    return FloatingActionButton(
      key: _fabKey,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Icon(
          Icons.add,
          color: AppTheme.nearlyWhite,
        ),
      ),
      backgroundColor: AppTheme.warn,
      onPressed: () => Navigator.of(context).push<void>(
        AddRecordPage.route(context, _fabKey),
      ),
    );
  }
}
