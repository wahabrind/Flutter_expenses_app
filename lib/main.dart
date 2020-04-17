import 'dart:io';

import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './models/transanction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 17,
                fontWeight: FontWeight.bold),
            button: TextStyle(color: Colors.white)),
        dividerColor: Colors.black12,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      title: 'Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String nameInput;
  // String priceInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transactions> _transactions = [
    Transactions(
      id: 't1',
      name: 'new watch',
      price: 29.99,
      date: DateTime.now(),
    ),
    Transactions(
      id: 't2',
      name: 'new mobile',
      price: 19.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transactions(
      id: 't1',
      name: 'new watch',
      price: 29.99,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    
  ];

  List<Transactions> get send7Transactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNew(String txname, double txprice, DateTime txdate) {
    final newTx = Transactions(
      name: txname,
      price: txprice,
      date: txdate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transactions.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewFunction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addNew),
          );
        });
  }

  bool showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);

  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();  
  }

  List<Widget> _showLandscapeContent(MediaQueryData mediaQuery, AppBar appBar) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Show Chart",
              style: Theme.of(context).textTheme.title,
            ),
            Switch(
                value: showChart,
                onChanged: (val) {
                  setState(() {
                    showChart = val;
                  });
                })
          ],
        ),
      ),
      showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: Chart(send7Transactions),
            )
          : Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: TransactionList(_transactions, deleteTransaction),
            )
    ];
  }

  List<Widget> _showPortraitContent(MediaQueryData mediaQuery, AppBar appBar) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(send7Transactions),
      ),
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_transactions, deleteTransaction),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final orientationCheck =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(
        'My Expenses',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewFunction(context),
          alignment: Alignment.centerLeft,
          iconSize: 20,
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (orientationCheck) ..._showLandscapeContent(mediaQuery, appBar),
            if (!orientationCheck) ..._showPortraitContent(mediaQuery, appBar),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => _startAddNewFunction(context),
              child: Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
