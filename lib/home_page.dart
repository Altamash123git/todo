import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:todo/add_task.dart';
import 'package:todo/db_helper.dart';

import 'package:todo/detail_page.dart';
import 'package:todo/profile_page.dart';
import 'package:todo/provider.dart';




class Homepage extends StatefulWidget {
  //const Homepage({super.key});
  var username;
  int status;



  Homepage({ String? this.username, required this.status,});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {



//int count=0;
  int? selecteditem;
  bool istaskcompleted=false;
  String? taskongoing;
  String? taskcompleted;
  int? completedcount;
  int? continuouscount;





  List<Map<String, dynamic>> allnotes = [];

  @override
  Widget build(BuildContext context) {
   int count=context.watch<taskprovider>().getalltask().length;
    void statusget(){
      if(widget.status==0){
        continuouscount= count;

      }
      else if (widget.status==1){
        completedcount=count-1;
      }

    };
    List<Map<String, dynamic>> topview = [
      {
        "name": "Ongoing",
        "completed":"$continuouscount",

        "icon": Icon(Icons.restart_alt),
        "color": Colors.blue,
      },
      {
        "name": "In process",
        "completed":"0",
        "no_of_task": 13,
        "icon": Icon(Icons.timer),
        "color": Colors.grey,
      },
      {
        "name": "Completed",
        "completed":"$completedcount",
        "no_of_task": 40,
        "icon": Icon(Icons.request_page_rounded),
        "color": Colors.greenAccent,
      },
      {
        "name": "Cancelled",
        "completed":"0",
        "no_of_task": 8,
        "icon": Icon(Icons.contact_page),
        "color": Colors.red,
      },
    ];


    context.watch<taskprovider>().gettask();

    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor:  Color(0xfff6f6f6),
        leading: InkWell(
          onTap:(){
            Navigator.push(context, PageTransition(
                duration: Duration(seconds: 1),
                child: profilePage(), type: PageTransitionType.leftToRightWithFade));
          },
          child: CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage("assets/img/IMG_20240316_203634_698.jpg"),
            //backgroundColor: Colors.blue,
          ),
        ),
        title: widget.username!=null? Text("Hi, ${widget.username}"): Text("Hi user"),
      ),
      body:Consumer<taskprovider>(builder: (ctx,provider,_){
        allnotes= provider.getalltask();
        return  context.watch<taskprovider>().getalltask().isNotEmpty?  SingleChildScrollView(
          child:
          Column(
            children: [
              Container(
                //padding: EdgeInsets.all(1),
                margin: EdgeInsets.all(10),
                height: 130,
                child:
                GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 53,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                    ),
                    itemCount: topview.length,
                    itemBuilder: (ctx,i){
                      return Container(
                        height: 10,
                        child: ListTile(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          leading: (topview[i]["icon"]),

                         subtitle:  Text(topview[i]["completed"].toString()) ,


                          title: Text(topview[i]["name"].toString()),
                          tileColor: topview[i]["color"],

                        ),
                      );
                    }),
              ),
              SizedBox(height: 15,),
              Container(
                height: 900,
                child:  ListView.builder(


                    physics: NeverScrollableScrollPhysics(),
                    //shrinkWrap: true,
                    itemCount: allnotes.length,
                    itemBuilder: (c, index) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(

                          onTap: (){
                            selecteditem=allnotes[index][DBhelper.Column_todo_id];
                            Navigator.push(context, MaterialPageRoute(builder: (c)=>detail_page(id: selecteditem!,desc: allnotes[index][DBhelper.Column_todo_desc],title: allnotes[index][DBhelper.Column_todo_title],)));

                          },

                          title: Text(allnotes[index][DBhelper.Column_todo_title].toString()),
                          subtitle:Text(allnotes[index][DBhelper.Column_todo_desc].toString()),
                          trailing: IconButton(onPressed: (){
                            context.read<taskprovider>().deletetask(id: allnotes[index][DBhelper.Column_todo_id]);
                          }, icon: Icon(Icons.delete,color: Colors.red,)),


                          tileColor: Colors.blue,
                          focusColor: Colors.green,
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(15),


                          ),
                          //style: ListTileStyle.drawer,


                        ),
                      );
                    }),

              ),
              /* Container(
                height: 300,
                child: ListView.builder(

                    itemCount: topview.length,
                    itemBuilder: (c,i){
                      final key= allnotes[i];
                      return Dismissible(
                        child: ListTile(
                          title: Text(allnotes[i][DBhelper.Column_todo_title]),
                        ),
                        onDismissed: (direction){
                          setState(() {
                            allnotes.removeAt(i);

                          });
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          child: Icon(Icons.delete),

                          color: Colors.red,
                        ),
                        key: Key(key.toString()) );



                    }),
              )*/
            ],
          ),
        )

            :
        Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("no task's yet"),
              SizedBox(
                height: 15,
              ),
              TextButton(onPressed: () async{
                Navigator.push(context, MaterialPageRoute(builder: (c)=>addtask()));
              }, child: Text("add task's"))
            ],
          ),
        );


      },),






      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: context.watch<taskprovider>().getalltask().isNotEmpty
          ? FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),

          ),
          foregroundColor: Colors.red,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c)=>addtask()));
          }) : null,

      bottomNavigationBar: BottomAppBar(
        elevation: 37,
        shadowColor: Colors.yellow,
        notchMargin: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.home,color: Colors.red,size: 35 ,),


            ),
            IconButton(
              color: Colors.red,
              focusColor: Colors.yellow,
              onPressed: (){}, icon: Icon(Icons.folder, size: 35 ,),
            ),
            IconButton(
              color: Colors.red,
              focusColor: Colors.yellow,
              onPressed: (){}, icon: Icon(Icons.request_page_sharp,size: 35 ,),
            ),
            IconButton(
              color: Colors.red,
              focusColor: Colors.yellow,
              onPressed: (){}, icon: Icon(Icons.person,size: 35 ,),
            ),
          ],
        ),      ),
    );



  }

/* void gettasks() async{
    //Consumer(builder: (ctx,provider,_) => allnotes=   ctx.watch<state_managmnent>().getmytask(),);


    //await didChangeDependencies();

  }*/

}


