import 'package:flutter/material.dart';

import 'color.dart';
import 'messages/chatMember.dart';
import 'messages/customDivider.dart';
import 'messages/header.dart';
import 'messages/messageBox.dart';
import 'messages/sideBar.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: KColor.primaryColor,
        iconTheme: IconThemeData(color: KColor.iconColor),
      ),
      home: ChatBody(),
    );
  }
}



class ChatBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          CustomDivider(),
          Expanded(
            child: Column(
              children: [
                Header(),
                Divider(),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        child: ChatMember(),
                      ),
                      CustomDivider(),
                      Expanded(child: MessageBox()),
                      CustomDivider(),
                      Container(
                        width: 400,
                        child: MoreDetails(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MoreDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        child: Column(
          children: [
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey[700],
              indicatorColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(text: "Concluídos"),
                Tab(text: "Agendados"),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Esse Mês".toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: List.generate(
                      2,
                          (index) => Campanhas(
                        showJob: true,
                        campanha: detalheCampanhas[index],
                        trailing: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color:
                            Theme.of(context).primaryColor.withOpacity(.1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icon(Icons.message),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Anteriores".toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      1,
                          (index) => Campanhas(
                        showJob: true,
                        campanha: detalheCampanhas[index],
                        trailing: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color:
                            Theme.of(context).primaryColor.withOpacity(.1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icon(Icons.message),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const ListTile(
                    title: Text(
                      "Reportar Bug",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("Fale com a equipe de suporte"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}