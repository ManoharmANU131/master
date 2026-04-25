import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_contacts_app/app/router/route_path.dart';
import 'package:my_contacts_app/core/helpers/launch_external_action.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_bloc.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_event.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_state.dart';
import 'package:my_contacts_app/ui/widgets/contact_card.dart';
import 'package:my_contacts_app/ui/widgets/empty_state_widget.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    context.read<ContactBloc>().add(LoadContactsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Something went wrong while saving contact"),
            ),
          );
        }
      },
      builder: (context, state) {
        final contacts = state.filteredContacts;

        final isEmpty = state.contacts.isEmpty;

        final isSearching = state.searchQuery.trim().isNotEmpty;

        final noSearchResults = isSearching && contacts.isEmpty;

        if (state.isLoading && isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return CustomScrollView(
          physics: isEmpty
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 65,
              backgroundColor: colorScheme.surface,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.sm,
                ),
                title: Text(
                  "My Contacts",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            if (!isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: TextField(
                    onChanged: (value) {
                      context.read<ContactBloc>().add(
                        SearchContactEvent(value),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Search contacts...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
              ),

            if (!isEmpty && !isSearching)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: AppSizes.md,
                  ),
                  child: Text(
                    "Recent Contacts",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            if (isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyStateWidget(
                  icon: Icons.contact_page_outlined,
                  title: "No contacts yet",
                  subtitle: "Start by adding your first contact",
                ),
              )
            else if (noSearchResults)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyStateWidget(
                  icon: Icons.search_off,
                  title: "No matching contacts",
                  subtitle: "Try searching with another name or number",
                ),
              )
            else
              SliverList.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return GestureDetector(
                    onTap: () {
                      context.push(RoutePath.contactDetail, extra: contact.id);
                      if (context.mounted) {
                        context.read<ContactBloc>().add(LoadContactsEvent());
                      }
                    },
                    child: ContactCard(
                      leading: contact.name[0].toUpperCase(),
                      name: contact.name,
                      phone: contact.phone,
                      favIcon: contact.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      onCallButtonPressed: () {
                        launchExternalAction(
                          scheme: 'tel',
                          path: contact.phone,
                        );
                      },
                      onFavButtonPressed: () {
                        context.read<ContactBloc>().add(
                          ToggleFavouriteEvent(contact),
                        );
                      },
                    ),
                  );
                },
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        );
      },
    );
  }
}
