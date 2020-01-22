

import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 15),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUp()));
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator());
//se nao estiver carregando reconstroi a tela de login
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@")) {
                        return "E-mail invalido!!";
                      }
                    },
                    controller: _emailController,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6) {
                        return "Senha invalida";
                      }
                    },
                    controller: _passController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content:
                                Text("Insira seu e-mail para recuperar senha"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          model.recoverPass(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Confira seu e-mail"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Text("Esquici minha senha",
                          textAlign: TextAlign.right),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                        model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: onSuccess,
                          onFailure: onFailure,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  void onSuccess() {
    Navigator.of(context).pop();
  }

  void onFailure() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Nao foi possivel logar"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
