# get_rx_persist

A flutter project makes your Rx value auto restore and persist.



## Features

- [x]  Easy to use
- [x]  Using in multiple real world projects
- [x]  Support All Platform
- [x]  Support Various Storage
- [x]  Support Customize Storage



## Supported Types

- [x] int
- [x] num
- [x] double
- [x] String
- [x] bool
- [x] Null
- [ ] Object
- [ ] Map
- [ ] List
- [ ] Set




## Maintenance
This project is maintaining.



## Install

`flutter pub add get_rx_persist`



## Usage

### Setup

```dart
import 'package:get_rx_persist/get_rx_persist.dart';

void main() async {
  await GetRxPersist.init(); // one step: call and await fully restore
  runApp(const App());
}
```

### Rx Primitive Value
```dart
class Profile {
  final name = 'Hello World'.obs.persist('profile.name');
  final age = 20.obs.persist('profile.age');
  final height = 70.1.obs.persist('profile.height');
  final male = true.obs.persist('profile.male');
}
```

### Object Value

There are two ways to persist object value.



#### Method 1: Serializable Object

```dart
class Profile {
  String? name;

  Profile({this.name});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  // REQUIRED: this is automatically used by [get_rx_persist]
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class User {
  final profile = Profile().obs.persist(
  	'user.profile',
    serializer: null, // you don't need it when you provided [.toJson()] method on Profile.
    deserializer: Profile.fromJson, // you NEED provide deserializer when you persist a object value.
  );
}
```



#### Method 2:  Serializer and Deserializer

```dart
class Profile {
  String? name;
  Profile({this.name});
}

class user {
  final profile = Profile().obs.persist(
  	'user.profile',
    serializer: (obj) => {'name': obj.name}, // REQUIRED
    deserializer: (jsonMap) => Profile({name: jsonMap['name']}), // REQUIRED
  );
}
```



### List & Set & Map





### Nested Rx Value

Modify your deserializer

```dart
class Profile {
  String? name;

  Profile({this.name});

  Profile.fromJson(Map<String, dynamic> json) {
    name = (json['name'] as String?).obs; // LOOK AT HERE!!!!!!!!!!!!!!
  }

  // REQUIRED: this is automatically used by [get_rx_persist]
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
```



### Customize Storage

Create a customized class that extends [**StorageProvider**](https://github.com/rua-flutter/get_rx_persist.dart/blob/main/get_rx_persist/lib/src/storage_provider.dart)

```dart
import 'package:get_rx_persist/src/storage_provider.dart';

// your customized storage provider
class CustomizedStorageProvider extends StorageProvider {
	// implements all abstract methods here
}
```

