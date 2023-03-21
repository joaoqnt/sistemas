import 'package:flutter/material.dart';

void main(){
  runApp(LoginScreen());
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _tecEmail = TextEditingController();
  TextEditingController _tecSenha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            Container(
              height: 225,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: const [
                  Expanded(
                    child: Center(
                      child: Text("MicroSistema",
                        style:TextStyle(
                            fontSize: 32,
                            color: Colors.white
                        ) ,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:40,right: 18,left: 18),
              child: TextFormField(
                controller: _tecEmail,
                decoration: InputDecoration(labelText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:40,right: 18,left: 18),
              child: TextFormField(
                controller: _tecSenha,
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top:40,right: 18,left: 18),
                      child: ElevatedButton(
                        onPressed: (){
                        },
                        child: Text("Entrar"),
                      ),
                    )
                )
              ],
            )
          ],
        )
    );
  }
}