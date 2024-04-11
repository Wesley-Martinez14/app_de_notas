import 'package:app_de_notas/pages/save_page.dart';
import 'package:flutter/material.dart';
import 'package:app_de_notas/db/operation.dart';
import 'package:app_de_notas/models/note.dart';

class ListPage extends StatelessWidget {

  // ignore: constant_identifier_names
  static const String ROUTE = "/";

  const ListPage({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: (){
        Navigator.pushNamed(context, SavePage.ROUTE, arguments: Note.empty());
      },),
      appBar: AppBar( 
        title: const Text("Listado"),
        ),
      body: _Mylist(),
      );
     } 
    }

    class _Mylist extends StatefulWidget {
      @override
      _MylistState createState() => _MylistState();
    }

    class _MylistState extends State<_Mylist> {

      List<Note> notes = [];

      @override
      void initState() {
        _loadData();
          
        super.initState(); 
      }

     @override
      Widget build(BuildContext context) {
        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (_, i) => _createItem(i),
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
        key: Key(i.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.red,   
          padding: const EdgeInsets.only(left: 5),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white,)),
        ),
        onDismissed: (direction){
          // ignore: avoid_print
          print(direction);
          Operation.delete(notes[i]);
        },
        child: ListTile(
          title: Text(notes[i].title),
          trailing: MaterialButton(
            onPressed: (){
              Navigator.pushNamed(context, SavePage.ROUTE, arguments: notes[i]);
            },
            child: const Icon(Icons.edit)),
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
