import 'package:pokodek/core/injection/env.dart';
import 'package:pokodek/main.dart';

/// @author Diky Nugraha Difiera
/// @email dikynugraha1111@gmail.com
/// @create date 2024-03-24 13:07:11
/// @modify date 2024-03-24 13:07:11

class Injection {
  static const String fontFamily = 'Inter';
  // static final AppSharedPrefKey sharedPrefKey = AppSharedPrefKey();
  // static final HttpClient httpClient = AppHttpClient.create();
  // static final HeaderProvider headerProvider = AppHeaderProvider.create();
  static final String baseURL = env.baseURL;
  static final bool isDevelopment = env.isDevelopMode;
}
