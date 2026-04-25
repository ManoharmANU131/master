import 'package:my_contacts_app/core/helpers/date_format_helper.dart';

class Contact {
  final int? id;
  final String name;
  final String phone;
  final String? email;
  final String? company;
  final String? notes;
  final bool isFavourite;

  final DateTime? createdOn;
  final DateTime? updatedOn;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    this.email,
    this.company,
    this.notes,
    this.isFavourite = false,
    this.createdOn,
    this.updatedOn,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['Id'],
      name: map['Name'],
      phone: map['Phone'],
      email: map['Email'],
      company: map['Company'],
      notes: map['Notes'],

      isFavourite: map['IsFavourite'] == 1 || map['IsFavourite'] == "1",

      createdOn: DateHelper.fromMillis(map['CreatedOn']),
      updatedOn: DateHelper.fromMillis(map['UpdatedOn']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Phone': phone,
      'Email': email,
      'Company': company,
      'Notes': notes,
      'IsFavourite': isFavourite ? 1 : 0,

      'CreatedOn': DateHelper.toMillis(createdOn) ?? DateHelper.nowMillis(),
      'UpdatedOn': DateHelper.toMillis(updatedOn) ?? DateHelper.nowMillis(),
    };
  }

  Contact copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? company,
    String? notes,
    bool? isFavourite,
    DateTime? createdOn,
    DateTime? updatedOn,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      company: company ?? this.company,
      notes: notes ?? this.notes,
      isFavourite: isFavourite ?? this.isFavourite,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }
}
