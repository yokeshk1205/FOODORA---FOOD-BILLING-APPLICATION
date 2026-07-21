# Foodora – Smart Food Ordering & Billing System

## Introduction

Foodora is a smart food ordering and billing application developed for college canteens and mess systems. The application helps students and staff order food digitally without waiting in long queues. It provides an easy interface for browsing food items, placing orders, making payments, and generating QR-code-based bills.

The system also includes an admin panel for managing food items, updating stock quantities, and controlling canteen operations efficiently.

---

# Objectives

* To digitize the traditional canteen ordering system
* To reduce waiting time during food ordering
* To provide secure online payment support
* To simplify food stock management
* To improve user convenience and billing efficiency

---

# Features

## User Features

* Browse food items
* Search food quickly
* Select food categories
* Add/remove items from cart
* View total bill instantly
* Online payment integration
* QR code bill generation
* Simple and responsive UI

## Admin Features

* Add new canteens
* Add food items
* Update menu details
* Manage available stock
* Modify food prices
* Control food availability

---

# Technologies Used

| Technology                                                     | Purpose                 |
| -------------------------------------------------------------- | ----------------------- |
| Flutter                                                        | Mobile App Development  |
| Dart                                                           | Programming Language    |
| [Firebase](https://firebase.google.com?utm_source=chatgpt.com) | Backend & Database      |
| [Razorpay](https://razorpay.com?utm_source=chatgpt.com)        | Payment Gateway         |
| Android Studio                                                 | Development Environment |

---

# Software Requirements

* Flutter SDK
* Dart SDK
* Android Studio
* Firebase Account
* Internet Connection

---

# Hardware Requirements

* Android Mobile Device
* Minimum 4GB RAM
* Internet Connectivity

---

# Project Structure

```plaintext id="m12kz0"
foodora/
│
├── lib/
│   │
│   ├── pages/
│   │   ├── admin.dart
│   │   ├── checkOut.dart
│   │   ├── food.dart
│   │   ├── home.dart
│   │   ├── payment.dart
│   │   └── selection.dart
│   │
│   ├── firebase_options.dart
│   └── main.dart
│
├── android/
├── ios/
├── web/
├── linux/
├── pubspec.yaml
└── README.md
```

---

# File Descriptions

## main.dart

The entry point of the application. Initializes Firebase and launches the Foodora app.

### Responsibilities

* Firebase initialization
* App theme setup
* Routing and navigation
* Launching the home page

---

## firebase_options.dart

Stores Firebase configuration details required to connect the Flutter app with Firebase services.

### Responsibilities

* Firebase project configuration
* Platform-specific Firebase setup

---

# Pages Folder

## home.dart

The main landing page of the application.

### Features

* Displays available food places
* Navigation to food menu
* User-friendly interface

---

## food.dart

Displays food items available in selected canteens.

### Features

* Food images
* Price display
* Quantity display
* Add/remove item buttons

---

## selection.dart

Handles food selection and category filtering.

### Features

* Search bar
* Category filter widgets
* Food item management
* Dynamic filtering

---

## checkOut.dart

Displays selected items and billing details.

### Features

* Cart summary
* Quantity modification
* Total bill calculation
* Proceed to payment option

---

## payment.dart

Handles online transactions securely.

### Features

* Razorpay integration
* Payment verification
* QR bill generation
* Payment confirmation

---

## admin.dart

Admin dashboard for managing the application.

### Features

* Add new food places
* Add/update food items
* Stock management
* Menu management

---

# System Workflow

## Step 1 – User Opens Application

The user launches the Foodora app.

## Step 2 – Select Food Place

The home page displays available canteens or food places.

## Step 3 – Browse Food Items

Users can browse food items, search items, and filter categories.

## Step 4 – Add Items to Cart

Users select food items and add them to the cart.

## Step 5 – Checkout

The checkout page displays selected items and total amount.

## Step 6 – Payment

Users complete payment through Razorpay.

## Step 7 – QR Bill Generation

After successful payment, a QR-based digital bill is generated.

---

# Advantages

* Faster food ordering process
* Reduced waiting time
* Digital and secure payments
* Efficient stock management
* Easy menu updates
* User-friendly interface
* Reduced manual billing errors

---

# Limitations

* Requires internet connection
* Depends on Firebase services
* Android-focused implementation

---

# Future Enhancements

* Real-time order tracking
* Push notifications
* AI food recommendations
* Multi-language support
* Table reservation system
* Delivery support
* User profile management
* Order history tracking

---

# Firebase Services Used

## Firebase Authentication

Used for user login and authentication.

## Cloud Firestore

Used to store:

* Food items
* Orders
* User details
* Canteen information

## Firebase Storage

Used for storing food images.

---

# Payment Integration

The application uses:

* [Razorpay](https://razorpay.com?utm_source=chatgpt.com)

### Payment Features

* Secure payment processing
* Online transactions
* Instant payment confirmation

---

# Installation Steps

## Clone Repository

```bash id="u6x8yt"
git clone https://github.com/yokeshk1205/FOODORA---FOOD-BILLING-APPLICATION
```

## Open Project

```bash id="ujt87m"
cd foodora
```

## Install Dependencies

```bash id="j1m9c3"
flutter pub get
```

## Run Application

```bash id="t4k8ps"
flutter run
```

---

# Output Screens

* Home Page
* Food Selection Page
* Checkout Page
* Payment Page
* Admin Dashboard

---

# Conclusion

Foodora is an efficient smart food ordering and billing application designed to modernize traditional canteen systems. The app simplifies ordering, billing, payment processing, and stock management through a digital platform. By integrating Firebase and Razorpay, the system provides secure and reliable services for both users and administrators.

---

# Contributors

* Foodora Development Team

---

# License

This project is developed for educational and academic purposes only.

---

# Abstract

Foodora is a smart food billing and ordering system developed using Flutter and Firebase technologies. The application enables users to browse food items, place orders, make online payments, and receive QR-based digital bills. It also includes an admin panel for managing food items, stock, and menu updates. The system reduces manual work, improves billing efficiency, and enhances user convenience in college canteens and mess environments.
