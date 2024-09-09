import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Destinations'),
      ),
      body: FutureBuilder<List<Place>>(
        future: fetchPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                Place place = snapshot.data![index];
                return ListTile(
                  leading: Icon(Icons.place),
                  title: Text(place.name),
                  subtitle: Text(place.description),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Place {
  final int id;
  final String name;
  final String description;

  Place({required this.id, required this.name, required this.description});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

Future<List<Place>> fetchPlaces() async {
  final response = await http.get(Uri.parse('http://localhost:8080/api/places/getAllPlace'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Place.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load places');
  }
}