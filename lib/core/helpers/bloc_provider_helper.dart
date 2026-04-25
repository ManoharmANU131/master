import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_contacts_app/data/repositories/contact_repository.dart';
import 'package:my_contacts_app/ui/bloc/contact/contact_bloc.dart';

class BlocProviderHelper {
  static Widget getAllProvider({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ContactBloc(ContactRepository())),
      ],
      child: child,
    );
  }
}
