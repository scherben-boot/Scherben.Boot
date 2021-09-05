import 'package:flutter/material.dart';
import 'package:scherben_boot/services/image_provider.service.dart';

class ImagePickerCard extends FormField<String?> {
  ImagePickerCard(
      {required ImageProviderService imageProviderService,
      required FormFieldSetter<String?> onSaved})
      : super(
            onSaved: onSaved,
            builder: (state) {
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final imagePath =
                                    await imageProviderService.pickImage();
                                print(imagePath);
                                state.didChange(imagePath);
                              },
                              icon: Icon(Icons.image_search),
                              label: Text("Bild anfügen"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey[500],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () => state.didChange(null),
                              icon: Icon(Icons.delete),
                              label: Text("Bild entfernen"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey[500],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(child: Text(state.value ?? "Kein Pfad")),
                  ],
                ),
              );
            });
}
