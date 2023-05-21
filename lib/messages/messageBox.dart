
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:typed_data';


import '../color.dart';

class MessageBox extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const Text(
                "Mensagens em massa",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Configuração de Envio",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Atenção! O Whatsapp deve estar conectado.\n",
                style: TextStyle(
                    color: Color(0xff78A1C6),
                    fontSize: 17,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Domingo, 14 de Abril",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              const SizedBox(height: 20),
               Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/6551/6551854.png"),

                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMessage("Olá! Seja bem-vindo."),
                        _buildMessage("Digite a sua mensagem de envio"),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildMessage(
                          "Ok! Segue a mensagem que desejo enviar\n aos meus contatos",
                          isSend: true,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                     const CircleAvatar(
                       backgroundImage: NetworkImage("https://99designs-blog.imgix.net/blog/wp-content/uploads/2020/05/attachment_71136407-e1588658965715.jpg?auto=format&q=60&fit=max&w=930"),
                     ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.attach_file), onPressed:  ()  {
                  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
                  uploadInput.click();

                  uploadInput.onChange.listen((event) {
                    final files = uploadInput.files;
                    if (files != null && files.isNotEmpty) {
                      final file = files[0];
                      // Prossiga para enviar o arquivo para o endpoint
                      uploadFile(file);
                    } else {
                      // Usuário cancelou a seleção do arquivo
                    }
                  });
                },),
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Mensagem",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildMessage(String message, {bool isSend = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSend ? KColor.primaryColor : Colors.grey[300]?.withOpacity(.4),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Text(
        message,
        style: TextStyle(color: isSend ? Colors.white : null),
      ),

    );
  }
}