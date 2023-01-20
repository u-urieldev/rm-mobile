import 'dart:ffi';

import 'package:flutter/material.dart';
import 'custom_card_dialog.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    required this.imageUri,
    required this.gender,
    required this.id,
    required this.origin,
    required this.name,
    required this.status,
    required this.species,
    required this.location,
    Key? key,
  }) : super(key: key);

  final int id;
  final String imageUri;
  final String name;
  final String status;
  final String species;
  final String location;
  final String gender;
  final String origin;

  Color getStatusColor() {
    if (status == "Alive") {
      return Colors.green;
    }

    if (status == "Dead") {
      return Colors.red;
    }

    // Other case
    return Color.fromARGB(255, 116, 114, 114);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomCardDialog(
              imageUri: imageUri,
              gender: gender,
              id: id,
              origin: origin,
              name: name,
              status: status,
              species: species,
              location: location,
              statusColor: getStatusColor(),
            );
          },
        );
      },
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Color.fromARGB(255, 194, 191, 191),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUri,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    flexText(
                        name,
                        const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.fiber_manual_record,
                          size: 13,
                          color: getStatusColor(),
                        ),
                        const SizedBox(width: 4),
                        flexText('$status - $species',
                            const TextStyle(fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        flexText(location, const TextStyle()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible flexText(String text, TextStyle style) {
    return Flexible(
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}
