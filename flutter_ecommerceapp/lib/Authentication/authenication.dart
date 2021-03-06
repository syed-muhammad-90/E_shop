import 'package:flutter/material.dart';
import 'package:flutter_ecommerceapp/Authentication/Sign_inscreen.dart';
import 'package:flutter_ecommerceapp/Authentication/Sign_upscreen.dart';
import 'package:flutter_ecommerceapp/constrains/consttrains.dart';




class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> with SingleTickerProviderStateMixin{
  int _currentIndex = 0;

  List<Widget> _tabList = [

    Container(child: Sign_up(),
    ),

    Container(
      child: Sign_in(),
    )

  ];
TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync:this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.white38,




          backgroundColor: PrimaryColor,
          title: Text('Ecommerce'),
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 2.0,
            indicatorColor: Colors.white,
            tabs: <Widget>[

              Tab(
                text: 'Sign Up',

              ),
              Tab(
                text: 'Sign In',
              ),

            ],
          ),
        ),
        body:TabBarView(
        controller: _tabController,
        children: _tabList,
      ),
      ),
    );
  }
}
