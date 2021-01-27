import 'package:atsign_atmosphere_pro/routes/route_names.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/provider_callback.dart';
import 'package:atsign_atmosphere_pro/screens/faqs/faqs.dart';
import 'package:atsign_atmosphere_pro/screens/file_picker/file_picker.dart';
import 'package:atsign_atmosphere_pro/screens/group_contacts_screen/group_contact_screen.dart';
import 'package:atsign_atmosphere_pro/screens/history/history_screen.dart';
import 'package:atsign_atmosphere_pro/screens/home/home.dart';
import 'package:atsign_atmosphere_pro/screens/my_files/my_files.dart';
import 'package:atsign_atmosphere_pro/screens/private_key_qrcode_generator.dart';
import 'package:atsign_atmosphere_pro/screens/scan_qr/scan_qr.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/website_webview.dart';
import 'package:atsign_atmosphere_pro/screens/terms_conditions/terms_conditions_screen.dart';
import 'package:atsign_atmosphere_pro/screens/trusted_contacts/trusted_contacts.dart';
import 'package:atsign_atmosphere_pro/screens/welcome_screen/welcome_screen.dart';
import 'package:atsign_atmosphere_pro/view_models/history_provider.dart';
import 'package:at_contacts_flutter/screens/blocked_screen.dart';
import 'package:at_contacts_flutter/screens/contacts_screen.dart';
import 'package:flutter/material.dart';

class SetupRoutes {
  static String initialRoute = Routes.HOME;

  static Map<String, WidgetBuilder> get routes {
    return {
      Routes.HOME: (context) => Home(),
      Routes.WEBSITE_SCREEN: (context) {
        Map<String, String> args =
            ModalRoute.of(context).settings.arguments as Map<String, String>;
        return WebsiteScreen(title: args["title"], url: args["url"]);
      },
      Routes.WELCOME_SCREEN: (context) => WelcomeScreen(),
      Routes.FAQ_SCREEN: (context) => FaqsScreen(),
      // Routes.TERMS_CONDITIONS: (context) => TermsConditions(),
      Routes.HISTORY: (context) {
        return MyFiles();
      },
      // Routes.HISTORY: (context) => HistoryScreen(),
      Routes.BLOCKED_USERS: (context) => BlockedScreen(),
      Routes.CONTACT_SCREEN: (context) {
        Map<String, dynamic> args =
            ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        return ContactsScreen(
          selectedList: args['selectedList'],
          context: args['context'],
          asSelectionScreen: args['asSelectionScreen'],
        );
      },
      Routes.FILE_PICKER: (context) => FilePickerScreen(),
      Routes.SCAN_QR_SCREEN: (context) => ScanQrScreen(),
      Routes.GROUP_CONTACT_SCREEN: (context) => GroupContactScreen(),
      Routes.PRIVATE_KEY_GEN_SCREEN: (context) => PrivateKeyQRCodeGenScreen(),
      Routes.EMPTY_TRUSTED_CONTACTS: (context) => TrustedContacts(),
      Routes.TRUSTED_SENDER: (context) {
        Map<String, bool> args =
            ModalRoute.of(context).settings.arguments as Map<String, bool>;
        return GroupContactScreen(
          isTrustedScreen: args['isTrustedSender'],
        );
      }
    };
  }
}
