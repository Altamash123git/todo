
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider.dart';

import 'db_helper.dart';

class detail_page extends StatefulWidget {
  int id;
  String title;
  String desc;
  detail_page({required this.id, required this.title, required this.desc});

  @override
  State<detail_page> createState() => _detail_pageState();

}

class _detail_pageState extends State<detail_page> {
  int? ongoingcount;

  DBhelper dbhelper =DBhelper.getinstance();

  TextEditingController updatetitlecontroller=TextEditingController();
  TextEditingController updatedesccontroller=TextEditingController();





  @override
  Widget build(BuildContext context) {
 ongoingcount=  context.watch<taskprovider>().getalltask().length;
    return Scaffold(
        backgroundColor: Color(0xff282828),
        appBar: AppBar(
          backgroundColor:  Color(0xff282828),
          title: Text("DETAIL",style: TextStyle(color: Colors.white),),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: IconButton(
                  onPressed: () async{


                    showModalBottomSheet(
                        isDismissible: false,
                        enableDrag: false,
                        context: context,
                        builder: (_) {
                          return showmodal();
                        });
                    updatetitlecontroller.text=widget.title;
                    updatedesccontroller.text=widget.desc;
                    setState(() {

                    });
                  },
                  icon: Icon(Icons.edit_calendar,size: 30,color: Colors.white,),
                ),

            ),
            IconButton(onPressed: ()async{
              context.read<taskprovider>().updatetask(updatetitle: widget.title, updatedesc: widget.desc, id: widget.id, status: 1);
              if(ongoingcount!>0){
              ongoingcount= ongoingcount!-1;}
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:(
              Text("marked as completed",style: TextStyle(color: Colors.greenAccent),)
              )));

            }, icon: Icon(Icons.check_circle_rounded),color: Colors.white,),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(

                width: double.infinity,
                child:
                Text(widget.title,textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.white,),),

              ),


            ),
            SizedBox(height: 15,),
            Flexible(child: Container(
              child: Text(widget.desc,textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.white,),),
            ))
          ],

        )

    );
  }
  Widget showmodal() {


    return Container(
      //alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: updatetitlecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              //hintText: "update title "
            ),

          ),
          SizedBox(height: 15,),
          TextField(
            controller: updatedesccontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              //hintText: "upadate desc"
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Expanded(child: TextButton(
                onPressed: () async{
                  context.read<taskprovider>().updatetask(updatetitle: updatetitlecontroller.text, updatedesc: updatedesccontroller.text, id: widget.id,status: 0);
                  Navigator.pop(context);


                  //*if(updatetitlecontroller.text.isNotEmpty && updatedesccontroller.text.isNotEmpty){






                },
                child: Text("update"),)),
              SizedBox(width: 5,),
              Expanded(child: TextButton(
                child: Text("Cancel"),
                onPressed: () async{
                  Navigator.pop(context);


                },
              ))
            ],
          ),
          ElevatedButton(onPressed: ()async{
            context.read<taskprovider>().updatetask(updatetitle: updatetitlecontroller.text, updatedesc: updatedesccontroller.text, id: widget.id,status: 1);
            Navigator.pop(context);

          }, child: Text("Mark as complete")),

        ],
      ),
    );


  }
/*Future<List<Map<String, dynamic>>>  getmynotes() async{
   allnotes = Provider.of<state_managmnent>(context).notes;
setState(() {

});
   return allnotes;


  }
  *//*List<Map<String, dynamic>> getmynotes() {
    Consumer<state_managmnent>(builder: (ctx,provider,_){
      allnotes= ctx.watch<state_managmnent>().getmytask() as List<Map<String, dynamic>>;

    },);
    }*//*
  *//*void update() async{
    bool check= await dbhelper.update(updatetitle:allnotes[widget.id][DBhelper.Column_todo_title], updatedesc: allnotes[widget.id][DBhelper.Column_todo_title], id: 0);


  }*//*
 void updatetodo() async {
   if(updatetitlecontroller.text.isNotEmpty && updatedesccontroller.text.isNotEmpty) {
     bool check = await dbhelper.update(
         updatetitle: updatetitlecontroller.text,
         updatedesc: updatedesccontroller.text,
         id: widget.id);
     if (check) {
       getmynotes();

       Navigator.pop(context);
     }
   }

}
*/

}
