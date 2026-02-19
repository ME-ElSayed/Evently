import "package:eventsmanager/core/constants/app_image_asset.dart";
import "package:eventsmanager/features/onboarding/data/model/on_boarding_model.dart";

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title: "Discover events in your government",
      body:
          "Never miss a town hall meeting or community gathering again. Get notified about events that matter to your neighborhood.",
      image: AppImageAsset.onBoardingImageOne),
  OnBoardingModel(
      title: "Attend events with QR-based check-in",
      body:
          "Say goodbye to long lines and paper tickets. Access your unique QR code  instantly for a seamless entry experience",
      image: AppImageAsset.onBoardingImageTwo),
  OnBoardingModel(
      title: "Create and manage your own events",
      body:
          "Effortlessly set up dates, manage guest lists, and track RSVPs all in one place. Your perfect event starts here.",
      image: AppImageAsset.onBoardingImageThree),
  OnBoardingModel(
      title: "You're All Set!",
      body:
          "Start creating memorable events and managing your guests with ease. Let's dive in.",
      image: AppImageAsset.onBoardingImagefour)
];
