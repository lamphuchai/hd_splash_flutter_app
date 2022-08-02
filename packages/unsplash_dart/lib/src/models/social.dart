// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Social {
  final String? instagramUsername;
  final String? portfolioUrl;
  final String? twitterUsername;
  final String? paypalEmail;
  Social({
    this.instagramUsername,
    this.portfolioUrl,
    this.twitterUsername,
    this.paypalEmail,
  });

  Social copyWith({
    String? instagramUsername,
    String? portfolioUrl,
    String? twitterUsername,
    String? paypalEmail,
  }) {
    return Social(
      instagramUsername: instagramUsername ?? this.instagramUsername,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      twitterUsername: twitterUsername ?? this.twitterUsername,
      paypalEmail: paypalEmail ?? this.paypalEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'instagramUsername': instagramUsername,
      'portfolioUrl': portfolioUrl,
      'twitterUsername': twitterUsername,
      'paypalEmail': paypalEmail,
    };
  }

  factory Social.fromMap(Map<String, dynamic> map) {
    return Social(
      instagramUsername: map['instagramUsername'] != null
          ? map['instagramUsername'] as String
          : null,
      portfolioUrl:
          map['portfolioUrl'] != null ? map['portfolioUrl'] as String : null,
      twitterUsername: map['twitterUsername'] != null
          ? map['twitterUsername'] as String
          : null,
      paypalEmail:
          map['paypalEmail'] != null ? map['paypalEmail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Social.fromJson(String source) =>
      Social.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Social(instagramUsername: $instagramUsername, portfolioUrl: $portfolioUrl, twitterUsername: $twitterUsername, paypalEmail: $paypalEmail)';
  }


}
