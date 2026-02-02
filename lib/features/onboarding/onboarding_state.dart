abstract class OnboardingState {
  final int pageIndex;

  const OnboardingState(this.pageIndex);
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial() : super(0);
}

class OnboardingPageChanged extends OnboardingState {
  const OnboardingPageChanged(super.pageIndex);
}

class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted(super.pageIndex);
}
