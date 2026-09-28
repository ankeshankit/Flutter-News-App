# 📰 Flutter News App

A simple and modern **News App built with Flutter** that fetches the latest news from the **NewsData.io API**.

Users can browse the latest news, view images, read descriptions, and open the complete article from the original news website.

## ✨ Features

* 📰 Latest News
* 🌐 NewsData.io REST API integration
* 🔄 Pull to refresh
* ♾️ Pagination / Load More News
* 🖼️ News images
* 📄 News details screen
* 🔗 Open full article in browser
* 📅 Published date
* ⚡ FutureBuilder for API data
* 🚨 Error handling
* 📱 Responsive Flutter UI

## 🛠️ Technologies Used

* Flutter
* Dart
* REST API
* HTTP Package
* NewsData.io API
* JSON Parsing
* FutureBuilder
* StatefulWidget
* Navigator
* Material Design

## 📂 Project Structure

```text
lib/
│
├── main.dart
│
├── news_app.dart
│
├── newsmodel.dart
│
└── detail_screen.dart
```

## 🔌 API Integration

This project uses the **NewsData.io API** to fetch the latest news.

API endpoint:

```text
https://newsdata.io/api/1/latest
```

The API response contains information such as:

* News title
* Description
* Image
* Published date
* Source
* Article URL

## 🔑 API Key Setup

Get your API key from NewsData.io and add it to your API request.

Example:

```dart
final url =
    "https://newsdata.io/api/1/latest?apikey=YOUR_API_KEY";
```

Replace:

with your actual API key.


## ♾️ Pagination

NewsData.io can return a limited number of news articles per request.

The API provides a `nextPage` value that can be used to request the next set of news.

Example:

```dart
final url =
    "https://newsdata.io/api/1/latest?apikey=YOUR_API_KEY&page=$nextPage";
```

The app can use this value to implement infinite scrolling and load additional news when the user reaches the bottom of the list.

## 📱 App Flow

```text
Open App
   ↓
Fetch Latest News
   ↓
News List
   ↓
Click News
   ↓
News Details
   ↓
Read Full Article
   ↓
Open Original Website
```

## 📦 Required Package

Add the HTTP package to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.6.0
  url_launcher: ^6.3.0
  shared_preferences: ^2.2.3
dev_dependencies:
  flutter_test:
    sdk: flutter
```

Then run:

```bash
flutter pub get
```

## 🚀 How to Run

Clone the repository:

```bash
git clone https://github.com/ankeshankit/Flutter-News-App
```

Go to the project directory:

```bash
cd your-project-name
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## 🎯 Future Improvements

* 🔍 Search News
* 🗂️ News Categories
* 🌍 Country-wise News
* ⭐ Bookmark News
* 🌙 Dark Mode
* 🔔 News Notifications
* ♾️ Improved Infinite Scrolling
* 📡 Better Offline Support

## 👨‍💻 Developer

**Ankit Kumar**

Flutter Developer | Dart | Android & iOS Development

## 📄 License

This project is created for learning and development purposes.
