import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply/editor_page.dart';
import 'package:reply/model/email_model.dart';
import 'package:reply/pages/overview/overview_page.dart';
import 'package:reply/styling.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  final GlobalKey _fabKey = GlobalKey();
  TabController tabController;
  int _selectedIndex;

  List<Widget> tabItems;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
    _selectedIndex = 0;
  }

  selectTab(index) {
    setState(() {
      _selectedIndex = index;
      // tabController.animateTo(index);
      // tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Financial"),
        // bottom: TabBar(
        //   isScrollable: true,
        //   controller: tabController,
        //   onTap: selectTab,
        //   tabs: <Widget>[
        //     tabBarItem("OVERVIEW", Icons.pie_chart, _selectedIndex == 0),
        //     // Tab(icon: Icon(Icons.pie_chart),),
        //     tabBarItem("ACCOUNTS", Icons.attach_money, _selectedIndex == 1),
        //     tabBarItem("BILLS", Icons.attach_money, _selectedIndex == 2),
        //     tabBarItem("REPORTS", Icons.insert_chart, _selectedIndex == 3),
        //     tabBarItem("SETTINGS", Icons.settings, _selectedIndex == 4),
        //   ],
        // ),,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  tabBarItem(
                      "OVERVIEW", Icons.pie_chart, _selectedIndex == 0, 0),
                  tabBarItem(
                      "ACCOUNTS", Icons.attach_money, _selectedIndex == 1, 1),
                  tabBarItem(
                      "BILLS", Icons.attach_money, _selectedIndex == 2, 2),
                  tabBarItem(
                      "REPORTS", Icons.insert_chart, _selectedIndex == 3, 3),
                  tabBarItem(
                      "SETTINGS", Icons.settings, _selectedIndex == 4, 4),

                  // Expanded(
                  //     child: TabBar(
                  //       isScrollable: true,
                  //       controller: tabController,
                  //       onTap: selectTab,
                  //       labelPadding: EdgeInsets.symmetric(horizontal: 12),
                  //       tabs: <Widget>[
                  //         tabBarItem(
                  //             "OVERVIEW", Icons.pie_chart, _selectedIndex == 0),
                  //         tabBarItem("ACCOUNTS", Icons.attach_money,
                  //             _selectedIndex == 1),
                  //         tabBarItem("TRANSACTIONS", Icons.attach_money,
                  //             _selectedIndex == 2),
                  //         tabBarItem(
                  //             "SETTINGS", Icons.settings, _selectedIndex == 3),
                  //       ],
                  //     ),
                  //     ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: AppTheme.grey,
      ),
      // body: TabBarView(
      //   physics: NeverScrollableScrollPhysics(),
      //   controller: tabController,
      //   children: <Widget>[
      //     OverviewPage(),
      //     Container(),
      //     Container(),
      //     Container(),
      //   ],
      // ),
      body: Container(
        child: OverviewPage(),
      ),
      bottomNavigationBar: _bottomNavigation,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  Widget get _bottomNavigation {
    final Animation<Offset> slideIn =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: ModalRoute.of(context).animation, curve: Curves.ease));
    final Animation<Offset> slideOut =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1)).animate(
            CurvedAnimation(
                parent: ModalRoute.of(context).secondaryAnimation,
                curve: Curves.fastOutSlowIn));

    return SlideTransition(
      position: slideIn,
      child: SlideTransition(
        position: slideOut,
        child: BottomAppBar(
          color: AppTheme.grey,
          shape:
              AutomaticNotchedShape(RoundedRectangleBorder(), CircleBorder()),
          notchMargin: 8,
          child: SizedBox(
            height: 48,
            child: Row(
              children: <Widget>[
                IconButton(
                  iconSize: 48,
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 21,
                        height: 21,
                      ),
                    ],
                  ),
                  onPressed: () => print('Tap!'),
                ),
                Spacer(),
                _actionItems,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _actionItems {
    return Consumer<EmailModel>(
      builder: (BuildContext context, EmailModel model, Widget child) {
        final bool showSecond = model.currentlySelectedEmailId >= 0;

        return AnimatedCrossFade(
          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.fastOutSlowIn,
          sizeCurve: Curves.fastOutSlowIn,
          firstChild: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => print('Tap!'),
          ),
          secondChild: showSecond
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('assets/images/ic_important.png',
                          width: 28),
                      onPressed: () => print('Tap!'),
                    ),
                    IconButton(
                      icon: Image.asset('assets/images/ic_more.png', width: 28),
                      onPressed: () => print('Tap!'),
                    ),
                  ],
                )
              : const SizedBox(),
          crossFadeState:
              showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 450),
        );
      },
    );
  }

  Widget get _fab {
    return AnimatedBuilder(
      animation: ModalRoute.of(context).animation,
      child: Consumer<EmailModel>(
        builder: (BuildContext context, EmailModel model, Widget child) {
          final bool showEditAsAction = model.currentlySelectedEmailId == -1;

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
            backgroundColor: AppTheme.green,
            onPressed: () => Navigator.of(context).push<void>(
              EditorPage.route(context, _fabKey),
            ),
          );
        },
      ),
      builder: (BuildContext context, Widget fab) {
        final Animation<double> animation = ModalRoute.of(context).animation;
        return SizedBox(
          width: 54 * animation.value,
          height: 54 * animation.value,
          child: fab,
        );
      },
    );
  }

  Future<bool> _willPopCallback() async {
    if (_navigatorKey.currentState.canPop()) {
      _navigatorKey.currentState.pop();
      Provider.of<EmailModel>(context).currentlySelectedEmailId = -1;
      return false;
    }
    return true;
  }
}
