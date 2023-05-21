import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:typed_data';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[
   const ChatMessage(messageContent: 'Olá. Seja bem-vindo!', isResponse: true),
    const ChatMessage(messageContent: 'Digite a sua mensagem de envio', isResponse: true),
  ];
  String? _fileAttachment;
  void uploadFile(html.File file) async {
    String url = 'https://9f00-170-238-148-141.ngrok-free.app/webhook_kiwify'; // Substitua pelo seu endpoint

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoadEnd.first;

      final Uint8List fileBytes = Uint8List.fromList(reader.result as List<int>);

      request.files.add(
        http.MultipartFile.fromBytes('file', fileBytes, filename: file.name),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        // Arquivo enviado com sucesso
        var responseBody = await response.stream.bytesToString();
        print('Resposta do servidor: $responseBody');
      } else {
        // Houve um erro no envio do arquivo
        print('Erro ao enviar o arquivo. Código de status: ${response.statusCode}');
      }
    } catch (error) {
      // Trate quaisquer erros que possam ocorrer
      print('Erro ao enviar o arquivo: $error');
    }
  }

  void _handleSubmitted(String message) {
    _textController.clear();
    ChatMessage newMessage = ChatMessage(messageContent: message);
    setState(() {
      _messages.add(newMessage);
    });
    if (_fileAttachment != null) {
      newMessage = ChatMessage(
        messageContent: message,
        fileAttachment: _fileAttachment,
      );
      _fileAttachment = null;
    }

    if (_messages.length == 3) {
      // Primeira pergunta enviada
      _sendDelayedMessage('Deseja enviar, áudio, imagem ou algum anexo?');
    } else if (_messages.length == 5) {
      // Segunda pergunta enviada
      _sendDelayedMessage('Envie o caminho do arquivo. Exemplo: C:/image/teste.png');
    } else if (_messages.length == 6) {
      // Segunda pergunta enviada
      _sendDelayedMessage('Deseja enviar agora ou agendar?');
    }
    else {
      // Todas as perguntas foram enviadas
      // Você pode implementar a lógica aqui para lidar com as respostas
      _sendDelayedMessage('Obrigado por responder! Iniciando o envio de mensagem em massa.');
      _sendDelayedMessage('Por favor, não utilize o computador até o processo acabar.');

    }
  }

  Future<void> _sendDelayedMessage(String message) async {
    await Future.delayed(Duration(seconds: 1));
    ChatMessage responseMessage = ChatMessage(messageContent: message, isResponse: true);

    if (_fileAttachment != null) {
      responseMessage = responseMessage.copyWith(fileAttachment: _fileAttachment);
      _fileAttachment = null;
    }

    setState(() {
      _messages.add(responseMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.attach_file),
              onPressed:  () async {
                final filePickerResult = await FilePickerWeb.platform.pickFiles();

                html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
              uploadInput.click();

                if (filePickerResult != null) {
                  final file = filePickerResult.files.first;
                  setState(() {
                    _fileAttachment = file.name;
                  });
                  // Prossiga para enviar o arquivo para o endpoint
                  // uploadFile(file as html.File);
                } else {
    // Usuário cancelou a seleção do arquivo
              // uploadInput.onChange.listen((event) {
              //   final files = uploadInput.files;
              //   if (files != null && files.isNotEmpty) {
              //     final file = files[0];
              //     setState(() {
              //       _fileAttachment = file.name;
              //     });
              //     // Prossiga para enviar o arquivo para o endpoint
              //     //uploadFile(file);
              //   } else {
              //     // Usuário cancelou a seleção do arquivo
              //   }
              }
            },),
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Mensagem',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String messageContent;
  final bool isResponse;
  final String? fileAttachment;

  const ChatMessage({required this.messageContent, this.isResponse = false,this.fileAttachment,});

  ChatMessage copyWith({String? fileAttachment}) {
    return ChatMessage(
      messageContent: messageContent,
      isResponse: isResponse,
      fileAttachment: fileAttachment ?? this.fileAttachment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child:  isResponse ? const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/6551/6551854.png"),
            ) : const CircleAvatar(
              backgroundImage: NetworkImage("https://99designs-blog.imgix.net/blog/wp-content/uploads/2020/05/attachment_71136407-e1588658965715.jpg?auto=format&q=60&fit=max&w=930"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isResponse ? 'Bot Sistema' : 'Você',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(messageContent),
                ),
                if (fileAttachment != null)
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Arquivo anexado: $fileAttachment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
