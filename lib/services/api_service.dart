import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getGemmaResponse(String prompt) async {
  final url = Uri.parse('http://127.0.0.1:11434/api/generate');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'model': 'gemma3:1b',
    'prompt': prompt,
    'stream': false,
  });

  try {
    print('Enviando requisição para $url');
    print('Corpo da requisição: $body');

    final response = await http.post(url, headers: headers, body: body);
    print('Resposta: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? 'Resposta vazia';
    } else {
      return 'Erro: ${response.statusCode} - ${response.reasonPhrase}';
    }
  } catch (e) {
    return 'Erro: Exception: $e';
  }
}
