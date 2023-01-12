// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// ` Sign up`
  String get sign_up {
    return Intl.message(
      ' Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// ` Sign out`
  String get sign_out {
    return Intl.message(
      ' Sign out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message(
      'Sign in',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get enter_password {
    return Intl.message(
      'Password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get enter_username {
    return Intl.message(
      'Username',
      name: 'enter_username',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get enter_email {
    return Intl.message(
      'Email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter text`
  String get please_enter_test {
    return Intl.message(
      'Please enter text',
      name: 'please_enter_test',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_dont_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_dont_match',
      desc: '',
      args: [],
    );
  }

  /// `The email address is badly formatted`
  String get bad_email {
    return Intl.message(
      'The email address is badly formatted',
      name: 'bad_email',
      desc: '',
      args: [],
    );
  }

  /// `Password should be at least 6 characters long`
  String get bad_password {
    return Intl.message(
      'Password should be at least 6 characters long',
      name: 'bad_password',
      desc: '',
      args: [],
    );
  }

  /// `Your email or password is wrong`
  String get wrong_password {
    return Intl.message(
      'Your email or password is wrong',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `The email address is already in use by another account`
  String get email_already_used {
    return Intl.message(
      'The email address is already in use by another account',
      name: 'email_already_used',
      desc: '',
      args: [],
    );
  }

  /// `User does not exist`
  String get user_not_exist {
    return Intl.message(
      'User does not exist',
      name: 'user_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again later`
  String get error_message {
    return Intl.message(
      'An error occurred. Please try again later',
      name: 'error_message',
      desc: '',
      args: [],
    );
  }

  /// `DISMISS`
  String get dismiss {
    return Intl.message(
      'DISMISS',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Wardrobe`
  String get wardrobe {
    return Intl.message(
      'Wardrobe',
      name: 'wardrobe',
      desc: '',
      args: [],
    );
  }

  /// `Outfits`
  String get outfits {
    return Intl.message(
      'Outfits',
      name: 'outfits',
      desc: '',
      args: [],
    );
  }

  /// `Outfits`
  String get outfits_by_me {
    return Intl.message(
      'Outfits',
      name: 'outfits_by_me',
      desc: '',
      args: [],
    );
  }

  /// `By friends`
  String get outfits_by_friends {
    return Intl.message(
      'By friends',
      name: 'outfits_by_friends',
      desc: '',
      args: [],
    );
  }

  /// `Posts`
  String get posts {
    return Intl.message(
      'Posts',
      name: 'posts',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get social {
    return Intl.message(
      'Social',
      name: 'social',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Your Wardrobe`
  String get wardrobe_page_title {
    return Intl.message(
      'Your Wardrobe',
      name: 'wardrobe_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Search by name`
  String get searchbar_wardrobe_item {
    return Intl.message(
      'Search by name',
      name: 'searchbar_wardrobe_item',
      desc: '',
      args: [],
    );
  }

  /// `Dress`
  String get dress {
    return Intl.message(
      'Dress',
      name: 'dress',
      desc: '',
      args: [],
    );
  }

  /// `Top`
  String get top {
    return Intl.message(
      'Top',
      name: 'top',
      desc: '',
      args: [],
    );
  }

  /// `Trousers`
  String get trousers {
    return Intl.message(
      'Trousers',
      name: 'trousers',
      desc: '',
      args: [],
    );
  }

  /// `Jeans`
  String get jeans {
    return Intl.message(
      'Jeans',
      name: 'jeans',
      desc: '',
      args: [],
    );
  }

  /// `T-Shirt`
  String get tshirt {
    return Intl.message(
      'T-Shirt',
      name: 'tshirt',
      desc: '',
      args: [],
    );
  }

  /// `Sweatshirt`
  String get sweatshirt {
    return Intl.message(
      'Sweatshirt',
      name: 'sweatshirt',
      desc: '',
      args: [],
    );
  }

  /// `Hoodie`
  String get hoodie {
    return Intl.message(
      'Hoodie',
      name: 'hoodie',
      desc: '',
      args: [],
    );
  }

  /// `Jacket`
  String get jacket {
    return Intl.message(
      'Jacket',
      name: 'jacket',
      desc: '',
      args: [],
    );
  }

  /// `Blazer`
  String get blazer {
    return Intl.message(
      'Blazer',
      name: 'blazer',
      desc: '',
      args: [],
    );
  }

  /// `Skirt`
  String get skirt {
    return Intl.message(
      'Skirt',
      name: 'skirt',
      desc: '',
      args: [],
    );
  }

  /// `Coat`
  String get coat {
    return Intl.message(
      'Coat',
      name: 'coat',
      desc: '',
      args: [],
    );
  }

  /// `Sweater`
  String get sweater {
    return Intl.message(
      'Sweater',
      name: 'sweater',
      desc: '',
      args: [],
    );
  }

  /// `Cardigan`
  String get cardigan {
    return Intl.message(
      'Cardigan',
      name: 'cardigan',
      desc: '',
      args: [],
    );
  }

  /// `Swimsuit`
  String get swimsuit {
    return Intl.message(
      'Swimsuit',
      name: 'swimsuit',
      desc: '',
      args: [],
    );
  }

  /// `Sportswear`
  String get sports {
    return Intl.message(
      'Sportswear',
      name: 'sports',
      desc: '',
      args: [],
    );
  }

  /// `Shorts`
  String get shorts {
    return Intl.message(
      'Shorts',
      name: 'shorts',
      desc: '',
      args: [],
    );
  }

  /// `Pyjama`
  String get pyjama {
    return Intl.message(
      'Pyjama',
      name: 'pyjama',
      desc: '',
      args: [],
    );
  }

  /// `Shoes`
  String get shoes {
    return Intl.message(
      'Shoes',
      name: 'shoes',
      desc: '',
      args: [],
    );
  }

  /// `Hat`
  String get hat {
    return Intl.message(
      'Hat',
      name: 'hat',
      desc: '',
      args: [],
    );
  }

  /// `See details`
  String get see_details {
    return Intl.message(
      'See details',
      name: 'see_details',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get friends {
    return Intl.message(
      'Friends',
      name: 'friends',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get edit_profile {
    return Intl.message(
      'Edit profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Friends requests`
  String get friend_requests {
    return Intl.message(
      'Friends requests',
      name: 'friend_requests',
      desc: '',
      args: [],
    );
  }

  /// `Show current weather`
  String get show_current_weather {
    return Intl.message(
      'Show current weather',
      name: 'show_current_weather',
      desc: '',
      args: [],
    );
  }

  /// `Current weather`
  String get current_weather {
    return Intl.message(
      'Current weather',
      name: 'current_weather',
      desc: '',
      args: [],
    );
  }

  /// `Enter Citys`
  String get enter_city {
    return Intl.message(
      'Enter Citys',
      name: 'enter_city',
      desc: '',
      args: [],
    );
  }

  /// `Looks for`
  String get looks_for {
    return Intl.message(
      'Looks for',
      name: 'looks_for',
      desc: '',
      args: [],
    );
  }

  /// `Add looks for`
  String get add_looks_for {
    return Intl.message(
      'Add looks for',
      name: 'add_looks_for',
      desc: '',
      args: [],
    );
  }

  /// `Pick outfits`
  String get pick_outfits {
    return Intl.message(
      'Pick outfits',
      name: 'pick_outfits',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Pick some outfits first`
  String get pick_outfits_error {
    return Intl.message(
      'Pick some outfits first',
      name: 'pick_outfits_error',
      desc: '',
      args: [],
    );
  }

  /// `Accessories`
  String get accessories {
    return Intl.message(
      'Accessories',
      name: 'accessories',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any items in your wardrobe!`
  String get empty_wardrobe {
    return Intl.message(
      'You don\'t have any items in your wardrobe!',
      name: 'empty_wardrobe',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Clothing type`
  String get clothing_types {
    return Intl.message(
      'Clothing type',
      name: 'clothing_types',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Style`
  String get style {
    return Intl.message(
      'Style',
      name: 'style',
      desc: '',
      args: [],
    );
  }

  /// `Apply filters`
  String get apply_filters {
    return Intl.message(
      'Apply filters',
      name: 'apply_filters',
      desc: '',
      args: [],
    );
  }

  /// `No outfits have been created yet!`
  String get empty_outfits {
    return Intl.message(
      'No outfits have been created yet!',
      name: 'empty_outfits',
      desc: '',
      args: [],
    );
  }

  /// `It seems that you don't have any added friend yet!`
  String get empty_feed {
    return Intl.message(
      'It seems that you don\'t have any added friend yet!',
      name: 'empty_feed',
      desc: '',
      args: [],
    );
  }

  /// `Find your friend`
  String get search_friend {
    return Intl.message(
      'Find your friend',
      name: 'search_friend',
      desc: '',
      args: [],
    );
  }

  /// `No pending invitations`
  String get no_pending_invitation {
    return Intl.message(
      'No pending invitations',
      name: 'no_pending_invitation',
      desc: '',
      args: [],
    );
  }

  /// `No pending invitations from such user`
  String get no_pending_invitation_user {
    return Intl.message(
      'No pending invitations from such user',
      name: 'no_pending_invitation_user',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get friends_request {
    return Intl.message(
      'Requests',
      name: 'friends_request',
      desc: '',
      args: [],
    );
  }

  /// `All your friends`
  String get all_friends {
    return Intl.message(
      'All your friends',
      name: 'all_friends',
      desc: '',
      args: [],
    );
  }

  /// `Found`
  String get found {
    return Intl.message(
      'Found',
      name: 'found',
      desc: '',
      args: [],
    );
  }

  /// `results`
  String get results {
    return Intl.message(
      'results',
      name: 'results',
      desc: '',
      args: [],
    );
  }

  /// `You don't have friends yet`
  String get no_friends {
    return Intl.message(
      'You don\'t have friends yet',
      name: 'no_friends',
      desc: '',
      args: [],
    );
  }

  /// `No matched friends`
  String get no_found_friends {
    return Intl.message(
      'No matched friends',
      name: 'no_found_friends',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
