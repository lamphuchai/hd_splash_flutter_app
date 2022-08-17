# HDSPLASH APP

## Introduction
The app uses the unsplash api to view photos, collections, topics, search and log in to an unsplash account to perform basic tasks.
- [Video demo](https://www.youtube.com/watch?v=0HPunV5OalU&t)
## Contents
   - [Features](#features)
   - [Setups](#setups)
   - [Screens](#screens)
   - [Library and technology](#library-and-technology)



## **Features**
- Photos:
    * List photos
    * Detail photo
    * Download photo
- Collections:
    * List collections
    * Detail collection
- Topics :
    * List topics
    * Detail topic
- Search :
    * Photo
    * Collection
    * User
- Login to the app using Unsplash:
    * View profile
    * Edit profile
    * Collection:
        * Create new collection
        * Edit collection 
        * Delete collection
    * Photo:
        * Like photo
        * Unlike photo
        * Add photo in collection
        * Remove photo in collection
- Setting:
    * Language:
        * UN
        * VN
    * Theme :
        * System
        * Light
        * Dark
    * Layout gird:
        * 1
        * 2
        * 3



## **Setups**
- Clone repository:
    ```
    $ git clone https://github.com/lamphuchai/hd_splash_flutter_app
- Create app on [unsplash](https://unsplash.com/developers) to get Access Key and Secret Key
- Thêm key Access Key và Secret Key vào Hdsplash

    ```path
    path : hd_splash_flutter/lib/app/config/app_const.dart
    ```
    ```dart
    static const String clientId = "Access Key";
    static const String clientSecret = "Secret Key";
    ```
- Run command directory project Hdsplash:
    ```
    $ flutter pub get
- Then open the development tool and run the application on the virtual machine.


## **Screens**
- [Photos](#photos)
- [Collections](#collections)
- [Topics](#topics)
- [Search](#search)
- [Setting](#setting)
- [User](#user)

### **Photos**

<img width="200" src="screenshots/photos/photos01.24.12.png"></a>
<img width="200" src="screenshots/photos/photos01.24.37.png"></a>
<img width="200" src="screenshots/photos/photos01.24.16.png"></a>
<img width="200" src="screenshots/photos/photos01.24.42.png"></a>
<img width="200" src="screenshots/photos/photos01.25.42.png"></a>
<img width="200" src="screenshots/photos/photos01.27.43.png"></a>
<img width="200" src="screenshots/photos/photos01.25.19.png"></a>
<img width="200" src="screenshots/photos/photos01.25.30.png"></a>
<img width="200" src="screenshots/photos/photos01.25.48.png"></a>
<img width="200" src="screenshots/photos/photos01.25.54.png"></a>

### **Collections**

<img width="200" src="screenshots/collections/collections-01.36.58.png"></a>
<img width="200" src="screenshots/collections/collections-01.38.16.png"></a>
<img width="200" src="screenshots/collections/collections-01.37.09.png"></a>
<img width="200" src="screenshots/collections/collections-01.38.20.png"></a>
<img width="200" src="screenshots/collections/collections-01.38.24.png"></a>
<img width="200" src="screenshots/collections/collections-01.37.15.png"></a>
<img width="200" src="screenshots/collections/collections-01.37.24.png"></a>
<img width="200" src="screenshots/collections/collections-01.37.51.png"></a>
<img width="200" src="screenshots/collections/collections-01.37.56.png"></a>
<img width="200" src="screenshots/collections/collections-01.38.02.png"></a>


### **Topics**

<img width="200" src="screenshots/topics/topics-01.44.35.png"></a>
<img width="200" src="screenshots/topics/topics-01.44.41.png"></a>
<img width="200" src="screenshots/topics/topics-01.44.45.png"></a>
<img width="200" src="screenshots/topics/topics-01.44.49.png"></a>
<img width="200" src="screenshots/topics/topics-01.45.01.png"></a>
<img width="200" src="screenshots/topics/topics-01.45.05.png"></a>
<img width="200" src="screenshots/topics/topics-01.45.13.png"></a>

### **Tìm kiếm**

<img width="200" src="screenshots/search/search-07.41.10.png"></a>
<img width="200" src="screenshots/search/search-07.50.19.png"></a>
<img width="200" src="screenshots/search/search-07.50.24.png"></a>
<img width="200" src="screenshots/search/search-07.50.51.png"></a>
<img width="200" src="screenshots/search/search-07.50.56.png"></a>

### **Cài đặt**

<img width="200" src="screenshots/setting/setting-07.54.02.png"></a>
<img width="200" src="screenshots/setting/setting-07.55.11.png"></a>
<img width="200" src="screenshots/setting/setting-07.54.15.png"></a>
<img width="200" src="screenshots/setting/setting-07.54.19.png"></a>
<img width="200" src="screenshots/setting/setting-07.54.23.png"></a>
<img width="200" src="screenshots/setting/setting-07.54.31.png"></a>
<img width="200" src="screenshots/setting/setting-07.54.42.png"></a>
<img width="200" src="screenshots/setting/setting-07.55.09.png"></a>

### **User**

<img width="200" src="screenshots/user/user-07.58.34.png"></a>
<img width="200" src="screenshots/user/user-07.58.16.png"></a>
<img width="200" src="screenshots/user/user-07.58.38.png"></a>
<img width="200" src="screenshots/user/user-08.02.36.png"></a>
<img width="200" src="screenshots/user/user-08.02.18.png"></a>
<img width="200" src="screenshots/user/user-07.58.41.png"></a>
<img width="200" src="screenshots/user/user-07.58.44.png"></a>
<img width="200" src="screenshots/user/user-07.59.05.png"></a>
<img width="200" src="screenshots/user/user-07.59.21.png"></a>
<img width="200" src="screenshots/user/user-08.00.03.png"></a>



## **Library and technology**

*   [Unsplash Api](https://unsplash.com/developers)
*	[Flutter](https://flutter.dev/)
*	[Pub.dev](https://pub.dev/)
*	[Bloc](https://github.com/felangel/bloc)
