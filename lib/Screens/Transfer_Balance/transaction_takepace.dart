import 'package:eyubank/Screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:eyubank/models/bank_info.dart';
import 'package:eyubank/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class FinalTrans extends StatefulWidget{

  final BankInfo personsel1;
  final BankInfo personsel2;

  FinalTrans(this.personsel1, this.personsel2);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FinalTransState(this.personsel1, this.personsel2);
  }
}

class FinalTransState extends State<FinalTrans>{

  BankInfo personsel1;
  BankInfo personsel2;

  FinalTransState(this.personsel1, this.personsel2);

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

  TextEditingController Balance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (bankList == null) {
      bankList = List<BankInfo>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Transcation Takeplace"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/e1.jpg"),
          SizedBox(height: 16,),
          Text("You want to transfer From", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),),
          SizedBox(height: 16,),
          Text(personsel1.fullName, style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 16,),
          Text("To", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),textAlign: TextAlign.center,),
          SizedBox(height: 16,),
          Text(personsel2.fullName, style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 16,),
          TextField(
            controller: Balance,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: BorderSide(width: 1.0)
              ),
              hintText: "2000",
            ),
          ),
          SizedBox(height: 16,),
          Text(Balance.text.toString() +" ETB Birr",
            style: TextStyle(fontStyle: FontStyle.normal,
                fontSize: 20,
                fontWeight: FontWeight.normal),),
          SizedBox(height: 16,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text("Agree"), onPressed: (){setState(() {
            debugPrint("Save button clicked");
            _save();
          });})
        ],
      ),
    ),)
    );
  }

  void _save() async{
    final int balance = int.parse(Balance.text);
    final int ba1 = personsel1.balance - balance;
    final int ba2 = personsel2.balance + balance;

    //moveToLastScreen();
    int result1;
    int result2;
    moveToLastScreen();

    debugPrint("all things are correct");
    var person1 = BankInfo(
        id:personsel1.id,
        fullName: personsel1.fullName,
        mobile: personsel1.mobile,
        email: personsel1.email,
        accountNum: personsel1.accountNum,
        ifsc: personsel1.ifsc,
        balance: ba1
    );
    var person2 = BankInfo(
        id: personsel2.id,
        fullName: personsel2.fullName,
        mobile: personsel2.mobile,
        email: personsel2.email,
        accountNum: personsel2.accountNum,
        ifsc: personsel2.ifsc,
        balance: ba2
    );
    result1 = await helper.updatebank(person1);
    result2 = await helper.updatebank(person2);
    debugPrint("all things are correct 11111");
    if ((result1 != 0) && (result2 != 0)){
      debugPrint("all things are correct show");
      _showAlertDialog("Status", " Transaction Successfully");
    } else {
      _showAlertDialog("Status", "Problem Transaction Process");
    }
  }
  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog);
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

  void moveToLastScreen(){
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}