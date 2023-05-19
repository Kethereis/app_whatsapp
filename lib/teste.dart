import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dart_autogui/dart_autogui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void _sendMessage() async {
    final phoneNumber = '5544988175773'; // Número de telefone com o código do país
    final message = 'Olá! Teste bem sucedido'; // Mensagem pré-definida

    final whatsappUrl = 'https://wa.me/$phoneNumber?text=$message';

    await Keyboard.hotKey(['enter']);

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Enviar mensagem pelo WhatsApp'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Enviar mensagem'),
            onPressed: _sendMessage,
          ),
        ),
      ),
    );
  }
}
