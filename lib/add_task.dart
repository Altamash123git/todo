
import 'package:todo/add_task.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//import 'package:todo_application/db_helper2.dart';
//import 'package:todo_application/homePage.dart';*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:todo/provider.dart';


//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/home_page.dart';
import 'package:todo/provider.dart';

import 'db_helper.dart';
import 'provider.dart';

class addtask extends StatefulWidget {
  const addtask({super.key});

  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  bool isSwitched= false;
  var  datetime = DateTime.now().millisecondsSinceEpoch;

  //DBhelper dbhelper= DBhelper.getinstance();
  //DBhelper dbhelper =DBhelper.getinstance();
  DateTime? selecteddate;

  TextEditingController titlecontroller= TextEditingController();
  TextEditingController descontroller= TextEditingController();
  TextEditingController assigneecotroller= TextEditingController();
  TextEditingController datecontroller= TextEditingController();


/*Future < List<Map<String,dynamic>>> didChangeDependencies() async{
    var  inherit=  await Provider.of<state_managmnent>(context,listen: false).getmytask();
    getmynotes();

    return inherit;
  }*/
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor:  Color(0xfff6f6f6),
        title: Text("Add task", style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(13),),
                    hintText: "enter title",


                  ),


                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  //enabled: false,

                  controller: datecontroller,

                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: (){
                        datepicker();
                      },
                      icon: Icon(Icons.arrow_drop_down),iconSize: 29,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    hintText: "date",


                  ),

                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: assigneecotroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    hintText: "assignee",


                  ),

                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(


                  minLines: 4,
                  maxLines: 50,
                  controller: descontroller,
                  decoration: InputDecoration(
                    //counterText: "",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(13),),
                    hintText: "enter desc",


                  ),

                ),
              ),
              SizedBox(
                height: 1,
              ),


              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.topLeft,
                  child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.all(10),

                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(onPressed: (){}, child: Text("Design ")),
                          ElevatedButton(onPressed: (){}, child: Text("Deevelopment")),
                          ElevatedButton(onPressed: (){}, child: Text("Coding ")),


                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(onPressed: (){}, child: Text("Meeting ")),
                          ElevatedButton(onPressed: (){}, child: Text("Office time ")),
                          ElevatedButton(onPressed: (){}, child: Text("Meeting "))
                        ],
                      )
                    ],
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Get update for this task"),
                    Switch(
                      //inactiveTrackColor: Colors.grey,
                      //activeTrackColor: Colors.blue,
                        inactiveThumbColor: Colors.greenAccent,
                        activeColor: Colors.red,

                        value: isSwitched, onChanged: (value){
                      //value=isSwitched;
                      setState(() {
                        isSwitched=value;
                      });
                    })

                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: () async{
                          if(titlecontroller.text.isNotEmpty && descontroller.text.isNotEmpty){


                           Provider.of<taskprovider>(context, listen: false).addtask(title:  titlecontroller.text, desc: descontroller.text, time: datetime.toString(), status: 0);
                            //
                            // context.read<taskprovider>().addtask(title: titlecontroller.text, desc: descontroller.text, time: datetime.toString(), status: "o");

                          }
                          //addnotes();
                          Navigator.pop(context, MaterialPageRoute(builder: (c)=>Homepage(username: "", status:0 ,)));
                        }, child: Text("add",style: TextStyle(color: Colors.white,fontSize: 20),)),
                  )),
                  SizedBox(width: 6,),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: (){
                        //showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2024));
                        Navigator.pop(context, MaterialPageRoute(builder: (c)=>Homepage(username: "",status: 0,)));

                      }, child: Text("cancel",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),),
                  )),

                ],
              ),




            ],
          ),
        ),
      ),

    );
  }
  /*Future < List<Map<String,dynamic>>> getmynotes()  async{
     allnotes= Provider.of<state_managmnent>(context, listen: false).notes;
    //
    // await didChangeDependencies() ;

    return allnotes;

  }
  void addnotes() async{
    if(titlecontroller.text.isNotEmpty && descontroller.text.isNotEmpty){
      bool check= await dbhelper.createtodo(title: titlecontroller.text, desc: descontroller.text, time: DateTime.now().millisecondsSinceEpoch.toString(), status: "false");
      if(check){

        getmynotes();

      }
      print("hi baby how are you");
      print(allnotes);
    }
  }
   void datepicker() async {
    DateTime? selectdate= await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2024));

    if ( selectdate !=null){
      setState(() {
        selecteddate= selectdate;
        datecontroller.text= selecteddate.toString();
      });
      print(selecteddate);

    }
   }*/
  void datepicker() async {
    DateTime? selectdate= await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2024));

    if ( selectdate !=null){
      setState(() {
        selecteddate= selectdate;
        datecontroller.text= selecteddate.toString();
      });
      print(selecteddate);

    }
  }
}

