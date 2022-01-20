class MixedConstants {
  // static const String WEBSITE_URL = 'https://staging.atsign.wtf/';
  static const String WEBSITE_URL = 'https://atsign.com/';

  // for local server
  // static const String ROOT_DOMAIN = 'vip.ve.atsign.zone';

  // for staging server
  // static const String ROOT_DOMAIN = 'root.atsign.wtf';
  // for production server
  static const String ROOT_DOMAIN = 'root.atsign.org';

  static const int ROOT_PORT = 64;

  static const String TERMS_CONDITIONS = 'https://atsign.com/terms-conditions/';

  static const String FILEBIN_URL = 'https://filebin2.aws.atsign.cloud/';
  // static const String PRIVACY_POLICY = 'https://atsign.com/privacy-policy/';
  static const String PRIVACY_POLICY =
      "https://atsign.com/apps/atmosphere/atmosphere-privacy/";

  // the time to await for file transfer acknowledgement in milliseconds
  static const int TIME_OUT = 60000;

  // Hive Constants
  static const String HISTORY_KEY = 'historyKey';
  static const String HISTORY_BOX = 'historyBox';

  static String appNamespace = 'mospherepro';
  static String regex =
      '(.$appNamespace|atconnections|[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12})';

  static const String AUTO_ACCEPT_TOGGLE_BOX = 'autoAcceptBox';
  static const String AUTO_ACCEPT_TOGGLE_KEY = 'autoAcceptKey';
  static const String FILE_TRANSFER_KEY = 'file_transfer_';
  static const String FILE_TRANSFER_ACKNOWLEDGEMENT = 'file_download_ack_';
  static const String RECEIVED_FILE_HISTORY = 'receivedHistory_v2';
  static const String SENT_FILE_HISTORY = 'sentHistory_v2';

  /// Currently set to 60 days
  static const int FILE_TRANSFER_TTL = 60000 * 60 * 24 * 60;

  /// Sibebar width
  static double SIDEBAR_WIDTH = 70;

  /// Appbar height
  static const double APPBAR_HEIGHT = 80;

  static String ApplicationDocumentsDirectory;

  static String get RECEIVED_FILE_DIRECTORY => '$ApplicationDocumentsDirectory';

  // temp
  // static String path = '/Users/apple/Desktop/';
  // static String path = '/Users/apple/temp_atmosphere/';

  static String DESKTOP_SENT_DIR =
      '$ApplicationDocumentsDirectory' + '/sent-files/';

  static String get SENT_FILE_DIRECTORY =>
      '$ApplicationDocumentsDirectory' + '/sent-files/';

  // Onboarding API key - requires different key for production
  static String ONBOARD_API_KEY = '477b-876u-bcez-c42z-6a3d';
}
