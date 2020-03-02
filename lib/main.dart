import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark,
       // hintColor: Colors.white
      ),
    )
  );
}
class MyApp extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp>{
  var _formKey=GlobalKey<FormState>();
  String displayInterest="";
  var _currencies=["Rupee","Dollar","Pound"];
  var _currenciesSelected;
  @override
  void initState() {
    super.initState();
    _currenciesSelected=_currencies[0];

  }
  TextEditingController principalController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();

  @override
  Widget build(BuildContext context) {
     TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Simple Interest Calculator"),),
      body: Form(
        key: _formKey,
        child:Padding(padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            getImage(),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0,),
             child: TextFormField(
               validator:(String value){
                 if(value.isEmpty){
                   return 'Please enter principal amount';
                 }
               },
                keyboardType: TextInputType.number,
                controller: principalController,
                style: textStyle,
                decoration:InputDecoration(
                    labelText: "Principal",
                    labelStyle: textStyle,
                    hintText: "Enter Principal",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ) ,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 10.0,),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                validator:(String value){
                  if(value.isEmpty){
                    return 'Please enter Rate of Interest';
                  }
                },
                controller: roiController,
                decoration:InputDecoration(
                    labelText: "Rate of Interest",
                    labelStyle: textStyle,
                    hintText: "Enter Rate of Interest",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ) ,
              ),
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: termController,
                    style: textStyle,
                    validator:(String value){
                      if(value.isEmpty){
                        return "Please enter Term";
                      }
                    },
                  decoration:InputDecoration(
                      labelText: "Term",
                      hintText: "Enter Term",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
                ),
                  Container(
                    width: 20.0,
                  ),
                Expanded(
                    child:DropdownButton<String>(
                      items: _currencies.map((String dropDownStringItem){
                        return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,style: textStyle,)
                        );
                      }).toList(),
                      onChanged:(String newValueSelected){
                        setState(() {
                          _currenciesSelected=newValueSelected;
                        });
                      },
                      value: _currenciesSelected,
                    ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child:Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                      child: Text("Calculate",textScaleFactor: 1.2,),
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: (){
                        setState(() {
                          if(_formKey.currentState.validate())
                          _calculateTotalReturn();
                        });

                    },
                    )
                ),
                Container(width: 5.0,),
                Expanded(
                    child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text("Reset",textScaleFactor: 1.2,),
                        onPressed: (){
                          setState(() {
                            _reset();
                          });
                        })
                ),
              ],
            ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0,),
              child:Text(displayInterest,style: textStyle,),
            ),
          ],
        ),
      ),
      ),
    );
  }

  void _calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double total = principal + (principal *roi * term) / 100;
    displayInterest="After $term years, your investment will be worth $total $_currenciesSelected";
  }

  void _reset() {
    principalController.text="";
    roiController.text="";
    termController.text="";
    displayInterest="";
    _currenciesSelected=_currencies[0];
  }
}



Widget getImage(){
  AssetImage assetimage = AssetImage('images/money.png');
  Image image=Image(image: assetimage,width: 125.0,height: 125.0,);
  return Container(
    child: image,
    margin: EdgeInsets.all(40.0),
  );
}