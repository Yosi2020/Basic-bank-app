import 'package:flutter/material.dart';
import 'package:eyubank/constants.dart';
import 'package:eyubank/models/bank_info.dart';
import 'package:eyubank/utils/database_helper.dart';

class AddUser extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return AddUserState();
  }
}

class AddUserState extends State<AddUser>{
  BankHelper helper = BankHelper();
  @override
  void initState(){
    helper.initializeDatabase().then((value){
      print("--------- database initialized");
    });
    super.initState();
  }

  TextEditingController FullNameController = TextEditingController();
  TextEditingController MobileNumberController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController AccountNumController = TextEditingController();
  TextEditingController IFSCCodeController = TextEditingController();
  TextEditingController CurrentBalanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Users"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            buildTextField(title: "Full Name", controller: FullNameController,
            autoHint: "Eyu Tibebe", option: 0),
            SizedBox(height: 16,),
            buildTextField(title: "Mobile Number", controller: MobileNumberController,
                autoHint: "091313****", option: 1),
            SizedBox(height: 16,),
            buildTextField(title: "Email", controller: EmailController,
                autoHint: "***********@gmail.com", option: 2),
            SizedBox(height: 16,),
            buildTextField(title: "Account Number", controller: AccountNumController,
                autoHint: "1000******1827",option: 3),
            SizedBox(height: 16,),
            buildTextField(title: "IFSC Code", controller: IFSCCodeController,
                autoHint: "518", option: 4),
            SizedBox(height: 16,),
            buildTextField(title: "Current Balance", controller: CurrentBalanceController,
                autoHint: "1000000000",option: 5),
            SizedBox(height: 16,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            textStyle: TextStyle(fontSize: 20),
          ),
          child: Text("Save"), onPressed: (){setState(() {
            debugPrint("Save button clicked");
            _save();
          });}),
          ],
        ),
      ),
    );
  }
  Widget buildTextField({
    @required String title,
    @required TextEditingController controller,
    int maxLines = 1,
    @required int option,
    @required String autoHint,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold
          ),),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: autoHint,
            ),
          )
        ],
      );
  void _save() async{
    String FullName = FullNameController.text.toString();
    int Mobile = int.parse(MobileNumberController.text);
    String Email = EmailController.text.toString();
    int AccountNum = int.parse(AccountNumController.text);
    int Ifsc = int.parse(IFSCCodeController.text);
    int Balance = int.parse(CurrentBalanceController.text);

    moveToLastScreen();
    int result;
    debugPrint("all things are correct");
    var bankInfo = BankInfo(
        fullName: FullName,
        mobile: Mobile,
        email: Email,
        accountNum: AccountNum,
        ifsc: Ifsc,
        balance: Balance
    );
    result = await helper.insertBank(bankInfo);
    debugPrint("all things are correct 11111");
    if (result != 0){
      debugPrint("all things are correct show");
      _showAlertDialog("Status", "Bank Saved Successfully");
    } else {
      _showAlertDialog("Status", "Problem Saving Bank");
    }
  }
  void moveToLastScreen(){
    Navigator.pop(context, true);
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
}
