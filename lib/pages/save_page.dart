import 'package:flutter/material.dart';

class SavePage extends StatelessWidget {

  static const String ROUTE = "/save";
final _formKey = GlobalKey<FormState>();
final titleController = TextEditingController();
final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Note note = ModalRoute.of(context).settings.arguments;
    _init(note);
    return Scaffold(appBar: AppBar(title: Text("Guardar"),),
    body: Container(
      child: _buildForm(note),),
      );
  }
  _init(Note note){
    titleController.text = note.title;
    contentController.text = note.content;
  }
  Widget _buildForm(Note note){
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            controller: titleController,
            validator: (value){
              if (value!.isEmpty) {
                return "Tiene que colocar datos";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Titulo",
              border: OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: contentController,
            maxLines: 8,
            maxLength: 1000,
            validator: (value){
              if (value!.isEmpty) {
                return "Tiene que colocar datos";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Contenido",
              border: OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
            ),
          ),
          ElevatedButton(child: Text("Guardar"), 
          onPressed: (){
            if(_formKey.currentState!.validate()){
              if(note.id > 0){
                note.title = titleController.text;
                note.content = contentController.text;
                Operation.update(note);
              }
              else{
              Operation.insert(Note(title: titleController.text, content: contentController.text));
              }


            }
          })
        ],),
      ),
    );
  }
}

