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
              SizedBox(height: 40),
            Center(
              child: Text(
                
                'Hamro Bhagaicha 🌿',
                style: const TextStyle(
                  fontSize: 25,
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

            
            Expanded(child: ListView(
             children: [

              
              HomeButtonCard(
                    icon: '🌱',
                    title: 'Plants',
                    subtitle: 'Give this plant a new home – make your garden greener!',
                  ),
                  SizedBox(height: 15),
                  HomeButtonCard(
                    icon: '🪴',
                    title: 'Pot',
                    subtitle: 'Add this pot to your garden collection and style your plants beautifully',
                  ),
                  SizedBox(height: 15),
                  HomeButtonCard(
                    icon: '🌱🪴',
                    title: 'Plant + Pot Combo',
                    subtitle: 'Get this plant + pot combo and brighten your garden – a perfect duo for your green space',
                  ),
                  SizedBox(height: 15),
                  HomeButtonCard(
                    icon: '💡',
                    title: 'Today\'s Tips',
                    subtitle: 'Water early the morning for the best growth!',
                  ),
                  SizedBox(height: 50),
                  ],
            )
            )
          ],
        ),
      ),
    );
  }
}

class HomeButtonCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const HomeButtonCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE3EED9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
