import 'package:at_contact/at_contact.dart';
import 'package:at_contacts_flutter/utils/init_contacts_service.dart';
import 'package:at_contacts_group_flutter/services/group_service.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/Custom_heading.dart';
import 'package:atsign_atmosphere_pro/utils/constants.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/app_bar.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/common_button.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/side_bar.dart';
import 'package:atsign_atmosphere_pro/screens/welcome_screen/widgets/overlapping_contacts.dart';
import 'package:atsign_atmosphere_pro/screens/welcome_screen/widgets/select_file_widget.dart';
import 'package:atsign_atmosphere_pro/services/backend_service.dart';
import 'package:atsign_atmosphere_pro/services/size_config.dart';
import 'package:atsign_atmosphere_pro/utils/colors.dart';
import 'package:atsign_atmosphere_pro/utils/images.dart';
import 'package:atsign_atmosphere_pro/utils/text_strings.dart';
import 'package:atsign_atmosphere_pro/view_models/file_transfer_provider.dart';
import 'package:atsign_atmosphere_pro/view_models/history_provider.dart';
import 'package:atsign_atmosphere_pro/view_models/welcome_screen_view_model.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/size_config.dart';
// import '../../view_models/file_picker_provider.dart';
import '../common_widgets/side_bar.dart';
import '../../view_models/file_transfer_provider.dart';
import 'widgets/select_contact_widget.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isContactSelected;
  bool isFileSelected;
  // ContactProvider contactProvider;
  WelcomeScreenProvider _welcomeScreenProvider;
  Flushbar sendingFlushbar;
  BackendService backendService = BackendService.getInstance();
  HistoryProvider historyProvider;
  List<AtContact> selectedList = [];
  bool isExpanded = true;
  // FilePickerProvider _filePickerProvider;
  // 0-Sending, 1-Success, 2-Error
  List<Widget> transferStatus = [
    SizedBox(),
    Icon(
      Icons.check_circle,
      size: 13.toFont,
      color: ColorConstants.successColor,
    ),
    Icon(
      Icons.cancel,
      size: 13.toFont,
      color: ColorConstants.redText,
    )
  ];
  List<String> transferMessages = [
    'Sending file ...',
    'Sent the file',
    'Oops! something went wrong'
  ];
  String currentAtSign;
  @override
  void initState() {
    isContactSelected = false;
    isFileSelected = false;
    // backendService.onboard();
    setAtSign();
    _welcomeScreenProvider = WelcomeScreenProvider();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initializeContactsService(
          BackendService.getInstance().atClientInstance,
          BackendService.getInstance().currentAtSign);
    });
    super.initState();
  }

  setAtSign() async {
    currentAtSign = await backendService.getAtSign();
    await getAtSignAndInitializeContacts();
    await initGroups();
    setState(() {});
  }

  initGroups() async {
    // await GroupService().init(await BackendService.getInstance().getAtSign());
    await GroupService().init(BackendService.getInstance().atClientInstance,
          BackendService.getInstance().currentAtSign,
    MixedConstants.ROOT_DOMAIN, MixedConstants.ROOT_PORT);
    await GroupService().fetchGroupsAndContacts();
  }

  getAtSignAndInitializeContacts() async {
    await initializeContactsService(
        backendService.atClientServiceInstance.atClient, currentAtSign,
        rootDomain: MixedConstants.ROOT_DOMAIN);
  }

  _showScaffold({int status = 0, bool shouldTimeout = true}) {
    return Flushbar(
      title: transferMessages[status],
      message: 'hello',
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: ColorConstants.scaffoldColor,
      boxShadows: [
        BoxShadow(
            color: Colors.black, offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
      isDismissible: false,
      duration: (shouldTimeout) ? Duration(seconds: 3) : null,
      icon: Container(
        height: 40.toWidth,
        width: 40.toWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstants.imagePlaceholder),
              fit: BoxFit.cover),
          shape: BoxShape.circle,
        ),
      ),

      mainButton: FlatButton(
        onPressed: () {
          sendingFlushbar.dismiss();
        },
        child: Text(
          TextStrings().buttonDismiss,
          style: TextStyle(color: ColorConstants.fontPrimary),
        ),
      ),
      // showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blueGrey,
      titleText: Row(
        children: <Widget>[
          transferStatus[status],
          Padding(
            padding: EdgeInsets.only(
              left: 5.toWidth,
            ),
            child: Text(
              transferMessages[status],
              style: TextStyle(
                  color: ColorConstants.fadedText, fontSize: 10.toFont),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filePickerModel = Provider.of<FileTransferProvider>(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: SizeConfig().isTablet(context)
            ? null
            : CustomAppBar(
                showLeadingicon: true,
              ),
        extendBody: true,
        drawerScrimColor: Colors.transparent,
        endDrawer: SideBarWidget(
          isExpanded: true,
        ),
        body: Container(
            width: double.infinity,
            height: SizeConfig().screenHeight,
            child: Container(
              width: double.infinity,
              height: SizeConfig().screenHeight,
              child: Stack(
                children: [
                  SizeConfig().isTablet(context) ? Customheading() : SizedBox(),
                  SizeConfig().isTablet(context)
                      ? Positioned(
                          right: 80,
                          top: 100,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black,
                            ),
                            child: Builder(
                              builder: (context) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                    print('is expanded changed:${isExpanded}');

                                    Scaffold.of(context).openEndDrawer();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : SizedBox(),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.toWidth, vertical: 20.toHeight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  TextStrings().welcomeUser(currentAtSign),
                                  style: GoogleFonts.playfairDisplay(
                                    textStyle: TextStyle(
                                      fontSize: 26.toFont,
                                      fontWeight: FontWeight.w800,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.toHeight,
                                ),
                                Text(
                                  TextStrings().welcomeRecipient,
                                  style: TextStyle(
                                    color: ColorConstants.fadedText,
                                    fontSize: 13.toFont,
                                  ),
                                ),
                                SizedBox(
                                  height: 67.toHeight,
                                ),
                                Text(
                                  TextStrings().welcomeSendFilesTo,
                                  style: TextStyle(
                                    color: ColorConstants.fadedText,
                                    fontSize: 12.toFont,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.toHeight,
                                ),
                                SelectContactWidget(
                                  (b) {
                                    setState(() {
                                      isContactSelected = b;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10.toHeight,
                                ),
                                // ProviderHandler<WelcomeScreenProvider>(),
                                Consumer<WelcomeScreenProvider>(
                                  builder: (context, provider, _) =>
                                      (provider.selectedContacts.isEmpty)
                                          ? Container()
                                          : OverlappingContacts(
                                              selectedList:
                                                  provider.selectedContacts),
                                ),
                                SizedBox(
                                  height: 40.toHeight,
                                ),
                                SelectFileWidget(
                                  (b) {
                                    setState(() {
                                      isFileSelected = b;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 60.toHeight,
                                ),
                                if (_welcomeScreenProvider.selectedContacts !=
                                        null &&
                                    filePickerModel
                                        .selectedFiles.isNotEmpty) ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonButton('Reset', () {
                                        setState(() {
                                          _welcomeScreenProvider
                                              .selectedContacts
                                              .clear();
                                          filePickerModel.selectedFiles.clear();
                                        });
                                      }),
                                      CommonButton(
                                        TextStrings().buttonSend,
                                        () async {
                                          filePickerModel.sendFiles(
                                              filePickerModel.selectedFiles,
                                              _welcomeScreenProvider
                                                  .selectedContacts);
                                          // _showScaffold(status: 0);
                                          // filePickerModel.sendFiles(filePickerModel.selectedFiles,
                                          //     _welcomeScreenProvider.selectedContacts);
                                          // bool response = filePickerModel.sentStatus[0];
                                          // if (filePickerModel.sentStatus != null) {
                                          if (filePickerModel.flushbarStatus ==
                                              FLUSHBAR_STATUS.SENDING) {
                                            sendingFlushbar =
                                                _showScaffold(status: 0);
                                            await sendingFlushbar.show(context);
                                          } else if (filePickerModel
                                                  .flushbarStatus ==
                                              FLUSHBAR_STATUS.FAILED) {
                                            sendingFlushbar =
                                                _showScaffold(status: 2);
                                            await sendingFlushbar.show(context);
                                          }
                                          // filePickerModel.sendFiles(filePickerModel.selectedFiles,
                                          //     _welcomeScreenProvider.selectedContacts);

                                          // bool response;

                                          // response =
                                          //     Provider.of<FileTransferProvider>(
                                          //             context,
                                          //             listen: false)
                                          //         .sentStatus;

                                          // bool response = true;
                                          // bool response = await backendService.sendFile(
                                          //     contactPickerModel.selectedContacts,
                                          //     filePickerModel.selectedFiles[0].path);

                                          // Provider.of<HistoryProvider>(context, listen: false)
                                          //     .setFilesHistory(
                                          //         atSignName: _filePickerProvider
                                          //             .temporaryContactList[0].atSign,
                                          //         historyType: HistoryType.send,
                                          //         files: [
                                          //       FilesDetail(
                                          //           filePath:
                                          //               filePickerModel.selectedFiles[0].path,
                                          //           size: filePickerModel.totalSize,
                                          //           fileName: filePickerModel.result.files[0].name
                                          //               .toString(),
                                          //           type: filePickerModel
                                          //               .selectedFiles[0].extension
                                          //               .toString())
                                          //     ]);

                                          // _showScaffold(status: 1);
                                          // if (response != null &&
                                          //     response == true) {
                                          //   sendingFlushbar =
                                          //       _showScaffold(status: 1);
                                          //   await sendingFlushbar.show(context);
                                          // } else {
                                          //   _showScaffold(status: 2);
                                          // }
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 60.toHeight,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizeConfig().isTablet(context)
                          ? Container(
                              height: SizeConfig().screenHeight,
                              width: 100,
                              child: SideBarWidget(
                                isExpanded: false,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
