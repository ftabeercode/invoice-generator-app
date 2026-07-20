# 📄 Invoice Generator App

<p align="center">
  <b>A modern Flutter-based Invoice Management Application</b><br>
  Create, manage, export, and share professional invoices with ease.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter" />
  <img src="https://img.shields.io/badge/Dart-3.x-blue?logo=dart" />
  <img src="https://img.shields.io/badge/Platform-Android-green" />
  <img src="https://img.shields.io/badge/Database-Hive-orange" />
  <img src="https://img.shields.io/badge/Status-Completed-success" />
</p>

---

## 🌟 Project Overview

Invoice Generator App is a feature-rich Flutter application developed to simplify invoice management for businesses and individuals. The application allows users to create professional invoices, manage customer and company details, generate PDF invoices, and share them directly through various platforms.

This project demonstrates practical knowledge of:

* Flutter UI Development
* State Management
* Local Data Storage
* PDF Generation
* File Handling
* Mobile Application Design
* Material 3 Theming

---

## ✨ Features

### Invoice Management

* Create professional invoices
* Auto-generate invoice numbers
* Edit existing invoices
* Delete invoices
* Duplicate invoices
* Search invoices
* View invoice history

### Customer & Company Management

* Add company information
* Add customer information
* Upload company logo
* Manage contact details

### Invoice Details

* Add multiple products/services
* Quantity and unit price support
* Automatic subtotal calculation
* Tax calculation
* Discount support
* Grand total calculation

### PDF & Sharing

* Generate professional PDF invoices
* Download PDF invoices
* Share invoices via Email and WhatsApp
* Include company logo in PDFs

### Additional Features

* Dashboard with statistics
* Paid/Unpaid invoice tracking
* Overdue invoice detection
* Dark Mode support
* Responsive UI
* Local storage using Hive

---

## 🛠 Packages Used

| Package               | Purpose                       |
| --------------------- | ----------------------------- |
| hive                  | Local database                |
| hive_flutter          | Hive integration with Flutter |
| path_provider         | File path management          |
| pdf                   | PDF generation                |
| printing              | Printing PDF documents        |
| share_plus            | Sharing invoices              |
| image_picker          | Selecting company logos       |
| intl                  | Date formatting               |
| flutter/material.dart | UI development                |

---

## 📱 Application Screenshots

### Dashboard

![Dashboard](screenshots/dashboard1.png)
![Dashboard](screenshots/dashboard2.png)

### Create Invoice Screen

![Create Invoice](screenshots/create_invoice.png)
![Create Invoice](screenshots/create_invoice 2.png)

### Invoice List Screen

![Invoice List](screenshots/invoice screen.png)
![Invoice List](screenshots/invoice screen 2.png)


### Invoice Detail Screen

![Invoice Detail](screenshots/invoice_detail.png)

### Settings Screen

![Settings](screenshots/setting 1.png)
![Settings](screenshots/setting 2.png)

### Generated PDF

![PDF Preview](screenshots/pdf_preview.png)

> **Note:** Create a folder named `screenshots` in the root directory of your project and place all screenshot images inside it.

---

## 🚀 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/invoice-generator-app.git
```

### 2. Navigate to the Project

```bash
cd invoice-generator-app
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the Application

```bash
flutter run
```

### 5. Build APK (Release)

```bash
flutter build apk --release
```

The generated APK can be found at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📂 Project Structure

```text
lib/
├── models/
├── screens/
├── services/
├── widgets/
├── main.dart
```

---

## 🎯 Learning Outcomes

Through this project, I gained hands-on experience in:

* Flutter application development
* Designing modern user interfaces
* Implementing local storage with Hive
* Creating and exporting PDF documents
* Managing application state
* Building reusable widgets
* Working with file handling and sharing APIs

---

## 👩‍💻 Developer

**Tabeer Fatima**

* BS Computer Science Student
* NUML University, Lahore
* Flutter Developer
* Front-End & Mobile App Enthusiast

---

## 📌 Future Improvements

* Cloud synchronization
* Authentication system
* Multi-currency support
* Online invoice sharing
* Analytics dashboard
* Multi-language support

---

## 📜 License

This project is developed for educational and portfolio purposes.

---

<p align="center">
  <b>Thank you for visiting this repository! ⭐</b><br>
  If you found this project useful, consider giving it a star.
</p>
