import 'package:flutter/material.dart';

class HospitalAuthoritiesPage extends StatefulWidget {
  const HospitalAuthoritiesPage({Key? key}) : super(key: key);

  @override
  State<HospitalAuthoritiesPage> createState() =>
      _HospitalAuthoritiesPageState();
}

class _HospitalAuthoritiesPageState extends State<HospitalAuthoritiesPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Authorities Page"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
