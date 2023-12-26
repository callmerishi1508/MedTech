import 'package:firebase_project/model/filter_tiles.dart';
import 'package:flutter/material.dart';

class PublicPage extends StatefulWidget {
  PublicPage({Key? key}) : super(key: key);

  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  final GlobalKey<FormState> _requestFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _donateFormKey = GlobalKey<FormState>();

  final TextEditingController requestSpecificFieldController =
      TextEditingController();
  final TextEditingController donationSpecificField1Controller =
      TextEditingController();
  final TextEditingController donationSpecificField2Controller =
      TextEditingController();

  final List<String> status = ['All', 'Completed', 'Pending'];
  List<String> selectedStatus = [];

  @override
  Widget build(BuildContext context) {
    final statusOfList = donationList.where((StatusTile) {
      return selectedStatus.isEmpty ||
          selectedStatus.contains(StatusTile.status.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Page'),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Positioned(
                top: 0.0,
                right: 16.0,
                child: ElevatedButton(
                  onPressed: () {
                    _showRequestFormDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Request'),
                ),
              ),
              Positioned(
                top: 0.0,
                left: 16.0,
                child: ElevatedButton(
                  onPressed: () {
                    _showDonateFormDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Donate'),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: status
                  .map((status) => FilterChip(
                        selectedColor: Color.fromARGB(255, 199, 164, 204),
                        label: Text(status),
                        selected: selectedStatus.contains(status.toLowerCase()),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedStatus.add(status.toLowerCase());
                            } else {
                              selectedStatus.remove(status.toLowerCase());
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: statusOfList.length,
              itemBuilder: (context, index) {
                final StatusTile = statusOfList[index];
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      title: Text(
                        StatusTile.title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        StatusTile.status,
                        style: const TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Form'),
          content: Container(
            width: double.maxFinite,
            child: Form(
              key: _requestFormKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ..._buildCommonFields(),
                  _buildFormField(
                    label: 'Request Specific Field',
                    controller: requestSpecificFieldController,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_requestFormKey.currentState!.validate()) {
                  // Handle form submission for request form
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showDonateFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Donate Form'),
          content: Container(
            width: double.maxFinite,
            child: Form(
              key: _donateFormKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ..._buildCommonFields(),
                  _buildFormField(
                    label: 'Donation Specific Field 1',
                    controller: donationSpecificField1Controller,
                  ),
                  _buildFormField(
                    label: 'Donation Specific Field 2',
                    controller: donationSpecificField2Controller,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_donateFormKey.currentState!.validate()) {
                  // Handle form submission for donate form
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildCommonFields() {
    return [
      _buildFormField(label: 'Your Name', isRequired: true),
      _buildFormField(
          label: 'Mobile Number',
          keyboardType: TextInputType.phone,
          isRequired: true),
      _buildFormField(
          label: 'Your Email',
          keyboardType: TextInputType.emailAddress,
          isRequired: true),
      _buildFormField(
          label: 'Address',
          keyboardType: TextInputType.streetAddress,
          isRequired: true),
      _buildFormField(label: 'Details', maxLines: 3, isRequired: true),
    ];
  }

  Widget _buildFormField({
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool isRequired = false,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'This field is required.';
          }
          // Add additional validation logic if needed
          return null;
        },
      ),
    );
  }
}
