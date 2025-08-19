import 'package:flutter/material.dart';
void main(){
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Halaman Utama')),
        bottomNavigationBar: BottomNavigationBar(
          items : const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Persons',
            ),
          ],
        ),
    );
  }
}