import 'package:app_de_notas/db/operation.dart';
import 'package:app_de_notas/models/note.dart';
import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {

  // ignore: constant_identifier_names
  static const String ROUTE = "/save";

  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
final _formKey = GlobalKey<FormState>();

final titleController = TextEditingController();

final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Note note = ModalRoute.of(context)?.settings.arguments as Note;
    _init(note);
    return PopScope(
      canPop: false, // Prevent default back button behavior
      onPopInvoked: (didPop) async {
        if (didPop) return; // Don't pop if user didn't confirm

        final navigator = Navigator.of(context);
        final shouldPop = await _showBackDialog();
        if (shouldPop ?? false) {
          navigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Guardar"),
        ),
        body: Container(
          child: _buildForm(note),
        ),
      ),
    );
  }

  _init(Note note){
    titleController.text = note.title;
    contentController.text = note.content;
  }

  Widget _buildForm(Note note){
    return Container(
      padding: const EdgeInsets.all(15),
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
            decoration: const InputDecoration(
              labelText: "Titulo",
              border: OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
            ),
          ),
          const SizedBox(height: 15,),
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
            decoration: const InputDecoration(
              labelText: "Contenido",
              border: OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
            ),
          ),
          ElevatedButton(
            child: const Text("Guardar"), 
            onPressed: (){
              if(_formKey.currentState!.validate()){
                if(note.id >= 0 ){
                  note.title = titleController.text;
                  note.content = contentController.text;
                  Operation.update(note);
                }
                else{
                  Operation.insert(Note(title: titleController.text, content: contentController.text, id: contentController.hashCode));
                }
            }
          })
        ],),
      ),
    );
  }
  
  Future<bool?> _showBackDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Regresar a la pagina anterior?"),
        content: const Text("Hay informacion sin guardar."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Si"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
        ],
      ),
    );
  }
}

