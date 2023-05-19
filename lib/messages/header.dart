
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
                const Icon(
                  Icons.message,
                  color: Colors.blue,
                ),
                const SizedBox(width: 20),
                const Text(
                  "Mensagens",
                  style:  TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  constraints: const BoxConstraints(maxWidth: 120),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Procurar",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
               const SizedBox(width: 20),
                Stack(
                  children: [
                    const Icon(Icons.notifications, size: 30),
                    Positioned(
                      top: 4,
                      right: 1,
                      child: Container(
                        height: 17,
                        width: 17,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Text(
                          "4",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 20),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://99designs-blog.imgix.net/blog/wp-content/uploads/2020/05/attachment_71136407-e1588658965715.jpg?auto=format&q=60&fit=max&w=930",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}