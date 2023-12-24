import 'package:flutter/material.dart';

class PublicPage extends StatelessWidget {
  PublicPage({Key? key});

  final GlobalKey<FormState> _requestFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _donateFormKey = GlobalKey<FormState>();

  final TextEditingController requestSpecificFieldController =
      TextEditingController();
  final TextEditingController donationSpecificField1Controller =
      TextEditingController();
  final TextEditingController donationSpecificField2Controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public Page'),
      ),
      body: Stack(
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
    );
  }

  void _showRequestFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Request Form'),
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
