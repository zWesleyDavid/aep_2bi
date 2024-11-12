import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/domain/phishing_detector.dart';
import '../domain/email.dart';
import '../domain/usuario.dart';

class ApiService {
  Client client;

  ApiService(this.client);

  final String baseUrl = 'http://localhost:3000';

  Future<Usuario?> fetchUsuario() async {
    final response = await http.get(Uri.parse('$baseUrl/user'));

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao carregar usuário');
    }
  }

  Future<List<Email>> fetchEmails() async {
    final response = await http.get(Uri.parse('$baseUrl/emails'));

    if (response.statusCode == 200) {
      final List<dynamic> emailData =
          json.decode(utf8.decode(response.bodyBytes));
      return emailData.map((emailJson) {
        final email = Email.fromJson(emailJson);
        email.status =
            PhishingDetector.classifyEmail(email.titulo, email.descricao);
        return email;
      }).toList();
    } else {
      throw Exception('Erro ao carregar e-mails');
    }
  }

  Future<void> createUsuario(String nome, String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"nome": nome, "email": email}),
      );

      if (response.statusCode == 201) {
        print("Usuário criado com sucesso");
      } else {
        print(
            "Erro ao criar usuário. Código de status: ${response.statusCode}");
        print("Resposta do servidor: ${response.body}");
        throw Exception('Erro ao criar usuário');
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
