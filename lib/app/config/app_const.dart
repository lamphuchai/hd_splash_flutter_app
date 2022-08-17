class AppConst {
  static const String clientId = "";
  static const String clientSecret = "";
  static const String redirectUri = "hdsplash://unsplash-callback";
  static const String scope =
      "public+read_user+write_user+read_photos+write_photos+write_likes+write_followers+read_collections+write_collections";
  static const urlAddAccount =
      'https://unsplash.com/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=$scope';
  static const urlCreateAccount = "https://unsplash.com/join";

  static const prePage = 20;
}
