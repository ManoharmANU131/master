import 'package:equatable/equatable.dart';
import 'package:my_contacts_app/models/contact.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}

class LoadContactsEvent extends ContactEvent {}

class AddContactEvent extends ContactEvent {
  final Contact contact;

  const AddContactEvent(this.contact);

  @override
  List<Object?> get props => [contact];
}

class UpdateContactEvent extends ContactEvent {
  final Contact contact;

  const UpdateContactEvent(this.contact);

  @override
  List<Object?> get props => [contact];
}

class DeleteContactEvent extends ContactEvent {
  final int id;

  const DeleteContactEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleFavouriteEvent extends ContactEvent {
  final Contact contact;

  const ToggleFavouriteEvent(this.contact);

  @override
  List<Object?> get props => [contact];
}

class GetContactByIdEvent extends ContactEvent {
  final int id;

  const GetContactByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchContactEvent extends ContactEvent {
  final String query;

  const SearchContactEvent(this.query);

  @override
  List<Object?> get props => [query];
}
