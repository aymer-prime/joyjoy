import 'dart:convert';

import 'package:tryt/services/httpservices.dart';

class Langstringmodel {
  General? general;
  Home? home;
  Login? login;
  Register? register;
  ForgotPassword? forgotPassword;
  Activation? activation;
  ActivationResend? activationResend;
  Info? info;
  Feed? feed;
  Chat? chat;
  Choose? choose;
  Model? model;
  Notifications? notifications;
  Profile? profile;
  Settings? settings;
  Purchases? purchases;
  Purchases? helpSupport;
  Purchases? termsOfUse;
  Purchases? pdpl;
  Purchases? privacyPolicy;
  Premium? premium;
  DeleteAccount? deleteAccount;

  Langstringmodel(
      {this.general,
      this.home,
      this.login,
      this.register,
      this.forgotPassword,
      this.activation,
      this.activationResend,
      this.info,
      this.feed,
      this.chat,
      this.choose,
      this.model,
      this.notifications,
      this.profile,
      this.settings,
      this.purchases,
      this.helpSupport,
      this.termsOfUse,
      this.pdpl,
      this.privacyPolicy,
      this.premium,
      this.deleteAccount});

  Langstringmodel.fromJson(Map<String, dynamic> json) {
    general =
        json['general'] != null ? General.fromJson(json['general']) : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    login = json['login'] != null ? Login.fromJson(json['login']) : null;
    register = json['register'] != null
        ? Register.fromJson(json['register'])
        : null;
    forgotPassword = json['forgot_password'] != null
        ? ForgotPassword.fromJson(json['forgot_password'])
        : null;
    activation = json['activation'] != null
        ? Activation.fromJson(json['activation'])
        : null;
    activationResend = json['activation_resend'] != null
        ? ActivationResend.fromJson(json['activation_resend'])
        : null;
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    feed = json['feed'] != null ? Feed.fromJson(json['feed']) : null;
    chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
    choose =
        json['choose'] != null ? Choose.fromJson(json['choose']) : null;
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    notifications = json['notifications'] != null
        ? Notifications.fromJson(json['notifications'])
        : null;
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
    purchases = json['purchases'] != null
        ? Purchases.fromJson(json['purchases'])
        : null;
    helpSupport = json['help_support'] != null
        ? Purchases.fromJson(json['help_support'])
        : null;
    termsOfUse = json['terms_of_use'] != null
        ? Purchases.fromJson(json['terms_of_use'])
        : null;
    pdpl = json['pdpl'] != null ? Purchases.fromJson(json['pdpl']) : null;
    privacyPolicy = json['privacy_policy'] != null
        ? Purchases.fromJson(json['privacy_policy'])
        : null;
    premium =
        json['premium'] != null ? Premium.fromJson(json['premium']) : null;
    deleteAccount = json['delete_account'] != null
        ? DeleteAccount.fromJson(json['delete_account'])
        : null;
  }
}

class General {
  String? siteVersion;
  String? userImage;
  String? lazyLoadImage;
  String? pageTitle;
  String? slogan;
  String? error;
  String? success;
  String? okay;
  String? loading;
  String? name;
  String? surname;
  String? next;
  String? day;
  String? month;
  String? year;
  String? choose;
  String? male;
  String? female;
  String? complete;
  String? requiredLanguageSelection;
  String? requiredPage;
  String? requiredPerpage;
  String? all;
  String? general;
  String? gender;
  String? deleteImage;
  String? save;
  String? detail;
  String? version;
  String? allRightsReserved;
  String? edit;
  String? email;
  String? username;
  String? password;
  String? logout;
  String? language;
  String? send;
  String? startTalking;
  String? serverError;
  String? noInternet;
  String? somethingWentWrong;
  String? fileUploadError;
  String? invalidFileType;
  String? maxFileSize;
  List<Months>? months;

  General(
      {this.siteVersion,
      this.userImage,
      this.lazyLoadImage,
      this.pageTitle,
      this.slogan,
      this.error,
      this.success,
      this.okay,
      this.loading,
      this.name,
      this.surname,
      this.next,
      this.day,
      this.month,
      this.year,
      this.choose,
      this.male,
      this.female,
      this.complete,
      this.requiredLanguageSelection,
      this.requiredPage,
      this.requiredPerpage,
      this.all,
      this.general,
      this.gender,
      this.deleteImage,
      this.save,
      this.detail,
      this.version,
      this.allRightsReserved,
      this.edit,
      this.email,
      this.username,
      this.password,
      this.logout,
      this.language,
      this.send,
      this.startTalking,
      this.serverError,
      this.noInternet,
      this.somethingWentWrong,
      this.fileUploadError,
      this.invalidFileType,
      this.maxFileSize,
      this.months});

  General.fromJson(Map<String, dynamic> json) {
    siteVersion = json['site_version'];
    userImage = json['user_image'];
    lazyLoadImage = json['lazy_load_image'];
    pageTitle = json['page_title'];
    slogan = json['slogan'];
    error = json['error'];
    success = json['success'];
    okay = json['okay'];
    loading = json['loading'];
    name = json['name'];
    surname = json['surname'];
    next = json['next'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
    choose = json['choose'];
    male = json['male'];
    female = json['female'];
    complete = json['complete'];
    requiredLanguageSelection = json['required_language_selection'];
    requiredPage = json['required_page'];
    requiredPerpage = json['required_perpage'];
    all = json['all'];
    general = json['general'];
    gender = json['gender'];
    deleteImage = json['delete_image'];
    save = json['save'];
    detail = json['detail'];
    version = json['version'];
    allRightsReserved = json['all_rights_reserved'];
    edit = json['edit'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    logout = json['logout'];
    language = json['language'];
    send = json['send'];
    startTalking = json['start_talking'];
    serverError = json['server_error'];
    noInternet = json['no_internet'];
    somethingWentWrong = json['something_went_wrong'];
    fileUploadError = json['file_upload_error'];
    invalidFileType = json['invalid_file_type'];
    maxFileSize = json['max_file_size'];
    if (json['months'] != null) {
      months = <Months>[];
      json['months'].forEach((v) {
        months!.add(Months.fromJson(v));
      });
    }
  }
}

class Months {
  String? name;
  String? shortName;

  Months({this.name, this.shortName});

  Months.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['short_name'];
  }
}

class Home {
  String? title;
  String? description;
  String? button;

  Home({this.title, this.description, this.button});

  Home.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    button = json['button'];
  }
}

class Login {
  String? pageTitle;
  String? title;
  String? subtitle;
  String? emailUsername;
  String? password;
  String? button;
  String? googleButton;
  String? facebookButton;
  String? emailButton;
  String? forgotPassword;
  String? privacyPolicyText;
  ErrorMessage? errorMessage;

  Login(
      {this.pageTitle,
      this.title,
      this.subtitle,
      this.emailUsername,
      this.password,
      this.button,
      this.googleButton,
      this.facebookButton,
      this.emailButton,
      this.forgotPassword,
      this.privacyPolicyText,
      this.errorMessage});

  Login.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    title = json['title'];
    subtitle = json['subtitle'];
    emailUsername = json['email_username'];
    password = json['password'];
    button = json['button'];
    googleButton = json['google_button'];
    facebookButton = json['facebook_button'];
    emailButton = json['email_button'];
    forgotPassword = json['forgot_password'];
    privacyPolicyText = json['privacy_policy_text'];
    errorMessage = json['error_message'] != null
        ? ErrorMessage.fromJson(json['error_message'])
        : null;
  }
}

class ErrorMessage {
  EmailUsername? emailUsername;
  EmailUsername? password;
  String? noAccount;
  String? activationNotCompleted;
  String? deactive;
  String? informationIncorrect;

  ErrorMessage(
      {this.emailUsername,
      this.password,
      this.noAccount,
      this.activationNotCompleted,
      this.deactive,
      this.informationIncorrect});

  ErrorMessage.fromJson(Map<String, dynamic> json) {
    emailUsername = json['email_username'] != null
        ? EmailUsername.fromJson(json['email_username'])
        : null;
    password = json['password'] != null
        ? EmailUsername.fromJson(json['password'])
        : null;
    noAccount = json['no_account'];
    activationNotCompleted = json['activation_not_completed'];
    deactive = json['deactive'];
    informationIncorrect = json['information_incorrect'];
  }
}

class EmailUsername {
  String? wrong;
  String? minMax;

  EmailUsername({this.wrong, this.minMax});

  EmailUsername.fromJson(Map<String, dynamic> json) {
    wrong = json['wrong'];
    minMax = json['min_max'];
  }
}

class Register {
  String? pageTitle;
  String? title;
  String? subtitle;
  String? username;
  String? email;
  String? password;
  String? button;
  String? membership;
  String? privacyPolicyText;
  ErrorMessage1? errorMessage;

  Register(
      {this.pageTitle,
      this.title,
      this.subtitle,
      this.username,
      this.email,
      this.password,
      this.button,
      this.membership,
      this.privacyPolicyText,
      this.errorMessage});

  Register.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    title = json['title'];
    subtitle = json['subtitle'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    button = json['button'];
    membership = json['membership'];
    privacyPolicyText = json['privacy_policy_text'];
    errorMessage = json['error_message'] != null
        ? ErrorMessage1.fromJson(json['error_message'])
        : null;
  }
}

class ErrorMessage1 {
  Username? username;
  Email? email;
  EmailUsername? password;

  ErrorMessage1({this.username, this.email, this.password});

  ErrorMessage1.fromJson(Map<String, dynamic> json) {
    username = json['username'] != null
        ? Username.fromJson(json['username'])
        : null;
    email = json['email'] != null ? Email.fromJson(json['email']) : null;
    password = json['password'] != null
        ? EmailUsername.fromJson(json['password'])
        : null;
  }
}

class Username {
  String? wrong;
  String? maxMin;
  String? used;

  Username({this.wrong, this.maxMin, this.used});

  Username.fromJson(Map<String, dynamic> json) {
    wrong = json['wrong'];
    maxMin = json['max_min'];
    used = json['used'];
  }
}

class Email {
  String? wrong;
  String? used;

  Email({this.wrong, this.used});

  Email.fromJson(Map<String, dynamic> json) {
    wrong = json['wrong'];
    used = json['used'];
  }
}

class ForgotPassword {
  String? pageTitle;
  String? subtitle;
  String? emailUsername;
  String? button;
  String? login;
  ErrorMessage2? errorMessage;
  String? successMessage;

  ForgotPassword(
      {this.pageTitle,
      this.subtitle,
      this.emailUsername,
      this.button,
      this.login,
      this.errorMessage,
      this.successMessage});

  ForgotPassword.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    subtitle = json['subtitle'];
    emailUsername = json['email_username'];
    button = json['button'];
    login = json['login'];
    errorMessage = json['error_message'] != null
        ? ErrorMessage2.fromJson(json['error_message'])
        : null;
    successMessage = json['success_message'];
  }
}

class ErrorMessage2 {
  EmailUsername? emailUsername;
  String? noAccount;
  String? time;

  ErrorMessage2({this.emailUsername, this.noAccount, this.time});

  ErrorMessage2.fromJson(Map<String, dynamic> json) {
    emailUsername = json['email_username'] != null
        ? EmailUsername.fromJson(json['email_username'])
        : null;
    noAccount = json['no_account'];
    time = json['time'];
  }
}

class Activation {
  String? pageTitle;
  String? title;
  String? description;
  String? button;
  String? help;
  String? refresh;
  ErrorMessage3? errorMessage;

  Activation(
      {this.pageTitle,
      this.title,
      this.description,
      this.button,
      this.help,
      this.refresh,
      this.errorMessage});

  Activation.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    title = json['title'];
    description = json['description'];
    button = json['button'];
    help = json['help'];
    refresh = json['refresh'];
    errorMessage = json['error_message'] != null
        ? ErrorMessage3.fromJson(json['error_message'])
        : null;
  }
}

class ErrorMessage3 {
  String? wrong;

  ErrorMessage3({this.wrong});

  ErrorMessage3.fromJson(Map<String, dynamic> json) {
    wrong = json['wrong'];
  }
}

class ActivationResend {
  ErrorMessage4? errorMessage;
  String? successMessage;

  ActivationResend({this.errorMessage, this.successMessage});

  ActivationResend.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'] != null
        ? ErrorMessage4.fromJson(json['error_message'])
        : null;
    successMessage = json['success_message'];
  }
}

class ErrorMessage4 {
  String? wrong;
  String? noAccount;
  String? activationComplate;
  String? time;

  ErrorMessage4(
      {this.wrong, this.noAccount, this.activationComplate, this.time});

  ErrorMessage4.fromJson(Map<String, dynamic> json) {
    wrong = json['wrong'];
    noAccount = json['no_account'];
    activationComplate = json['activation_complate'];
    time = json['time'];
  }
}

class Info {
  String? pageTitle;
  String? step1Title;
  String? step2Title;
  String? step3Title;
  String? dontWant;
  String? bottomText;
  ErrorMessage5? errorMessage;

  Info(
      {this.pageTitle,
      this.step1Title,
      this.step2Title,
      this.step3Title,
      this.dontWant,
      this.bottomText,
      this.errorMessage});

  Info.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    step1Title = json['step_1_title'];
    step2Title = json['step_2_title'];
    step3Title = json['step_3_title'];
    dontWant = json['dont_want'];
    bottomText = json['bottom_text'];
    errorMessage = json['error_message'] != null
        ? ErrorMessage5.fromJson(json['error_message'])
        : null;
  }
}

class ErrorMessage5 {
  String? name;
  String? surname;
  String? birthday;
  String? gender;

  ErrorMessage5({this.name, this.surname, this.birthday, this.gender});

  ErrorMessage5.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    birthday = json['birthday'];
    gender = json['gender'];
  }
}

class Feed {
  String? pageTitle;
  int? perpage;
  Comment? comment;
  ErrorMessage6? errorMessage;

  Feed({this.pageTitle, this.perpage, this.comment, this.errorMessage});

  Feed.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    perpage = json['perpage'];
    comment =
        json['comment'] != null ? Comment.fromJson(json['comment']) : null;
    errorMessage = json['error_message'] != null
        ? ErrorMessage6.fromJson(json['error_message'])
        : null;
  }
}

class Comment {
  int? perpage;
  String? title;
  NoComment? noComment;
  String? textbox;
  String? reply;
  String? replying;

  Comment(
      {this.perpage,
      this.title,
      this.noComment,
      this.textbox,
      this.reply,
      this.replying});

  Comment.fromJson(Map<String, dynamic> json) {
    perpage = json['perpage'];
    title = json['title'];
    noComment = json['no_comment'] != null
        ? NoComment.fromJson(json['no_comment'])
        : null;
    textbox = json['textbox'];
    reply = json['reply'];
    replying = json['replying'];
  }
}

class NoComment {
  String? title;
  String? subtitle;

  NoComment({this.title, this.subtitle});

  NoComment.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
  }
}

class ErrorMessage6 {
  String? selectPost;
  String? noPost;
  String? comment;
  String? selectComment;
  String? noComment;

  ErrorMessage6(
      {this.selectPost,
      this.noPost,
      this.comment,
      this.selectComment,
      this.noComment});

  ErrorMessage6.fromJson(Map<String, dynamic> json) {
    selectPost = json['select_post'];
    noPost = json['no_post'];
    comment = json['comment'];
    selectComment = json['select_comment'];
    noComment = json['no_comment'];
  }
}

class Chat {
  String? pageTitle;
  String? suggestionsForYou;
  String? chatHistory;
  int? perpage;
  Detail? detail;

  Chat(
      {this.pageTitle,
      this.suggestionsForYou,
      this.chatHistory,
      this.perpage,
      this.detail});

  Chat.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    suggestionsForYou = json['suggestions_for_you'];
    chatHistory = json['chat_history'];
    perpage = json['perpage'];
    detail =
        json['detail'] != null ? Detail.fromJson(json['detail']) : null;
  }
}

class Detail {
  int? perpage;
  String? sendPhoto;
  ErrorMessage7? errorMessage;

  Detail({this.perpage, this.sendPhoto, this.errorMessage});

  Detail.fromJson(Map<String, dynamic> json) {
    perpage = json['perpage'];
    sendPhoto = json['send_photo'];
    errorMessage = json['error_message'] != null
        ? ErrorMessage7.fromJson(json['error_message'])
        : null;
  }
}

class ErrorMessage7 {
  String? selectingChat;
  String? noChat;
  String? writeMessage;
  String? selectPhoto;

  ErrorMessage7(
      {this.selectingChat, this.noChat, this.writeMessage, this.selectPhoto});

  ErrorMessage7.fromJson(Map<String, dynamic> json) {
    selectingChat = json['selecting_chat'];
    noChat = json['no_chat'];
    writeMessage = json['write_message'];
    selectPhoto = json['select_photo'];
  }
}

class Choose {
  String? pageTitle;
  String? step1Title;
  String? step2Title;
  String? step3Title;
  String? selectModel;

  Choose(
      {this.pageTitle,
      this.step1Title,
      this.step2Title,
      this.step3Title,
      this.selectModel});

  Choose.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    step1Title = json['step_1_title'];
    step2Title = json['step_2_title'];
    step3Title = json['step_3_title'];
    selectModel = json['select_model'];
  }
}

class Model {
  String? chooseRequired;
  String? modelStatus;
  int? perpage;

  Model({this.chooseRequired, this.modelStatus, this.perpage});

  Model.fromJson(Map<String, dynamic> json) {
    chooseRequired = json['choose_required'];
    modelStatus = json['model_status'];
    perpage = json['perpage'];
  }
}

class Notifications {
  String? pageTitle;
  String? noNotification;
  int? perpage;
  String? repliedComment;

  Notifications(
      {this.pageTitle, this.noNotification, this.perpage, this.repliedComment});

  Notifications.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    noNotification = json['no_notification'];
    perpage = json['perpage'];
    repliedComment = json['replied_comment'];
  }
}

class Profile {
  String? pageTitle;
  String? requiredImg;
  Edit? edit;
  EditUsername? editUsername;
  EditPassword? editPassword;

  Profile(
      {this.pageTitle,
      this.requiredImg,
      this.edit,
      this.editUsername,
      this.editPassword});

  Profile.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    requiredImg = json['required_img'];
    edit = json['edit'] != null ? Edit.fromJson(json['edit']) : null;
    editUsername = json['edit_username'] != null
        ? EditUsername.fromJson(json['edit_username'])
        : null;
    editPassword = json['edit_password'] != null
        ? EditPassword.fromJson(json['edit_password'])
        : null;
  }
}

class Edit {
  String? pageTitle;
  String? connectedGoogle;
  String? successMessage;

  Edit({this.pageTitle, this.connectedGoogle, this.successMessage});

  Edit.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    connectedGoogle = json['connected_google'];
    successMessage = json['success_message'];
  }
}

class EditUsername {
  String? pageTitle;
  String? successMessage;

  EditUsername({this.pageTitle, this.successMessage});

  EditUsername.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    successMessage = json['success_message'];
  }
}

class EditPassword {
  String? pageTitle;
  String? currentPassword;
  String? newPassword;
  String? newPasswordAgain;
  ErrorMessage8? errorMessage;
  String? successMessage;

  EditPassword(
      {this.pageTitle,
      this.currentPassword,
      this.newPassword,
      this.newPasswordAgain,
      this.errorMessage,
      this.successMessage});

  EditPassword.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    currentPassword = json['current_password'];
    newPassword = json['new_password'];
    newPasswordAgain = json['new_password_again'];
    errorMessage = json['error_message'] != null
        ? ErrorMessage8.fromJson(json['error_message'])
        : null;
    successMessage = json['success_message'];
  }
}

class ErrorMessage8 {
  String? enterCurrentPassword;
  String? enterNewPassword;
  String? enterNewPasswordAgain;
  String? currentPasswordError;
  String? newPasswordNotMatch;

  ErrorMessage8(
      {this.enterCurrentPassword,
      this.enterNewPassword,
      this.enterNewPasswordAgain,
      this.currentPasswordError,
      this.newPasswordNotMatch});

  ErrorMessage8.fromJson(Map<String, dynamic> json) {
    enterCurrentPassword = json['enter_current_password'];
    enterNewPassword = json['enter_new_password'];
    enterNewPasswordAgain = json['enter_new_password_again'];
    currentPasswordError = json['current_password_error'];
    newPasswordNotMatch = json['new_password_not_match'];
  }
}

class Settings {
  String? pageTitle;
  Theme? theme;
  ErrorMessage9? errorMessage;
  String? successMessage;

  Settings(
      {this.pageTitle, this.theme, this.errorMessage, this.successMessage});

  Settings.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    theme = json['theme'] != null ? Theme.fromJson(json['theme']) : null;
    errorMessage = json['error_message'] != null
        ? ErrorMessage9.fromJson(json['error_message'])
        : null;
    successMessage = json['success_message'];
  }
}

class Theme {
  String? title;
  String? auto;
  String? light;
  String? dark;

  Theme({this.title, this.auto, this.light, this.dark});

  Theme.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    auto = json['auto'];
    light = json['light'];
    dark = json['dark'];
  }
}

class ErrorMessage9 {
  String? choosingTheme;

  ErrorMessage9({this.choosingTheme});

  ErrorMessage9.fromJson(Map<String, dynamic> json) {
    choosingTheme = json['choosing_theme'];
  }
}

class Purchases {
  String? pageTitle;

  Purchases({this.pageTitle});

  Purchases.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
  }
}

class Premium {
  String? premiumMembership;
  String? renewed;

  Premium({this.premiumMembership, this.renewed});

  Premium.fromJson(Map<String, dynamic> json) {
    premiumMembership = json['premium_membership'];
    renewed = json['renewed'];
  }
}

class DeleteAccount {
  String? pageTitle;
  String? description;
  String? approval;
  String? approvalAgain;
  Buttons? buttons;

  DeleteAccount(
      {this.pageTitle,
      this.description,
      this.approval,
      this.approvalAgain,
      this.buttons});

  DeleteAccount.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    description = json['description'];
    approval = json['approval'];
    approvalAgain = json['approval_again'];
    buttons =
        json['buttons'] != null ? Buttons.fromJson(json['buttons']) : null;
  }
}

class Buttons {
  String? success;
  String? cancel;

  Buttons({this.success, this.cancel});

  Buttons.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    cancel = json['cancel'];
  }
}

Future<Langstringmodel> getLangFulTextApi(String lang) async {
  var sonuc =
      await Httpservices().postMethod("general/texts.php", {"lang": lang});
  var body = json.decode(sonuc);
  var deger = body["result"];
  return Langstringmodel.fromJson(deger);
}
