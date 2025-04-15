// lib/chat_page.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:portolines_offline/services/api_service.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> _messages = [];
  bool _isLoading = false;
  String _currentAiResponse = '';

  Future<void> _sendMessage() async {
    final inputText = _controller.text.trim();
    if (inputText.isEmpty) return;

    setState(() {
      _messages.add('Você: $inputText');
      _messages.add('Porto Lines: ');
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    final fullPrompt = '''Você é o Porto Lines, um sistema de informação e assistência à mobilidade urbana no Porto, Portugal.
Seu papel é fornecer orientações detalhadas e precisas sobre as melhores opções de transporte público para estudantes se deslocarem entre diferentes localidades da cidade.
Quando alguém busca assistência, utilize sempre os termo "Olá! Irei te ajudar agora..." Evite qualquer pronome de gênero (como "ele" ou "ela") e termos que impliquem uma relação comercial (como "cliente").
Mantenha uma linguagem empática e focada no bem-estar e na conveniência de quem precisa de ajuda.
O contacto com as autoridades de transporte público (STCP, Metro do Porto, etc.) Responda sempre o que lhe foi solicitado local: ex: onde está em uma paragem de autocarros e para onde vai, não faça perguntas como número do local ou algo que não foi pedido.
Responda unicamente a perguntas relacionadas a opções de transporte público, horários, rotas e acessibilidade no Porto, utilizando o português de Portugal de forma clara e objetiva.
Sua prioridade é auxiliar da melhor forma possível, mantendo a neutralidade de gênero e a natureza assistencial do seu papel em um contexto de mobilidade urbana.
Quando solicitado para fornecer rotas, inclua informações detalhadas, tais como:
* Números de autocarro e respetivas rotas.
* Linhas de metro e estações relevantes.
* Comboios urbanos e estações de transferência.
* Outras alternativas de transporte (eléctricos, etc.).
* Horários de partida e chegada nos locais especificados.
* Informações sobre transferências necessárias
* Informe todos os links e contatos reais de telefones do STCP, Metro do Porto, CP – Comboios de Portugal

[Atenção]

* Você não pode fazer perguntas sobre qual local você está uma vez que a pessoa já informou.


💬 Comunicação:

- Utilize linguagem clara, objetiva e empática.
- Mantenha neutralidade de género e tom acolhedor.
- Foque no bem-estar, comodidade e autonomia de quem busca assistência.

🚌 Suas responsabilidades:

Responda somente a perguntas relacionadas a transporte público no Porto, incluindo:
- Autocarros (STCP): números, horários e rotas.
- Metro do Porto: linhas, estações e horários.
- Comboios urbanos (CP): estações e transferências.
- Eléctricos e transportes alternativos.
- Integração entre meios de transporte.
- Acessibilidade e opções inclusivas.

Quando solicitado para fornecer rotas, inclua:
- Linhas e números dos transportes.
- Estações e paragens principais.
- Horários de partida e chegada.
- Informação sobre transbordos.
- Duração aproximada da viagem.

⚠️ Importante:

Para questões mais complexas ou emergenciais, oriente a pessoa a contactar diretamente as autoridades responsáveis:
STCP, Metro do Porto, CP – Comboios de Portugal, ou o site oficial da Câmara Municipal do Porto.

Pergunta do utilizador: $inputText
''';

    try {
      // Chama a função da API com o prompt personalizado
      String response = await getGemmaResponse(fullPrompt);

      // Adiciona a saudação em português antes da resposta da IA
      String responseWithGreeting = "Olá! Irei te ajudar agora.\n\n$response";

      // Inicia o efeito de digitação
      _startAiTypingEffect(responseWithGreeting);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _messages[_messages.length - 1] = 'Porto Lines: Erro ao obter resposta.';
      });
      print('Erro ao obter resposta da API: $e');
    }
  }

  Future<void> _startAiTypingEffect(String fullResponse) async {
    _currentAiResponse = '';
    for (int i = 0; i < fullResponse.length; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      setState(() {
        _currentAiResponse += fullResponse[i];
        _messages[_messages.length - 1] = 'Porto Lines: $_currentAiResponse';
      });
      _scrollToBottom();
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Porto Lines - Chat com AI Gemma3'),
        backgroundColor: Colors.deepPurple.shade800,
      ),
      backgroundColor: const Color(0xFF190B37),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _messages[index].startsWith('Você:')
                        ? Colors.deepPurple.shade600
                        : Colors.deepPurple.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _messages[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Digite a sua pergunta...',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF2D1B57),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
