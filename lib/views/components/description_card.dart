import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DescriptionCard extends StatelessWidget {
  final TextEditingController descriptionController;
  const DescriptionCard({Key? key, required this.descriptionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Bitte geben Sie eine Beschreibung an";
            }
            return null;
          },
          maxLines: 99,
          decoration: InputDecoration(
            hintText: "Beschreibung",
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey, width: 0.0),
            ),
          ),
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }
}
