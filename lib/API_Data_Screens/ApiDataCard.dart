import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiDataCard extends StatefulWidget {
  @override
  _ApiDataCardState createState() => _ApiDataCardState();
}

class _ApiDataCardState extends State<ApiDataCard> {
  List<Map<String, dynamic>> sampleData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        sampleData = jsonResponse.map((user) {
          return {
            "title": user['name'],
            "username": user['username'],
            "email": user['email'],
            "address": "${user['address']['street']}, ${user['address']['suite']}, ${user['address']['city']}, ${user['address']['zipcode']}",
            "phone": user['phone'],
            "website": user['website'],
            "company": user['company']['name'],
            "profileImage": "https://via.placeholder.com/150", 
            "isPremiumUser": false,
            "interests": ["Interest 1", "Interest 2"], 
          };
        }).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Cards'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                            Expanded(
                              child: Column(
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
                                  Text('Username: ${user['username']}'),
                                  Text('Email: ${user['email']}'),
                                  Text('Phone: ${user['phone']}'),
                                  Text('Website: ${user['website']}'),
                                  Text('Company: ${user['company']}'),
                                  Text('Address: ${user['address']}'),
                                ],
                              ),
                            ),
                          ],
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

