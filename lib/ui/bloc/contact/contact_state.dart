import 'package:equatable/equatable.dart';
import 'package:my_contacts_app/models/contact.dart';

class ContactState extends Equatable {
  final List<Contact> contacts;
  final List<Contact> filteredContacts;
  final Contact? selectedContact;
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;
  final String searchQuery;

  const ContactState({
    this.contacts = const [],
    this.filteredContacts = const [],
    this.selectedContact,
    this.isLoading = false,
    this.successMessage,
    this.errorMessage,
    this.searchQuery = '',
  });

  ContactState copyWith({
    List<Contact>? contacts,
    List<Contact>? filteredContacts,
    Contact? selectedContact,
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
    String? searchQuery,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      selectedContact: selectedContact ?? this.selectedContact,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    contacts,
    selectedContact,
    filteredContacts,
    isLoading,
    successMessage,
    errorMessage,
    searchQuery,
  ];
}
