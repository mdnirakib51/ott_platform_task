
class NavItemModel{
  final String title;
  final String img;

  NavItemModel({
    required this.title,
    required this.img
  });
}

List<NavItemModel> navItemList = [
  NavItemModel(
      title: "Home",
      img: "assets/app_src/icon/home_ic.png"
  ),
  NavItemModel(
      title: "Search",
      img: "assets/app_src/icon/search_ic.png"
  ),
  NavItemModel(
      title: "Download",
      img: "assets/app_src/icon/download_ic.png"
  ),
  NavItemModel(
      title: "Account",
      img: "assets/app_src/icon/account_ic.png"
  ),

];