import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD8F3DC), Color(0xFF475E4F)],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Hamro Bhagaicha 🌿',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=3',
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Welcome Aarati!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search nearest nursery...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 253, 253),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            // SizedBox(height: 20),
            //           // Cards
            //           Expanded(
            //             child: ListView(
            //               children: [
            //                 _buildCard(
            //                   icon: '🌱',
            //                   title: 'Plants',
            //                   subtitle:
            //                       '“Give this plant a new home – make your garden greener!”',
            //                 ),
            //                 _buildCard(
            //                   icon: '🪴',
            //                   title: 'Pot',
            //                   subtitle:
            //                       '“Add this pot to your garden collection and style your plants beautifully”',
            //                 ),
            //                 _buildCard(
            //                   icon: '🌱🪴',
            //                   title: 'plant + plot combo',
            //                   subtitle:
            //                       '“Get this plant + pot combo and brighten your garden – a perfect duo for your green space”',
            //                 ),
            //                 _buildCard(
            //                   icon: '💡',
            //                   title: 'Today’s Tips:',
            //                   subtitle: 'Water early the morning for the best growth!',
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     bottomNavigationBar: BottomAppBar(
            //       shape: const CircularNotchedRectangle(),
            //       notchMargin: 8,
            //       child: SizedBox(
            //         height: 60,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
            //             IconButton(onPressed: () {}, icon: const Icon(Icons.inventory)),
            //             const SizedBox(width: 40), // Space for middle button
            //             IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
            //             IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
            //           ],
            //         ),
            //       ),
            //     ),
            //     floatingActionButton: FloatingActionButton(
            //       onPressed: () {},
            //       child: const Icon(Icons.add),
            //     ),
            //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            //   );
            // }

            // Widget _buildCard({required String icon, required String title, required String subtitle}) {
            //   return Card(
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //     color: Colors.white.withOpacity(0.8),
            //     margin: const EdgeInsets.symmetric(vertical: 8),
            //     child: Padding(
            //       padding: const EdgeInsets.all(15),
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             icon,
            //             style: const TextStyle(fontSize: 28),
            //           ),
            //           const SizedBox(width: 15),
            //           Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   title,
            //                   style: const TextStyle(
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //                 const SizedBox(height: 5),
            //                 Text(
            //                   subtitle,
            //                   style: const TextStyle(fontSize: 14),
            //                 ),
            //               ],
            //             ),
            //           ),
          ],
        ),
      ),
    );
  }
}
