import 'package:flutter/material.dart';

import '../color.dart';

class MessageBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
                Expanded(
                  child: TextFormField(
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
                  onPressed: () {},
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