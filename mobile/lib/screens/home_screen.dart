// home_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../domain/email.dart';
import '../service/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService(Client());
  List<Email> emails = [];

  @override
  void initState() {
    super.initState();
    _loadEmails();
  }

  void _loadEmails() async {
    try {
      final fetchedEmails = await apiService.fetchEmails();
      setState(() {
        emails = fetchedEmails;
      });
    } catch (e) {
      print("Erro ao carregar e-mails: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de E-mails"),
      ),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          final email = emails[index];
          return ListTile(
            title: Text(email.titulo),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Origem: ${email.origem}"),
                Text("Data: ${email.data}"),
                Text(
                  "Status: ${email.status}", // Exibe o status de phishing
                  style: TextStyle(
                    color: email.status == "phishing"
                        ? Colors.red
                        : email.status == "possível phishing"
                            ? Colors.orange
                            : Colors.green,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
