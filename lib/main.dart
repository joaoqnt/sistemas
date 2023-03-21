//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:microsistema/views/avaliacao_page_view.dart';
//import 'package:microsistema/views/produto_page.dart';


// Future<void> main () async{
//   await initialize();
//   runApp(MyApp());
// }
void main(){
  runApp(MyApp());
}

// Future<void> initialize() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int telaSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Armadilhas",
        home: AvaliacaoPageView()
    );
  }
}
