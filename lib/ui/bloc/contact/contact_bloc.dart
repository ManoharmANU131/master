import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/data/repositories/contact_repository.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_event.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;

  ContactBloc(this.repository) : super(const ContactState()) {
    on<LoadContactsEvent>(_onLoadContacts);
    on<AddContactEvent>(_onAddContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<DeleteContactEvent>(_onDeleteContact);
    on<ToggleFavouriteEvent>(_onToggleFavourite);
    on<GetContactByIdEvent>(_onGetById);
    on<SearchContactEvent>(_onSearchContact);
  }

  Future<void> _onLoadContacts(
    LoadContactsEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      final contacts = await repository.getAllContacts();

      emit(state.copyWith(contacts: contacts, filteredContacts: contacts));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onAddContact(
    AddContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await repository.addContact(event.contact);

      final contacts = await repository.getAllContacts();

      emit(
        state.copyWith(
          isLoading: false,
          contacts: contacts,
          filteredContacts: contacts,
          successMessage: "Contact added successfully",
        ),
      );
    } catch (e) {
      developer.log("Add Error:", error: e.toString());

      emit(
        state.copyWith(isLoading: false, errorMessage: "Failed to add contact"),
      );
    }
  }

  Future<void> _onUpdateContact(
    UpdateContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await repository.updateContact(event.contact);

      final contacts = await repository.getAllContacts();

      final updatedContact = await repository.getContactById(event.contact.id!);

      emit(
        state.copyWith(
          isLoading: false,
          contacts: contacts,
          selectedContact: updatedContact,
          filteredContacts: contacts,
          successMessage: "Contact updated successfully",
        ),
      );
    } catch (e) {
      developer.log("Update Error:", error: e.toString());

      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Failed to update contact",
        ),
      );
    }
  }

  Future<void> _onDeleteContact(
    DeleteContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await repository.deleteContact(event.id);

      final contacts = await repository.getAllContacts();

      emit(
        state.copyWith(
          isLoading: false,
          contacts: contacts,
          selectedContact: null,
          successMessage: "Contact deleted successfully",
        ),
      );
    } catch (e) {
      developer.log("Delete Error:", error: e.toString());

      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Failed to delete contact",
        ),
      );
    }
  }

  Future<void> _onToggleFavourite(
    ToggleFavouriteEvent event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await repository.toggleFavourite(event.contact);

      final updatedContact = await repository.getContactById(event.contact.id!);

      if (updatedContact == null) return;

      final updatedContacts = state.contacts.map((c) {
        return c.id == updatedContact.id ? updatedContact : c;
      }).toList();

      final updatedFiltered = state.filteredContacts.map((c) {
        return c.id == updatedContact.id ? updatedContact : c;
      }).toList();

      emit(
        state.copyWith(
          contacts: updatedContacts,
          filteredContacts: updatedFiltered,
          selectedContact: state.selectedContact?.id == updatedContact.id
              ? updatedContact
              : state.selectedContact,
          successMessage: "Updated",
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onGetById(
    GetContactByIdEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final contact = await repository.getContactById(event.id);

      emit(state.copyWith(isLoading: false, selectedContact: contact));
    } catch (e) {
      developer.log("Get By Id Error:", error: e.toString());

      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _onSearchContact(SearchContactEvent event, Emitter<ContactState> emit) {
    final query = event.query.toLowerCase();

    final filtered = state.contacts.where((contact) {
      return contact.name.toLowerCase().contains(query) ||
          contact.phone.contains(query) ||
          (contact.email?.toLowerCase().contains(query) ?? false);
    }).toList();

    emit(state.copyWith(searchQuery: event.query, filteredContacts: filtered));
  }
}
