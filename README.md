Contacts App (Flutter)

A simple Contacts application built using Flutter and SQLite.
The app is inspired by Google Contacts and supports contact management with a clean Material 3 UI.

Features
View all contacts
Add new contacts
Edit existing contacts
Delete contacts with confirmation dialog
Mark / unmark favorite contacts
Separate Favorites screen
Search contacts by:
Name
Phone number
Email
View detailed contact profile
Call contact directly
Send SMS
Send Email
Empty state handling
Loading and error handling
Responsive UI
Tech Stack
Flutter
Dart
SQLite
flutter_bloc (State Management)
go_router (Navigation)
equatable
url_launcher
Material 3 UI
Architecture

The project follows clean layered architecture.

lib/
│
├── app/
│   └── router/
│
├── core/
│   ├── helpers/
│   ├── theme/
│   └── utils/
│
├── data/
│   ├── database/
│   └── repositories/
│
├── models/
│
├── ui/
│   ├── bloc/
│   ├── layouts/
│   ├── screens/
│   └── widgets/
│
└── main.dart
State Management

The application uses BLoC for state management.

Events
LoadContactsEvent
AddContactEvent
UpdateContactEvent
DeleteContactEvent
ToggleFavouriteEvent
GetContactByIdEvent
SearchContactEvent
State

The ContactState manages:

Contact list
Filtered contacts
Selected contact
Loading state
Success messages
Error messages
Search query
Database

SQLite is used for offline data storage.

Contact Table
CREATE TABLE Contact(
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT NOT NULL,
  Phone TEXT NOT NULL,
  Email TEXT,
  Company TEXT,
  Notes TEXT,
  IsFavourite INTEGER NOT NULL DEFAULT 0
)
Main Screens
Home Screen

Contains bottom navigation with:

Contacts
Favorites
Contact Screen

Displays all contacts with search functionality.

Favorite Screen

Displays only favorite contacts.

Contact Details Screen

Displays:

Contact avatar
Phone
Email
Company
Notes
Call button
Message button
Mail button
Packages Used
dependencies:
  flutter_bloc:
  go_router:
  equatable:
  sqflite:
  path:
  url_launcher:
