
import 'package:flutter/material.dart';

class ChatMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Notificações",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              Spacer(),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.blue.withOpacity(.1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Recentes", style: TextStyle(color: Colors.blue)),
              ),
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.blue.withOpacity(.1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Visualizadas",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Column(
            children: List.generate(
              members.length,
                  (index) => MemberCard(member: members[index]),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Icon(Icons.feedback),
              SizedBox(width: 10),
              Text(
                "Sugestões? Clique aqui",
                style: TextStyle(color: Theme.of(context).iconTheme.color),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final Member? member;
  final bool showJob;
  final Widget? trailing;

  const MemberCard({Key? key, this.showJob = false,  this.member, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {},
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            member?.title as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(member?.image as String),
            ),
          ),
        ),
        subtitle: showJob ? Text(member?.job as String) : Text(member?.lastMessage as String),
      ),
    );
  }
}

class Member {
  final String image;
  final String title;
  final String lastMessage;
  final String job;

  Member(this.image, this.title, this.lastMessage, this.job);
}

List<Member> members = [
  Member(
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRGgIyRfPZ5W3ZGX7RjtW3UeuW_tUj1Nwq2ja_j5B8R9agla_HM-gKTs6vzVBhaqi-fes&usqp=CAU",
    "Envios Simultâneos",
    "Atenção! Possuímos delay contra ban",
    "Freelance",
  ),
  Member(
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRGgIyRfPZ5W3ZGX7RjtW3UeuW_tUj1Nwq2ja_j5B8R9agla_HM-gKTs6vzVBhaqi-fes&usqp=CAU",
    "SPAM",
    "Cuidado! SPAM pode gerar banimentos.",
    "Freelance",
  ),
  Member(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRGgIyRfPZ5W3ZGX7RjtW3UeuW_tUj1Nwq2ja_j5B8R9agla_HM-gKTs6vzVBhaqi-fes&usqp=CAU",
      "Banimentos",
      "Mesmo com nossos cuidados, você ainda poderá ser banido",
      "Product Designer"),
  Member(
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRGgIyRfPZ5W3ZGX7RjtW3UeuW_tUj1Nwq2ja_j5B8R9agla_HM-gKTs6vzVBhaqi-fes&usqp=CAU",
    "Power Abuse",
    "Não abuse das ferramentas, seja estratégico.",
    "Freelance",
  )
];

class Campanhas extends StatelessWidget {
  final DetalheCampanha? campanha;
  final bool showJob;
  final Widget? trailing;

  const Campanhas({Key? key, this.showJob = false,  this.campanha, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {},
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            campanha?.title as String,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(campanha?.image as String),
            ),
          ),
        ),
        subtitle: showJob ? Text(campanha?.job as String) : Text(campanha?.lastMessage as String),
      ),
    );
  }
}

class DetalheCampanha {
  final String image;
  final String title;
  final String lastMessage;
  final String job;

  DetalheCampanha(this.image, this.title, this.lastMessage, this.job);
}

List<DetalheCampanha> detalheCampanhas = [
  DetalheCampanha(
    "https://static.vecteezy.com/system/resources/previews/006/900/704/original/green-tick-checkbox-illustration-isolated-on-white-background-free-vector.jpg",
    "Envio em Massa",
    "Atenção! Possuímos delay contra ban",
    "Concluído em: 14/05/2023",
  ),
  DetalheCampanha(
    "https://static.vecteezy.com/system/resources/previews/006/900/704/original/green-tick-checkbox-illustration-isolated-on-white-background-free-vector.jpg",
    "Envio em Massa",
    "Cuidado! SPAM pode gerar banimentos.",
    "Concluído em: 10/05/2023",
  ),
  DetalheCampanha(
      "https://static.vecteezy.com/system/resources/previews/006/900/704/original/green-tick-checkbox-illustration-isolated-on-white-background-free-vector.jpg",
      "Envio em Massa",
      "Mesmo com nossos cuidados, você ainda poderá ser banido",
      "Concluído em: 06/05/2023"),
  DetalheCampanha(
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRGgIyRfPZ5W3ZGX7RjtW3UeuW_tUj1Nwq2ja_j5B8R9agla_HM-gKTs6vzVBhaqi-fes&usqp=CAU",
    "Power Abuse",
    "Não abuse das ferramentas, seja estratégico.",
    "Freelance",
  )
];
