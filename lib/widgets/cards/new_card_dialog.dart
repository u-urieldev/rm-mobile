import 'package:flutter/material.dart';
import 'package:insults_album/widgets/cards/custom_card_dialog.dart';
import 'package:insults_album/widgets/custom/custom_button.dart';
import 'package:insults_album/widgets/custom/waiting_indicator.dart';
import '../custom/dialog_layout.dart';
import '../../services/cards_service.dart';
import '../../providers/new_card_provider.dart';
import 'package:provider/provider.dart';
import '../../models/card.dart';
import '../../constans/helpers.dart';

// Todos los cambios de contenido de este widget suceden en el mismo
// utilizando el estado del provider
class NewCardDialog extends StatelessWidget {
  const NewCardDialog({
    Key? key,
  }) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    final newCardProvider = Provider.of<NewCardProvider>(context);
    // WillPopScope acts as a dispose method here
    return WillPopScope(
      onWillPop: () {
        newCardProvider.state = 'get';
        newCardProvider.card = null;
        Navigator.pop(context);

        return Future.value(false);
      },
      child: DialogLayout(
        child:
            // ---     Principal screen (get new card)    ---
            newCardProvider.state == 'get'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.card_giftcard,
                        size: 100,
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                          label: const Text('Get a new card'),
                          action: () async {
                            newCardProvider.state = 'waiting';

                            final AppCard newCard =
                                await CardsService.fetchCard(
                                    CustomHelpers.getRandomCard());
                            newCardProvider.card = newCard;

                            newCardProvider.state = 'show';

                            CustomHelpers.showCustomSnackBar(
                                context,
                                "Your new card is ready",
                                "Card getting corectly",
                                Colors.green);
                          })
                    ],
                  )
                // ---       Waiting for card   ------
                : newCardProvider.state == 'waiting'
                    ? const WaitingIndicator()
                    // Show card    // ---  Card is ready     ---

                    : newCardProvider.state == 'show'
                        ? Material(
                            child: CustomCardDialog(
                              imageUri: newCardProvider.card!.image,
                              gender: newCardProvider.card!.gender,
                              id: newCardProvider.card!.id,
                              origin: newCardProvider.card!.origin,
                              name: newCardProvider.card!.name,
                              status: newCardProvider.card!.status,
                              species: newCardProvider.card!.species,
                              location: newCardProvider.card!.location,
                              episodes: newCardProvider.card!.episodes,
                            ),
                          )
                        : const Center(
                            child: Text("Error"),
                          ),
      ),
    );
  }
}
