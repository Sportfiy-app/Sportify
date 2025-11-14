import 'package:get/get.dart';

import '../modules/auth/bindings/forgot_password_binding.dart';
import '../modules/auth/bindings/login_binding.dart';
import '../modules/auth/views/login_email_view.dart';
import '../modules/auth/views/login_phone_view.dart';
import '../modules/auth/views/forgot_password_email_sent_view.dart';
import '../modules/auth/views/forgot_password_request_view.dart';
import '../modules/auth/views/forgot_password_verify_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_personal_information_view.dart';
import '../modules/register/views/register_terms_and_privacy_view.dart';
import '../modules/register/views/register_sms_validation_view.dart';
import '../modules/register/views/register_email_verification_view.dart';
import '../modules/register/views/register_add_photos_view.dart';
import '../modules/register/views/register_select_sports_view.dart';
import '../modules/register/views/register_push_notifications_view.dart';
import '../modules/register/views/register_premium_offer_view.dart';
import '../modules/register/views/register_subscription_choice_view.dart';
import '../modules/register/views/register_success_view.dart';
import '../modules/subscription/bindings/subscription_plan_binding.dart';
import '../modules/subscription/views/subscription_plan_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/favorites/bindings/favorite_places_binding.dart';
import '../modules/favorites/views/favorite_places_view.dart';
import '../modules/find_partner/bindings/find_partner_binding.dart';
import '../modules/find_partner/views/find_partner_view.dart';
import '../modules/find_partner/views/find_partner_profile_view.dart';
import '../modules/find_partner/views/find_partner_friends_list_view.dart';
import '../modules/find_partner/views/find_partner_private_request_view.dart';
import '../modules/find_partner/views/find_partner_profile_from_feed_view.dart';
import '../modules/find_partner/views/find_partner_profile_from_search_view.dart';
import '../modules/new_post/bindings/new_post_binding.dart';
import '../modules/new_post/views/new_post_view.dart';
import '../modules/bookings/views/booking_home_view.dart';
import '../modules/bookings/views/booking_place_detail_view.dart';
import '../modules/bookings/bindings/booking_binding.dart';
import '../modules/bookings/bindings/booking_detail_binding.dart';
import '../modules/bookings/bindings/cancel_reservation_binding.dart';
import '../modules/bookings/views/cancel_reservation_view.dart';
import '../modules/find_partner/bindings/post_detail_binding.dart';
import '../modules/find_partner/views/post_detail_view.dart';
import '../modules/find_partner/bindings/post_comments_binding.dart';
import '../modules/find_partner/views/post_comments_view.dart';
import '../modules/find_partner/views/post_detail_search_view.dart';
import '../modules/find_partner/views/post_detail_user_view.dart';
import '../modules/search/bindings/search_results_binding.dart';
import '../modules/search/views/search_results_view.dart';
import '../modules/bookings/views/booking_loading_view.dart';
import '../modules/bookings/views/payment_loading_view.dart';
import '../modules/bookings/views/booking_confirmation_view.dart';
import '../modules/map_explore/bindings/map_explore_binding.dart';
import '../modules/map_explore/views/map_explore_view.dart';
import '../modules/chat/bindings/chat_detail_binding.dart';
import '../modules/chat/views/chat_detail_view.dart';
import '../modules/chat/bindings/chat_conversations_binding.dart';
import '../modules/chat/views/chat_conversations_view.dart';
import '../modules/friends/bindings/friend_requests_binding.dart';
import '../modules/friends/views/friend_requests_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/bindings/profile_annonces_binding.dart';
import '../modules/profile/views/profile_annonces_view.dart';
import '../modules/profile/bindings/profile_bookings_binding.dart';
import '../modules/profile/views/profile_bookings_view.dart';
import '../modules/profile/bindings/profile_friends_binding.dart';
import '../modules/profile/views/profile_friends_view.dart';
import '../modules/profile/bindings/profile_saved_announcements_binding.dart';
import '../modules/profile/views/profile_saved_announcements_view.dart';
import '../modules/profile/bindings/profile_edit_binding.dart';
import '../modules/profile/views/profile_edit_view.dart';
import '../modules/profile/bindings/profile_info_binding.dart';
import '../modules/profile/views/profile_info_view.dart';
import '../modules/profile/bindings/profile_sports_binding.dart';
import '../modules/profile/views/profile_sports_view.dart';
import '../modules/profile/bindings/profile_blocked_users_binding.dart';
import '../modules/profile/views/profile_blocked_users_view.dart';
import '../modules/profile/bindings/profile_payment_binding.dart';
import '../modules/profile/views/profile_payment_view.dart';
import '../modules/profile/bindings/profile_security_binding.dart';
import '../modules/profile/views/profile_security_view.dart';
import '../modules/profile/bindings/profile_security_email_binding.dart';
import '../modules/profile/views/profile_security_email_view.dart';
import '../modules/profile/bindings/profile_security_password_binding.dart';
import '../modules/profile/views/profile_security_password_view.dart';
import '../modules/profile/bindings/profile_security_phone_binding.dart';
import '../modules/profile/views/profile_security_phone_view.dart';
import '../modules/profile/bindings/profile_security_phone_verify_binding.dart';
import '../modules/profile/views/profile_security_phone_verify_view.dart';
import '../modules/profile/bindings/profile_actions_binding.dart';
import '../modules/profile/views/profile_actions_view.dart';
import '../modules/profile/bindings/profile_delete_account_binding.dart';
import '../modules/profile/views/profile_delete_account_view.dart';
import '../modules/profile/bindings/profile_settings_binding.dart';
import '../modules/profile/views/profile_settings_view.dart';
import '../modules/profile/bindings/profile_terms_binding.dart';
import '../modules/profile/views/profile_terms_view.dart';
import '../modules/profile/bindings/profile_help_binding.dart';
import '../modules/profile/views/profile_help_view.dart';
import '../modules/profile/bindings/profile_language_binding.dart';
import '../modules/profile/views/profile_language_view.dart';
import '../modules/photos/bindings/full_screen_photos_binding.dart';
import '../modules/photos/views/full_screen_photos_view.dart';
import '../modules/support/bindings/report_problem_binding.dart';
import '../modules/support/views/report_problem_view.dart';
import '../modules/support/bindings/report_confirmation_binding.dart';
import '../modules/support/views/report_confirmation_view.dart';
import '../modules/groups/bindings/groups_binding.dart';
import '../modules/groups/views/groups_view.dart';
import '../modules/create_event/bindings/create_event_binding.dart';
import '../modules/create_event/views/create_event_view.dart';
import '../modules/create_event/views/create_event_success_view.dart';
import '../modules/event_detail/bindings/event_detail_binding.dart';
import '../modules/event_detail/views/event_detail_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.splash,
      page: SplashView.new,
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.intro, page: IntroView.new, binding: IntroBinding()),
    GetPage(
      name: Routes.loginEmail,
      page: LoginEmailView.new,
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.loginPhone,
      page: LoginPhoneView.new,
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.forgotPasswordRequest,
      page: ForgotPasswordRequestView.new,
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.forgotPasswordVerify,
      page: ForgotPasswordVerifyView.new,
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.forgotPasswordEmailSent,
      page: ForgotPasswordEmailSentView.new,
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.registerPersonalInformation,
      page: RegisterPersonalInformationView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerTermsAndPrivacy,
      page: RegisterTermsAndPrivacyView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerSmsValidation,
      page: RegisterSmsValidationView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerEmailVerification,
      page: RegisterEmailVerificationView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerAddPhotos,
      page: RegisterAddPhotosView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerSelectSports,
      page: RegisterSelectSportsView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerPushNotifications,
      page: RegisterPushNotificationsView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerPremiumOffer,
      page: RegisterPremiumOfferView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerSubscriptionChoice,
      page: RegisterSubscriptionChoiceView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerSuccess,
      page: RegisterSuccessView.new,
      binding: RegisterBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.subscriptionPlan,
      page: SubscriptionPlanView.new,
      binding: SubscriptionPlanBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.groups,
      page: GroupsView.new,
      binding: GroupsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.favoritePlaces,
      page: FavoritePlacesView.new,
      binding: FavoritePlacesBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(name: Routes.home, page: HomeView.new, binding: HomeBinding()),
    GetPage(
      name: Routes.bookingHome,
      page: BookingHomeView.new,
      binding: BookingBinding(),
    ),
    GetPage(
      name: Routes.bookingPlaceDetail,
      page: BookingPlaceDetailView.new,
      binding: BookingDetailBinding(),
    ),
    GetPage(
      name: Routes.cancelReservation,
      page: CancelReservationView.new,
      binding: CancelReservationBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.bookingLoading,
      page: BookingLoadingView.new,
    ),
    GetPage(
      name: Routes.paymentLoading,
      page: PaymentLoadingView.new,
    ),
    GetPage(
      name: Routes.bookingConfirmation,
      page: BookingConfirmationView.new,
      binding: BookingBinding(),
    ),
    GetPage(
      name: Routes.mapVenues,
      page: MapExploreView.new,
      binding: MapExploreBinding(),
    ),
    GetPage(
      name: Routes.chatConversations,
      page: ChatConversationsView.new,
      binding: ChatConversationsBinding(),
    ),
    GetPage(
      name: Routes.chatDetail,
      page: ChatDetailView.new,
      binding: ChatDetailBinding(),
    ),
    GetPage(
      name: Routes.friendRequests,
      page: FriendRequestsView.new,
      binding: FriendRequestsBinding(),
    ),
    GetPage(
      name: Routes.notifications,
      page: NotificationsView.new,
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: ProfileView.new,
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.profileEdit,
      page: ProfileEditView.new,
      binding: ProfileEditBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.profileInfo,
      page: ProfileInfoView.new,
      binding: ProfileInfoBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.profileSports,
      page: ProfileSportsView.new,
      binding: ProfileSportsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.profileBlockedUsers,
      page: ProfileBlockedUsersView.new,
      binding: ProfileBlockedUsersBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.profilePaymentCard,
      page: ProfilePaymentView.new,
      binding: ProfilePaymentBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    GetPage(
      name: Routes.profileSecurity,
      page: ProfileSecurityView.new,
      binding: ProfileSecurityBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.profileSecurityEmail,
      page: ProfileSecurityEmailView.new,
      binding: ProfileSecurityEmailBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.profileSecurityPassword,
      page: ProfileSecurityPasswordView.new,
      binding: ProfileSecurityPasswordBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.profileSecurityPhone,
      page: ProfileSecurityPhoneView.new,
      binding: ProfileSecurityPhoneBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.profileSecurityPhoneVerify,
      page: ProfileSecurityPhoneVerifyView.new,
      binding: ProfileSecurityPhoneVerifyBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.profileActions,
      page: ProfileActionsView.new,
      binding: ProfileActionsBinding(),
    ),
    GetPage(
      name: Routes.profileDeleteAccount,
      page: ProfileDeleteAccountView.new,
      binding: ProfileDeleteAccountBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.profileSettings,
      page: ProfileSettingsView.new,
      binding: ProfileSettingsBinding(),
    ),
    GetPage(
      name: Routes.profileHelp,
      page: ProfileHelpView.new,
      binding: ProfileHelpBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.profileLanguage,
      page: ProfileLanguageView.new,
      binding: ProfileLanguageBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.profileTermsPrivacy,
      page: ProfileTermsView.new,
      binding: ProfileTermsBinding(),
    ),
    GetPage(
      name: Routes.profileAnnonces,
      page: ProfileAnnoncesView.new,
      binding: ProfileAnnoncesBinding(),
    ),
    GetPage(
      name: Routes.profileBookings,
      page: ProfileBookingsView.new,
      binding: ProfileBookingsBinding(),
    ),
    GetPage(
      name: Routes.profileFriends,
      page: ProfileFriendsView.new,
      binding: ProfileFriendsBinding(),
    ),
    GetPage(
      name: Routes.profileSavedAnnouncements,
      page: ProfileSavedAnnouncementsView.new,
      binding: ProfileSavedAnnouncementsBinding(),
    ),
    GetPage(
      name: Routes.fullScreenPhotos,
      page: FullScreenPhotosView.new,
      binding: FullScreenPhotosBinding(),
    ),
    GetPage(
      name: Routes.reportProblem,
      page: ReportProblemView.new,
      binding: ReportProblemBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.reportConfirmation,
      page: ReportConfirmationView.new,
      binding: ReportConfirmationBinding(),
      fullscreenDialog: true,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.findPartner,
      page: FindPartnerView.new,
      binding: FindPartnerBinding(),
    ),
    GetPage(
      name: Routes.findPartnerProfile,
      page: FindPartnerProfileView.new,
      binding: FindPartnerBinding(),
    ),
        GetPage(
          name: Routes.findPartnerPrivateRequest,
          page: FindPartnerPrivateRequestView.new,
          binding: FindPartnerBinding(),
        ),
        GetPage(
          name: Routes.findPartnerFriends,
          page: FindPartnerFriendsListView.new,
          binding: FindPartnerBinding(),
        ),
        GetPage(
          name: Routes.findPartnerProfileFromFeed,
          page: FindPartnerProfileFromFeedView.new,
          binding: FindPartnerBinding(),
        ),
        GetPage(
          name: Routes.findPartnerProfileFromSearch,
          page: FindPartnerProfileFromSearchView.new,
          binding: FindPartnerBinding(),
        ),
        GetPage(
          name: Routes.newPost,
          page: NewPostView.new,
          binding: NewPostBinding(),
        ),
    GetPage(
      name: Routes.searchResults,
      page: SearchResultsView.new,
      binding: SearchResultsBinding(),
    ),
    GetPage(
      name: Routes.postDetails,
      page: PostDetailView.new,
      binding: PostDetailBinding(),
    ),
    GetPage(
      name: Routes.postComments,
      page: PostCommentsView.new,
      binding: PostCommentsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.postDetailsFromSearch,
      page: PostDetailSearchView.new,
      binding: PostDetailBinding(),
    ),
    GetPage(
      name: Routes.postDetailsFromUser,
      page: PostDetailUserView.new,
      binding: PostDetailBinding(),
    ),
    GetPage(
      name: Routes.createEvent,
      page: CreateEventView.new,
      binding: CreateEventBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.createEventSuccess,
      page: CreateEventSuccessView.new,
      binding: CreateEventBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.eventDetail,
      page: () => const EventDetailView(),
      binding: EventDetailBinding(),
    ),
  ];
}
