

// class AuthenService {
//   Future<void> currentUser() async {
//     final data = await DioClient.get('/me');
//   }

//   Future<void> updateUser(
//       {String? username,
//       String? firstName,
//       String? lastName,
//       String? email,
//       String? url,
//       Location? location,
//       String? bio,
//       String? instagramUsername}) async {
//     final data = await DioClient.put('/me', queryParameters: {
//       "username": username,
//       "first_name": firstName,
//       "last_name": lastName,
//       "email": email,
//       "url": url,
//       "location": location?.toMap(),
//       "bio": bio,
//       "instagram_username": instagramUsername,
//     });
//   }
// }
