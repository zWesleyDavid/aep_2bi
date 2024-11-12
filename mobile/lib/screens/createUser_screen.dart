import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../domain/usuario.dart';
import '../service/api_service.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final ApiService _apiService = ApiService(Client());

  void _cadastrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      final usuario = Usuario(
        nome: _nomeController.text,
        email: _emailController.text,
      );

      await _apiService.createUsuario(usuario.nome, usuario.email);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Acessar')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Informe o email' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _cadastrarUsuario,
                child: Text('Acessar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
