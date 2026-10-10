# Hopscotch Homepage – Flutter Web

A responsive e-commerce homepage built using Flutter Web and Dart, inspired by [Hopscotch](https://www.hopscotch.in/). The project uses homepage API data to display different promotional banners, shopping categories, and product collections in a web browser.

## Project Overview

The objective of this project is to consume a homepage API response and use its data to build 5–10 reusable widgets similar to the sections displayed on the Hopscotch website.

The application dynamically renders nine homepage sections along with a navigation header. Section content, images, and tile properties are populated from the API response or a local JSON fallback.

## Features

- Responsive homepage layout for web browsers.
- Nine dynamically rendered homepage sections.
- Header and navigation layout.
- Promotional banners and shopping collections.
- Flash sale and coupon sections.
- Category-based shopping sections.
- Reusable widgets for displaying image tiles and grids.
- Dynamic image dimensions based on API data.
- Clickable tiles that open relevant web pages.
- Loading and error states during data retrieval.
- Local JSON fallback when the API is unavailable.
- Responsive grid layouts for different screen widths.

## Technologies Used

- **Flutter Web** – Web user interface.
- **Dart** – Application logic and data handling.
- **HTTP** – API requests.
- **URL Launcher** – Opening external web pages.
- **JSON** – Homepage response data.
- **FutureBuilder** – Handling asynchronous data loading.
- **StatefulWidget** – Managing widget state.

## Project Structure

```text
lib/
├── main.dart
├── config/
│   └── app_config.dart
├── models/
│   ├── json_utils.dart
│   ├── tile.dart
│   ├── tile_detail.dart
│   ├── page_component.dart
│   └── homepage_response.dart
├── services/
│   └── api_service.dart
├── utils/
│   └── url_helper.dart
├── screens/
│   └── home_screen.dart
└── widgets/
    ├── header.dart
    ├── hero_banner.dart
    ├── flash_sale.dart
    ├── shop_by_occasion.dart
    ├── trends_section.dart
    ├── coupon_corner.dart
    ├── category_section.dart
    ├── steals_section.dart
    ├── shop_for_all.dart
    ├── image_tile.dart
    ├── tile_grid.dart
    ├── section_title.dart
    ├── loading_view.dart
    └── error_view.dart

assets/
└── homepage_response.json
```

## Getting Started

### Prerequisites

Install the following tools before running the project:

- Flutter SDK
- Dart SDK (included with Flutter)
- Google Chrome
- Visual Studio Code or another code editor

Verify your Flutter installation:

```bash
flutter --version
flutter doctor
```

### Installation

1. Clone the repository or download the project files.
2. Open a terminal in the project directory.
3. Install the required dependencies:

```bash
flutter pub get
```

### Configure the Homepage Data

Open:

```text
lib/config/app_config.dart
```

Configure the homepage API endpoint:

```dart
static const String homepageApiUrl = 'YOUR_HOPSCOTCH_API_URL';
```

Replace the placeholder with the actual API endpoint if it is available.

Alternatively, use the provided API response as a local JSON file:

```text
assets/homepage_response.json
```

Ensure that the JSON file is declared in `pubspec.yaml` and that the application is configured to use the local response when required.

**Note:** A local JSON fallback is useful when the API is unavailable or browser CORS restrictions prevent direct requests.

### Run the Application

To launch the homepage in Google Chrome:

```bash
flutter run -d chrome
```

The application will open in a browser window.

## How It Works

The application follows this data flow:

```text
Homepage API / Local JSON
          ↓
     API Service
          ↓
      JSON Decode
          ↓
     Dart Data Models
          ↓
    Homepage Sections
          ↓
    Responsive Web UI
```

1. **Data retrieval:** `ApiService` retrieves the homepage response through an HTTP GET request or loads the configured local JSON fallback.
2. **JSON parsing:** The response is decoded into Dart maps and lists.
3. **Model creation:** The data models represent homepage components, tiles, image dimensions, and navigation actions.
4. **Section rendering:** `HomeScreen` identifies the homepage sections and builds the corresponding widgets.
5. **Responsive display:** Reusable grids and image tiles arrange the content according to the available screen width.
6. **Navigation:** Tiles with supported web URLs can be clicked to open their corresponding pages.

## Homepage Sections

The application supports the following sections, depending on the supplied homepage response:

1. Hero Banner
2. Flash Sale
3. Shop by Occasion
4. Trends
5. Coupon Corner
6. Girls' Category
7. Boys' Category
8. Steals
9. Shop for All

Each section uses the corresponding component data to display images and other available tile properties.

## Responsive Design

The homepage adjusts its grid layout based on the available width:

- **Large screens:** Up to four columns.
- **Medium screens:** Three columns.
- **Small screens:** Two columns.

Image dimensions and section spacing are determined by the available API properties where applicable.

## Build for Production

To generate the production web build:

```bash
flutter build web
```

The generated files will be available in:

```text
build/web/
```

These files can be deployed to a static hosting platform that supports Flutter Web.

## Troubleshooting

**API request fails**

- Verify that the API endpoint is correct and accessible.
- Check the browser developer console for network or CORS errors.
- Use `assets/homepage_response.json` as a fallback when configured.

**Images are not displayed**

- Verify that the image URLs in the response are valid.
- Check network requests and browser console errors.
- Confirm that the image host allows browser access.

**Dependencies are missing**

Run:

```bash
flutter pub get
```

**Application does not start**

Run:

```bash
flutter doctor
flutter run -d chrome
```

## Learning Outcomes

This project demonstrates practical use of Flutter Web, Dart models, JSON parsing, asynchronous API integration, reusable widgets, responsive layouts, and navigation to external web pages.

## Assignment Objective

To consume a homepage API response and build a responsive web homepage containing 5–10 reusable widgets inspired by the Hopscotch e-commerce website.

---

**Project:** Hopscotch Homepage – Flutter Web  
**Platform:** Web Browser  
**Framework:** Flutter  
**Language:** Dart