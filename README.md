# QRScanner

The QRScanner app allows users to scan QR codes and store relevant information. It features the following functionalities:

## Features:

1. Scan QR Code: Easily scan QR codes using your device’s camera.
2. Store Data: The app stores the user's name and URL associated with the scanned QR code to a Google Sheet for easy access and management.
3. Current Session Listing: The right tab displays the list of QR codes scanned during the current session, without including data from the Google Sheet.

## Prerequisites
Before getting started, ensure you have the following setup:

- Flutter Version: Flutter 3.24.3
- Dart Version: Dart 3.5.3
- A Google Cloud project.
- Google Sheets API enabled for your project.
- service account credentials in JSON format.
- Flutter development environment set up.
## Packages Used

This project uses the following packages:

- `google_fonts: ^6.2.1` - For custom fonts in the app.
- `cupertino_icons: ^1.0.2` - Provides Cupertino icons for iOS-style components.
- `equatable: ^2.0.7` - Simplifies the comparison of objects for equality.
- `flutter_bloc: ^9.0.0` - A predictable state management solution using the BLoC pattern.
- `bloc: ^9.0.0` - Core library for the BLoC pattern.
- `go_router: ^14.6.3` - A declarative router for Flutter to manage navigation.
- `water_drop_nav_bar: ^2.2.2` - A stylish water drop navigation bar for your app.
- `mobile_scanner: ^6.0.3` - A mobile QR code and barcode scanner.
- `pretty_qr_code: ^3.3.0` - Beautiful and customizable QR code generation.
- `toastification: ^2.3.0` - A lightweight package to show toast messages.
- `gsheets: ^0.5.0` - A Flutter library for working with Google Sheets.
- `dio: ^5.7.0` - A powerful HTTP client for Dart, supporting interceptors, global configuration, and more.
- `gap: ^3.0.1` - A package for creating gaps between widgets.
- `flutter_dotenv: ^5.0.2` - For managing environment variables in Flutter apps.
- `intl: ^0.18.0` - Provides internationalization and localization support.



## Project Setup
This Flutter project integrates with Google Sheets to read and write data. To enable Google Sheets access, you'll need a service account and credentials in JSON format. This guide will walk you through how to create a service account, configure your Google Sheets, and use the credentials in This Flutter project.


## Setup Instructions

1. Create .env File
  In the root of your Flutter project, create a .env file with the following content:
  ```
  SPREADSHEET_ID=your_spreadsheet_id_here
  GOOGLE_CREDENTIALS='your_google_credentials_json_here'
  QR_SHEET_TITLE=qrsheet
````
2. Add the Correct Values

- SPREADSHEET_ID: Replace your_spreadsheet_id_here with the actual ID of your Google Sheet. The spreadsheet ID is the long alphanumeric string in the Google Sheets URL (e.g., https://docs.google.com/spreadsheets/d/<SPREADSHEET_ID>/edit).

- GOOGLE_CREDENTIALS: Paste the entire JSON content of your service account credentials in the value of GOOGLE_CREDENTIALS. This is the JSON file you download from the Google Cloud Console after creating a service account.

- QR_SHEET_TITLE: Set the title of your Google Sheets worksheet where QR data is stored (default is qrsheet).

3. Run ``` flutter pub get   ``` to install all dependencies 



