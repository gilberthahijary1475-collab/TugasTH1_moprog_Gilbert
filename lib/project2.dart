import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int likes = 10;
  bool selected = false;
  bool isNameHeld = false;
  bool showPlusOne = false;
  String message = '';

  void _handleDoubleTapLike() {
    setState(() {
      likes++;
      showPlusOne = true;
    });

    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          showPlusOne = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          leading: const Icon(Icons.menu),
          actions: const [
            Icon(Icons.settings),
            SizedBox(width: 15),
          ],
        ),
        body: Builder(
          builder: (context) {
            final screenWidth = MediaQuery.of(context).size.width;

            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth * 0.95,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Flex(
                        direction: screenWidth > 600 ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: screenWidth > 600 ? MainAxisAlignment.start : MainAxisAlignment.center,
                        children: [
                          // Foto Profil
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = !selected;
                              });
                            },
                            onDoubleTap: _handleDoubleTapLike,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected ? Colors.blue : Colors.transparent,
                                  width: 5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbdhgXPRJVZBux9mDr_0Osob-vT_jm-tVjZsVUhiDkKA&s=10',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 120,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.person, color: Colors.white, size: 80),
                                    );
                                  },
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth > 600 ? 25 : 0,
                            height: screenWidth > 600 ? 0 : 15,
                          ),

                          // Detail Profil & Long Press Nama
                          Column(
                            crossAxisAlignment: screenWidth > 600 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    isNameHeld = !isNameHeld;
                                    message = isNameHeld ? 'LETS FLYYY!!' : '';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isNameHeld ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'Gilbert Valentino Hahijary',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              if (message.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  message,
                                  style: const TextStyle(fontSize: 12, color: Colors.blueGrey, fontStyle: FontStyle.italic),
                                ),
                              ],
                              const SizedBox(height: 5),
                              const Text(
                                'gilbert.825240070@stu.untar.ac.id',
                                style: TextStyle(fontSize: 13, color: Colors.black54),
                              ),
                              const SizedBox(height: 8),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.location_on, size: 16, color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text(
                                    'Untar, Indonesia',
                                    style: TextStyle(fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Baris Likes & Indikator +1
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.favorite, color: Colors.red, size: 22),
                                  const SizedBox(width: 6),
                                  Text(
                                    '$likes',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  if (showPlusOne) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        '+1',
                                        style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Tombol Edit Profile
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5CAEEF),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Daftar Menu Opsi
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.person_outline, color: Colors.blueGrey),
                        title: const Text('Data Diri', style: TextStyle(fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {},
                      ),
                      const Divider(height: 1, thickness: 0.5),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.shield_outlined, color: Colors.blueGrey),
                        title: const Text('Hobi', style: TextStyle(fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {},
                      ),
                      const Divider(height: 1, thickness: 0.5),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.info_outline, color: Colors.blueGrey),
                        title: const Text('Tentang Saya', style: TextStyle(fontWeight: FontWeight.w500)),
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}