import 'dart:async';
import 'package:eyubank/Screens/Balance_Check/balance_detail.dart';
import 'package:flutter/material.dart';
import 'package:eyubank/models/bank_info.dart';
import 'package:eyubank/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class BankList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return BankListState();
  }
}

class BankListState extends State<BankList> {

  BankHelper helper = BankHelper();
  @override
  void initState(){
    helper.initializeDatabase().then((value){
      print("--------- database initialized");
    });
    super.initState();
  }
  List<BankInfo> bankList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (bankList == null) {
      bankList = List<BankInfo>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Customer"),
        centerTitle: true,
      ),
      body: getBankListView(),
    );
  }

  ListView getBankListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.person),
              ),
              title : Text(this.bankList[position].fullName.toString(), style: titleStyle,),
              subtitle: Text("Balance " + this.bankList[position].balance.toString()),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
              onTap:(){Navigator.push(context, MaterialPageRoute(
                builder: (context){
                 return BalanceDetail(this.bankList[position]);
                }
              ));},
            ),
          );
        });
  }
  void updateListView(){
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database){

      Future<List<BankInfo>> bankListFuture = helper.getBank();
      bankListFuture.then((bankList){
        setState(() {
          this.bankList = bankList;
          this.count = bankList.length;
        });
      });
    });
  }
}