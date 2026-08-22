import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
          title: Text("سفره🍉"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_add, color: Colors.black),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "الرئيسية"),
              Tab(icon: Icon(Icons.shopping_bag), text: "الاطعمه"),
              Tab(icon: Icon(Icons.favorite), text: "المفضلة"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("الرئيسية")),
            Center(
              child: Card(
                elevation: 4,
                child: SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "بورجر",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        'assets/images/prger.png',
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "2500 ",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(child: Text("المفضلة")),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: "مطاعم",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "الاطعمه",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
          ],
        ),
      ),
    );
  }
}
