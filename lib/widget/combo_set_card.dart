// import 'package:flutter/material.dart';

// class ComboSetCard extends StatelessWidget {
//   final String imagePath;
//   final String name;
//   final int price;
//   final int rating;
//   final VoidCallback? onTap; 

//   const ComboSetCard({
//     super.key,
//     required this.imagePath,
//     required this.name,
//     required this.price,
//     required this.rating,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, 
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//           border: Border.all(color: Colors.green, width: 1),
//         ),
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(
//               imagePath,
//               width: double.infinity,
//               height: 180,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 15),
//             Text(
//               name,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 41, 3, 181),
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 15),
//             Text(
//               'NRP $price',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 42, 119, 45),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Row(
//               children: List.generate(
//                 5,
//                 (index) => Icon(
//                   index < rating ? Icons.star : Icons.star_border,
//                   color: const Color.fromARGB(255, 60, 137, 62),
//                   size: 15,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 6),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 ),
//                 onPressed: () {},
//                 child: const Text('+ Add'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ComboSetCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final int price;
  final int rating;
  final VoidCallback? onTap; 

  const ComboSetCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.green, width: 1),
        ),
        color: const Color(0xFFE2E8DC),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Image on left
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Right side info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 41, 3, 181),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'NRP $price',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 42, 119, 45),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: const Color.fromARGB(255, 60, 137, 62),
                          size: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                        ),
                        onPressed: () {},
                        child: const Text('+ Add'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


