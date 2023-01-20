import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomCardDialog extends StatelessWidget {
  CustomCardDialog({
    required this.imageUri,
    required this.gender,
    required this.id,
    required this.origin,
    required this.name,
    required this.status,
    required this.species,
    required this.location,
    required this.statusColor,
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
  final Color statusColor;

  final TextStyle titleStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final TextStyle dataStyle = const TextStyle(fontSize: 18);
  final TextStyle nameStyle =
      const TextStyle(fontSize: 40, fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Image.network(
                imageUri,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, overflow: TextOverflow.clip, style: nameStyle),
                    const SizedBox(height: 10),
                    // -------------- Gender/ species ------------------
                    // ---- Titles  ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text('Gender ', style: titleStyle)),
                        Expanded(
                          child: Text('Species', style: titleStyle),
                        )
                      ],
                    ),
                    // --- Data ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Text(gender, style: dataStyle)),
                        Expanded(
                          child: Text(species, style: dataStyle),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    // -------------- status ------------------
                    Text('Status', style: titleStyle),
                    Row(
                      children: [
                        Icon(
                          Icons.fiber_manual_record,
                          size: 13,
                          color: statusColor,
                        ),
                        const SizedBox(width: 4),
                        Text(status, style: dataStyle),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // -------------- Locations ------------------
                    Text('Origin', style: titleStyle),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(width: 4),
                        Flexible(
                            child: Text(
                          origin,
                          style: dataStyle,
                          overflow: TextOverflow.clip,
                        )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Last Unknow Location', style: titleStyle),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(location,
                              overflow: TextOverflow.clip, style: dataStyle),
                        ),
                      ],
                    )
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
