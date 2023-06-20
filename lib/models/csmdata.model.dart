class CSMData {
  final List<dynamic> regions;
  final List<dynamic> departments;
  final List<dynamic> organisers;
  final String getStartedPageTitle;
  final String getStartedPageLeoLogo;
  final String getStartedPageDistrictLogo;
  final List<dynamic> getStartedPageMessages;
  final String getStartedPageBtnText;
  final String getStartedPageFooterText;

  CSMData({
    required this.regions,
    required this.departments,
    required this.organisers,
    required this.getStartedPageTitle,
    required this.getStartedPageLeoLogo,
    required this.getStartedPageDistrictLogo,
    required this.getStartedPageMessages,
    required this.getStartedPageBtnText,
    required this.getStartedPageFooterText,
  });
}
