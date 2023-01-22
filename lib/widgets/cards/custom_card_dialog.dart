import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../providers/loading_providers.dart';
import 'package:provider/provider.dart';
import '../custom_button.dart';

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
    required this.episodes,
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
  final List<dynamic> episodes;

  final TextStyle titleStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final TextStyle dataStyle = const TextStyle(fontSize: 18);
  final TextStyle nameStyle =
      const TextStyle(fontSize: 40, fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              // ---       Image      ---
              Stack(fit: StackFit.passthrough, children: [
                Image.network(
                  imageUri,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 240,
                  top: 20,
                  child: Container(
                    width: 72,
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                        color: Color.fromARGB(138, 77, 77, 77)),
                    child: Center(
                        child: Text(
                      '$id / 826',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ]),
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
                    Text('Last Known Location', style: titleStyle),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(location,
                              overflow: TextOverflow.clip, style: dataStyle),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // ---------     Episodes       ----------
                    GestureDetector(
                      onTap: () {
                        loadingProvider.isEpisode = !loadingProvider.isEpisode;
                      },
                      child: Row(
                        children: [
                          Text('Episodes', style: titleStyle),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    // ----       Episodes list --------
                    loadingProvider.isEpisode
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: episodes.map((e) => Text(e)).toList())
                        : const SizedBox(height: 4),
                    loadingProvider.isEpisode
                        ? const SizedBox(height: 10)
                        : const SizedBox(height: 0),
                    // ----  Button    -------
                    Center(
                      child: CustomButton(
                          label: const Text('Send'),
                          action: () => print('Picado')),
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
