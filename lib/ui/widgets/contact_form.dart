import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_contacts_app/core/theme/app_sizes.dart';
import 'package:my_contacts_app/ui/validations/validators.dart';
import 'package:my_contacts_app/ui/widgets/contact_dialog.dart';

class ContactForm extends StatefulWidget {
  final String title;
  final String buttonText;

  final bool isLoading;

  final String? initialName;
  final String? initialPhone;
  final String? initialEmail;
  final String? initialCompany;
  final String? initialNotes;

  final Function(
    String name,
    String phone,
    String email,
    String company,
    String notes,
  )
  onSubmit;

  const ContactForm({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onSubmit,
    required this.isLoading,
    this.initialName,
    this.initialPhone,
    this.initialEmail,
    this.initialCompany,
    this.initialNotes,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final formKey = GlobalKey<FormState>();
  bool isEmailTouched = false;
  bool isSaveButtonClicked = false;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController companyController;
  late final TextEditingController notesController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.initialName ?? '');

    phoneController = TextEditingController(text: widget.initialPhone ?? '');

    emailController = TextEditingController(text: widget.initialEmail ?? '');

    companyController = TextEditingController(
      text: widget.initialCompany ?? '',
    );

    notesController = TextEditingController(text: widget.initialNotes ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    companyController.dispose();
    notesController.dispose();

    super.dispose();
  }

  void submit() {
    setState(() {
      isSaveButtonClicked = true;
    });
    if (formKey.currentState!.validate()) {
      widget.onSubmit(
        nameController.text.trim(),
        phoneController.text.trim(),
        emailController.text.trim(),
        companyController.text.trim(),
        notesController.text.trim(),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.isLoading,

      child: Opacity(
        opacity: widget.isLoading ? 0.7 : 1,
        child: Form(
          key: formKey,
          child: ContactDialog(
            title: widget.title,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text.rich(
                    TextSpan(
                      text: "Name",
                      children: [
                        TextSpan(
                          text: "*",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) {
                  if (isSaveButtonClicked) {
                    formKey.currentState!.validate();
                  }
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name field is required";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  if (isSaveButtonClicked &&
                      value.isNotEmpty &&
                      (nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty)) {
                    formKey.currentState!.validate();
                  }
                },
                decoration: const InputDecoration(
                  label: Text.rich(
                    TextSpan(
                      text: "Phone Number",
                      children: [
                        TextSpan(
                          text: "*",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  prefixIcon: Icon(Icons.phone),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Phone Number field is required";
                  }
                  if (!Validators.isValidPhone(value.trim())) {
                    return "Enter a valid phone number";
                  }

                  return null;
                },
                textInputAction: TextInputAction.next,
              ),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                onChanged: (value) {
                  if (!isEmailTouched) {
                    setState(() {
                      isEmailTouched = true;
                    });
                  }

                  if (isSaveButtonClicked && isEmailTouched) {
                    setState(() {});
                  }
                },
                validator: (value) {
                  if (!isSaveButtonClicked || !isEmailTouched) {
                    return null;
                  }

                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }

                  if (!Validators.isValidEmail(value.trim())) {
                    return "Please enter a valid email";
                  }

                  return null;
                },
                textInputAction: TextInputAction.next,
              ),

              TextFormField(
                controller: companyController,
                decoration: const InputDecoration(
                  labelText: "Company",
                  prefixIcon: Icon(Icons.apartment),
                ),
                textInputAction: TextInputAction.next,
              ),

              TextFormField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  prefixIcon: Icon(Icons.edit_note),
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                  submit();
                },
              ),

              FilledButton(
                onPressed: widget.isLoading ? null : submit,

                child: widget.isLoading
                    ? const SizedBox(
                        height: AppSizes.lg,
                        width: AppSizes.lg,

                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(widget.buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
