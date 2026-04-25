<<<<<<< HEAD
# master
=======
Contacts App (Flutter)

A modern contact management application built with Flutter using Material 3 design and SQLite local database.

Features
Add, edit, and delete contacts
View contact details
Mark/unmark favorite contacts
Separate Favorites screen
Search contacts instantly
Direct Call, SMS, and Email actions
Responsive UI for different screen sizes
Loading, empty, and error state handling
Tech Stack
Flutter
Dart
SQLite
flutter_bloc
go_router
url_launcher
Material 3
Architecture

The application follows clean architecture with separate layers for:

UI
BLoC State Management
Repository
Database
Main Modules
Contacts Screen

Displays all saved contacts with search support.

Favorites Screen

Shows favorite contacts separately.

Contact Details Screen

Displays complete contact information with quick action buttons.

Database

SQLite is used for offline contact storage.

Contact Fields
Name
Phone Number
Email
Company
Notes
Favorite Status
State Management

BLoC pattern is used for:

Loading contacts
Adding contacts
Updating contacts
Deleting contacts
Searching contacts
Managing favorites
Packages Used
flutter_bloc
go_router
sqflite
equatable
url_launcher
Installation
flutter pub get
flutter run
Build APK
flutter build apk --release
Highlights
Material 3 UI
Responsive design
Clean navigation
Reusable widgets
Offline data management
Smooth user experience
Future Enhancements
Firebase Sync
Contact Images
Dark Mode
Backup & Restore
Contact Sharing
>>>>>>> aa869e7 (Initial commit)
