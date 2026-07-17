import 'package:flutter/material.dart';
import 'package:get_app/components/appdrawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EEF3),
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      drawer: const Appdrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 380,
              width: double.infinity,
              child: Image.asset('assets/images/me.jpg', fit: BoxFit.cover),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              color: const Color(0xFFF3EEF3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "ณภัทร สมาน",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("Someone", style: TextStyle(fontSize: 16)),
                            SizedBox(height: 4),
                            Text(
                              "Sisaket Rajabhat University",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star,
                          color: Colors.red,
                          size: 42,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _menuButton(Icons.facebook, "Social"),
                      _menuButton(Icons.email, "Email"),
                      _menuButton(Icons.share, "Share"),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(thickness: 1, color: Colors.black26),
                  const SizedBox(height: 30),
                  const Text(
                    "นักศึกษาประจำสาขาวิชาวิทยาการคอมพิวเตอร์ "
                    "คณะศิลปศาสตร์และวิทยาศาสตร์ "
                    "มหาวิทยาลัยราชภัฏศรีสะเกษ.",
                    style: TextStyle(fontSize: 18, height: 1.7),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "อยากนอน "
                    "อยากกิน "
                    "อยากอยู่เฉยๆ "
                    "และมีความสุข",
                    style: TextStyle(fontSize: 18, height: 1.7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
