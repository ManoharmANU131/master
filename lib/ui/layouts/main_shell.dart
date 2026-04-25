import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/core/utils/app_utils.dart';
import 'package:my_contacts_app/models/contact.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_bloc.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_event.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_state.dart';
import 'package:my_contacts_app/ui/screens/contact_screen.dart';
import 'package:my_contacts_app/ui/screens/favourite_screen.dart';
import 'package:my_contacts_app/ui/widgets/contact_form.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [ContactScreen(), FavouriteScreen()],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: colorScheme.onSecondary,
        indicatorColor: colorScheme.primaryContainer.withValues(alpha: 0.5),
        indicatorShape: const StadiumBorder(),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: "Contacts",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),

      floatingActionButton: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          final isLoading = state.isLoading;
          return FloatingActionButton.extended(
            onPressed: () {
              AppUtils.showAppDialog(
                context: context,
                child: ContactForm(
                  title: "Add Contact",
                  buttonText: "Save",
                  isLoading: isLoading,

                  onSubmit: (name, phone, email, company, notes) {
                    final contact = Contact(
                      id: 0,
                      name: name,
                      phone: phone,
                      email: email,
                      company: company,
                      notes: notes,
                      isFavourite: _currentIndex == 1,
                    );

                    context.read<ContactBloc>().add(AddContactEvent(contact));
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Contact"),
          );
        },
      ),
    );
  }
}
