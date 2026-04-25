import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_contacts_app/app/router/route_path.dart';
import 'package:my_contacts_app/core/helpers/launch_external_action.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_bloc.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_event.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_state.dart';
import 'package:my_contacts_app/ui/widgets/contact_card.dart';
import 'package:my_contacts_app/ui/widgets/empty_state_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourites",
          style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),

      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          final contacts = state.contacts;

          final favourites = contacts.where((c) => c.isFavourite).toList();

          if (state.isLoading && favourites.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (favourites.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.favorite_border,
              title: "No Favorites yet",
              subtitle: "Tap the heart icon to add your favorite contacts",
            );
          }

          return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final contact = favourites[index];

              return GestureDetector(
                onTap: () {
                  context.push(RoutePath.contactDetail, extra: contact.id);
                  if (context.mounted) {
                    context.read<ContactBloc>().add(LoadContactsEvent());
                  }
                },
                child: ContactCard(
                  leading: contact.name[0],
                  name: contact.name,
                  phone: contact.phone,
                  favIcon: contact.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  onCallButtonPressed: () {
                    launchExternalAction(scheme: 'tel', path: contact.phone);
                  },

                  onFavButtonPressed: () {
                    context.read<ContactBloc>().add(
                      ToggleFavouriteEvent(contact),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
