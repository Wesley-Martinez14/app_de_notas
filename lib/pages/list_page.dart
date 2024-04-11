import 'package:app_de_notas/pages/save_page.dart';
import 'package:flutter/material.dart';
import 'package:app_de_notas/lib/db/operation.dart';
import 'package:app_de_notas/models/note.dart';

class ListPage extends StatelessWidget {

  static const String ROUTE = "/";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: (){
        Navigator.pushNamed(context, SavePage.ROUTE, arguments: Note.empty());
      },),
      appBar: AppBar( 
        title: Text("Listado"),
        ),
      body: Container(
        //child: ListView(
          child: _Mylist(),
       ),
      );
     } 
    }

    class _Mylist extends StatefulWidget {
      @override
      _MylistState createState() => __MylistState();
    }

    class __MylistState extends State<_Mylist> {

      List<Note> notes = [];

      @override
      void initState() {
        _loadData();
          
        super.initState(); 
      }

      @override
      Widget build(BuildContext context) {
        return ListView.build(
          itemCount: notes.length,
          itemBuilder: (_,i) => _createItem(i),
        );
    }

       _loadData() async{
        List<Note> auxNote = await Operation.notes();
        
        setState(() {
        notes = auxNote;
      }); 
    }

      _createItem(int i){
        return Dismissible(
        key: key(i.toString()),
        direction: DismissDirection.starToEnd,
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.only(left: 5),
          child: Align(
            alimegment: Alimegment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white,)),
        ),
        onDismissed: (direction){
          print(direction);
          Operation.delete(notes[i]);
        }
        child: ListTile(
          title: Text(note[i].title),
          trailing: MaterialButton(
            onpressed: (){
              Navigator.pushNamed(context, SavePage.ROUTE, arguments: notes[i]);
            }
            child: Icon(Icons.edit)),
        ),
       );
      }
   }      
         






         /* children: <Widget>[*
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
        ListTile(
          title: Text("Nota 1"),
          ),
      ]*,),)
    )*;*
  *
}*/
