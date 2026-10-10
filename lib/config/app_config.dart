/// All settings you may need to change live in this one file.
class AppConfig {
  /// >>> PUT THE REAL HOPSCOTCH HOMEPAGE API URL HERE <<<
  /// While it is still 'YOUR_HOPSCOTCH_API_URL', the app reads the JSON you
  /// pasted into assets/homepage_response.json instead.
  static const String homepageApiUrl = 'YOUR_HOPSCOTCH_API_URL';

  /// Extra headers for the GET request (add any the real API needs).
  static const Map<String, String> requestHeaders = {
    'Accept': 'application/json',
  };

  /// Local copy of the API response (used when the URL above is not set).
  static const String localJsonAsset = 'assets/homepage_response.json';

  /// Used to turn relative links such as "/girls" into full web URLs.
  static const String webBaseUrl = 'https://www.hopscotch.in';

  /// Maximum width of the page content on big desktop screens.
  static const double maxContentWidth = 1280;

  static bool get isApiUrlConfigured =>
      homepageApiUrl.isNotEmpty && homepageApiUrl != 'YOUR_HOPSCOTCH_API_URL';
}
