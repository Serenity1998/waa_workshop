// /*
//  * File name: theme1_app_pages.dart
//  * Last modified: 2022.02.16 at 22:11:22
//  * Author: SmarterVision - https://codecanyon.net/user/smartervision
//  * Copyright (c) 2022
//  */

import 'package:get/get.dart' show GetPage, Transition;
import 'package:save_time_customer/app/modules/home/views/home2_view.dart';

import '../../common/qr_scanner.dart';
import '../middlewares/auth_middleware.dart';
import '../middlewares/onboarding_middleware.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/new_password_view.dart';
import '../modules/auth/views/phone_verification_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/book_e_service/bindings/book_e_service_binding.dart';
import '../modules/book_e_service/views/book_e_service_view.dart';
import '../modules/book_e_service/views/book_select_employee_view.dart';
import '../modules/book_e_service/views/book_ticket.dart';
import '../modules/book_e_service/views/booking_summary_view.dart';
import '../modules/bookings/views/booking_view.dart';
import '../modules/bookings/views/booking_view_new.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/categories_view.dart';
import '../modules/category/views/category_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/cash_view.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/checkout/views/confirmation_view.dart';
import '../modules/checkout/views/flutterwave_view.dart';
import '../modules/checkout/views/paymongo_view.dart';
import '../modules/checkout/views/paypal_view.dart';
import '../modules/checkout/views/paystack_view.dart';
import '../modules/checkout/views/razorpay_view.dart';
import '../modules/checkout/views/stripe_fpx_view.dart';
import '../modules/checkout/views/stripe_view.dart';
import '../modules/checkout/views/wallet_view.dart';
import '../modules/custom_pages/bindings/custom_pages_binding.dart';
import '../modules/custom_pages/views/custom_pages_view.dart';
import '../modules/e_service/bindings/e_service_binding.dart';
import '../modules/e_service/views/e_service_view.dart';
import '../modules/favorites/bindings/favorites_binding.dart';
import '../modules/favorites/views/favorites_view.dart';
import '../modules/gallery/bindings/gallery_binding.dart';
import '../modules/gallery/views/gallery_view.dart';
import '../modules/help_privacy/bindings/help_privacy_binding.dart';
import '../modules/help_privacy/views/help_view.dart';
import '../modules/help_privacy/views/privacy_view.dart';
import '../modules/home/bindings/home_bindings.dart';
import '../modules/home/views/Banner_list.dart';
import '../modules/invoice/bindings/invoice_binding.dart';
import '../modules/invoice/views/invoice_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';
import '../modules/messages/views/chats_view.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news/views/news_details.dart';
import '../modules/news/views/news_view.dart';
import '../modules/news/widgets/news_detail.dart';
import '../modules/notification_setting/bindings/notification_setting_bindings.dart';
import '../modules/notification_setting/views/notification_setting_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/onboarding/binding/on_boarding_binding.dart';
import '../modules/onboarding/views/on_boarding_view.dart';
import '../modules/portfolio/bindings/portfolio_binding.dart';
import '../modules/portfolio/views/career_create_view.dart';
import '../modules/portfolio/views/career_language_view.dart';
import '../modules/portfolio/views/education_create_view.dart';
import '../modules/portfolio/views/education_view.dart';
import '../modules/portfolio/views/introduction_create_view.dart';
import '../modules/portfolio/views/language_create_view.dart';
import '../modules/portfolio/views/links_create_view.dart';
import '../modules/portfolio/views/links_view.dart';
import '../modules/portfolio/views/portfolio_view.dart';
import '../modules/portfolio/views/skills_create_view.dart';
import '../modules/portfolio/views/skills_view.dart';
import '../modules/portfolio/views/work_history_create.dart';
import '../modules/portfolio/views/work_history_view.dart';
import '../modules/privacy/bindings/privacy_binding.dart';
import '../modules/privacy/views/privacy_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/change_password_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/rating/bindings/rating_binding.dart';
import '../modules/rating/views/rating_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/salon/bindings/salon_binding.dart';
import '../modules/salon/views/salon_e_services_view.dart';
import '../modules/salon/views/salon_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/address_picker_view.dart';
import '../modules/settings/views/addresses_view.dart';
import '../modules/settings/views/language_view.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/views/theme_mode_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/wallets/bindings/wallets_binding.dart';
import '../modules/wallets/views/wallet_form_view.dart';
import '../modules/wallets/views/wallets_view.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
        name: Routes.ROOT,
        page: () => MainTab(indexTab: 0),
        binding: RootBinding(),
        middlewares: [OnboardingMiddleWare()]),
    GetPage(
        name: Routes.RATING,
        page: () => RatingView(),
        binding: RatingBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.CHAT,
        page: () => ChatsView(),
        binding: RootBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.NOTIFICATION_SETTING,
        page: () => NotificationSettingView(),
        binding: NotificationSettingBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.INVOICE,
        page: () => InvoiceView(),
        binding: InvoiceBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.NEWSDETAIL,
        page: () => NewsDetail(),
        binding: NewsBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.SETTINGS,
        page: () => SettingsView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.ON_BOARD,
        page: () => OnboardingView(),
        binding: OnboardingBinding()),
    GetPage(
        name: Routes.BANNERLIST,
        page: () => BannerList(),
        binding: HomeBindings()),
    GetPage(
        name: Routes.SETTINGS_ADDRESSES,
        page: () => AddressesView(),
        binding: SettingsBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashView(),
        binding: SplashBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.SETTINGS_THEME_MODE,
        page: () => ThemeModeView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.SETTINGS_LANGUAGE,
        page: () => LanguageView(),
        binding: SettingsBinding()),
    GetPage(
      name: Routes.SETTINGS_ADDRESS_PICKER,
      page: () => AddressPickerView(),
    ),
    GetPage(
        name: Routes.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO,
        page: () => PortfolioView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_INTRODUCTION,
        page: () => IntroductionCreateView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_EDUCATION,
        page: () => EducationView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_EDUCATION_CREATE,
        page: () => EducationCreateView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_CAREER_LANGUAGE,
        page: () => CareerLanguageView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_CAREER_CREATE,
        page: () => CareerCreateView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_LANGUAGE_CREATE,
        page: () => LanguageCreatView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_WORK_HISTORY,
        page: () => WorkHistoryView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_WORK_HISTORY_CREATE,
        page: () => WorkHistoryCreateView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_SKILLS,
        page: () => SkillsView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_SKILLS_CREATE,
        page: () => SkillsCreateView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_LINKS,
        page: () => LinksView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PORTFOLIO_LINKS_CREATE,
        page: () => LinksCreateView(),
        binding: PortfolioBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.CHANGE_PASSWORD,
        page: () => ChangePasswordView(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.CATEGORY,
        page: () => CategoryView(),
        binding: CategoryBinding()),
    GetPage(
        name: Routes.CATEGORIES,
        page: () => CategoriesView(),
        binding: CategoryBinding()),
    GetPage(
      name: Routes.MAPS,
      page: () => MapsView(),
      binding: MapsBinding(),
    ),
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginView(),
        binding: AuthBinding(),
        transition: Transition.zoom),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.FORGOT_PASSWORD,
        page: () => ForgotPasswordView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.NEW_PASSWORD,
        page: () => NewPasswordView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.PHONE_VERIFICATION,
        page: () => PhoneVerificationView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.E_SERVICE,
        page: () => EServiceView(),
        binding: EServiceBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.BOOK_E_SERVICE,
        page: () => BookEServiceView(),
        binding: BookEServiceBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.BOOKING_SUMMARY,
        page: () => BookingSummaryView(),
        binding: BookEServiceBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.CHECKOUT,
        page: () => CheckoutView(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.CONFIRMATION,
        page: () => ConfirmationView(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.SEARCH,
        page: () => SearchView(),
        binding: RootBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.NOTIFICATIONS,
        page: () => NotificationsView(),
        binding: NotificationsBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.FAVORITES,
        page: () => FavoritesView(),
        binding: FavoritesBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PRIVACY,
        page: () => PrivacyView(),
        binding: HelpPrivacyBinding()),
    GetPage(
        name: Routes.PRIVACYSECURITY,
        page: () => PrivacySecurityView(),
        binding: PrivacyBinding()),
    GetPage(
        name: Routes.PRIVACYSECURITY,
        page: () => PrivacyView(),
        binding: HelpPrivacyBinding()),
    GetPage(
        name: Routes.HELP,
        page: () => HelpView(),
        binding: HelpPrivacyBinding()),
    GetPage(
      name: Routes.SALON,
      page: () => SalonView(),
      binding: SalonBinding(),
    ),
    GetPage(
        name: Routes.SALON_E_SERVICES,
        page: () => SalonEServicesView(),
        binding: SalonBinding()),
    GetPage(
        name: Routes.BOOKING,
        page: () => BookingViewNew(),
        binding: RootBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.BOOKING_AT_SALON,
        page: () => BookingView(),
        binding: RootBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PAYPAL,
        page: () => PayPalViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.RAZORPAY,
        page: () => RazorPayViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.STRIPE,
        page: () => StripeViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.STRIPE_FPX,
        page: () => StripeFPXViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PAYSTACK,
        page: () => PayStackViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.PAYMONGO,
        page: () => PayMongoViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.FLUTTERWAVE,
        page: () => FlutterWaveViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.CASH,
        page: () => CashViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.WALLET,
        page: () => WalletViewWidget(),
        binding: CheckoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.CUSTOM_PAGES,
        page: () => CustomPagesView(),
        binding: CustomPagesBinding()),
    GetPage(
        name: Routes.BOOKING_TICKET,
        page: () => BookingTicket(),
        binding: RootBinding()),
    GetPage(
        name: Routes.BOOKING_EMPLOYEE,
        page: () => BookingSelectEmployeeView(),
        binding: BookEServiceBinding()),
    GetPage(
        name: Routes.GALLERY,
        page: () => GalleryView(),
        binding: GalleryBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.WALLETS,
        page: () => WalletsView(),
        binding: WalletsBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.WALLET_FORM,
        page: () => WalletFormView(),
        binding: WalletsBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: Routes.NEWS,
      page: () => NewsView(),
    ),
    GetPage(
      name: Routes.NEWS_DETAILS,
      page: () => NewsDetails(),
    ),
    GetPage(
      name: Routes.QR_SCANNER,
      page: () => QrScanner(),
    )
  ];
}
