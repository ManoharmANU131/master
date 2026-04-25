import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_contacts_app/core/helpers/launch_external_action.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';
import 'package:my_contacts_app/core/utils/app_utils.dart';
import 'package:my_contacts_app/models/contact.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_bloc.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_event.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_state.dart';
import 'package:my_contacts_app/ui/widgets/action_button.dart';
import 'package:my_contacts_app/ui/widgets/contact_form.dart';
import 'package:my_contacts_app/ui/widgets/contact_info_tile.dart';

class ContactDetailsScreen extends StatefulWidget {
  final int contactId;

  const ContactDetailsScreen({super.key, required this.contactId});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ContactBloc>().add(GetContactByIdEvent(widget.contactId));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorScheme.surface,
        backgroundColor: colorScheme.secondary,
        actions: [
          IconButton(
            onPressed: () {
              AppUtils.showAppDialog(
                context: context,
                child: BlocBuilder<ContactBloc, ContactState>(
                  builder: (context, state) {
                    final contact = state.selectedContact!;
                    return ContactForm(
                      title: "Edit Contact",
                      buttonText: "Update",
                      isLoading: state.isLoading,

                      initialName: contact.name,
                      initialPhone: contact.phone,
                      initialEmail: contact.email,
                      initialCompany: contact.company,
                      initialNotes: contact.notes,

                      onSubmit: (name, phone, email, company, notes) {
                        final updatedContact = Contact(
                          id: contact.id!,
                          name: name,
                          phone: phone,
                          email: email,
                          company: company,
                          notes: notes,
                          isFavourite: contact.isFavourite,
                        );

                        context.read<ContactBloc>().add(
                          UpdateContactEvent(updatedContact),
                        );
                      },
                    );
                  },
                ),
              );
            },
            icon: Icon(Icons.edit, color: colorScheme.onPrimary),
          ),
        ],
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          final contact = state.selectedContact;

          if (contact == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(color: colorScheme.secondary),
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      contact.name[0].toUpperCase(),
                      style: textTheme.displayMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.lg,
                      vertical: AppSizes.sm,
                    ),
                    child: Text(
                      contact.name,
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.lg,
                    ),
                    child: Text(
                      contact.company?.isNotEmpty == true
                          ? contact.company!
                          : "No Company",
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.onPrimary.withValues(alpha: 0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AppSizes.md,
                    children: [
                      ActionButton(
                        icon: Icons.phone,
                        label: "Call",
                        color: colorScheme.secondaryContainer,
                        onTap: () {
                          launchExternalAction(
                            scheme: 'tel',
                            path: contact.phone,
                          );
                        },
                      ),
                      ActionButton(
                        icon: Icons.message,
                        label: "Message",
                        color: colorScheme.secondaryContainer,
                        onTap: () {
                          launchExternalAction(
                            scheme: 'sms',
                            path: contact.phone,
                          );
                        },
                      ),
                      if (contact.email != null)
                        ActionButton(
                          icon: Icons.mail,
                          label: "Mail",
                          color: colorScheme.secondaryContainer,
                          onTap: () {
                            launchExternalAction(
                              scheme: 'mailto',
                              path: contact.email!,
                            );
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.md),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSizes.lg),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.borderRadiusXXXl),
                          topRight: Radius.circular(AppSizes.borderRadiusXXXl),
                        ),
                      ),
                      child: Column(
                        spacing: AppSizes.sm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Contact Info", style: textTheme.titleLarge),
                              IconButton(
                                onPressed: () {
                                  context.read<ContactBloc>().add(
                                    ToggleFavouriteEvent(contact),
                                  );
                                },
                                icon: Icon(
                                  contact.isFavourite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                spacing: AppSizes.sm,
                                children: [
                                  ContactInfoTile(
                                    icon: Icons.phone,
                                    title: "Phone",
                                    value: contact.phone,
                                    color: colorScheme.primary,
                                  ),

                                  ContactInfoTile(
                                    icon: Icons.email,
                                    title: "Email",
                                    value: contact.email?.isNotEmpty == true
                                        ? contact.email!
                                        : "No Email",
                                    color: colorScheme.tertiary,
                                  ),

                                  ContactInfoTile(
                                    icon: Icons.business,
                                    title: "Company",
                                    value: contact.company?.isNotEmpty == true
                                        ? contact.company!
                                        : "No Company",
                                    color: Colors.orange,
                                  ),

                                  ContactInfoTile(
                                    icon: Icons.notes,
                                    title: "Notes",
                                    value: contact.notes?.isNotEmpty == true
                                        ? contact.notes!
                                        : "No Notes",
                                    color: Colors.purple,
                                  ),

                                  SizedBox(
                                    width: double.maxFinite,
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: colorScheme.error,
                                        ),
                                        foregroundColor: colorScheme.error,
                                      ),
                                      onPressed: () {
                                        AppUtils.showAppAlertDialog(
                                          icon: Icons.delete_forever,
                                          iconColor: colorScheme.error,
                                          title: "Delete Contact?",
                                          message:
                                              "Are you sure you want to delete ${contact.name}?",
                                          context: context,
                                          buttonText1: "Delete",
                                          button1Color: colorScheme.error,
                                          buttonAction: () {
                                            context.read<ContactBloc>().add(
                                              DeleteContactEvent(contact.id!),
                                            );
                                            context.pop();
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.delete_forever),
                                      label: const Text("Delete Contact"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
