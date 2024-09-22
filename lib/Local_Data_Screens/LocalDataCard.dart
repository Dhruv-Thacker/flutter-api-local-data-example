import 'package:flutter/material.dart';
import 'data.dart';

class LocalDataCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Cards'),
      ),
      body: ListView.builder(
        itemCount: sampleData.length,
        itemBuilder: (context, index) {
          final user = sampleData[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user['profileImage']),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Age: ${user['age']}'),
                          Text(user['email']),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Interests: ${user['interests'].join(', ')}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 10),
                  if (user['isPremiumUser'])
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(
                          'Premium User',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ],
                    )
                  else
                    const Text(
                      'Not a Premium User',
                      style: TextStyle(color: Colors.grey),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
