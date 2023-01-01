# GetRx Persist Examples

## 0. Setup

### ALWAYS REMEMBER TO DO THIS!!!!!!!

```dart
import 'package:get_rx_persist/get_rx_persist.dart';

void main() async {
  await GetRxPersist.init(); // this line is important!!!!
  runApp(const App());
}
```



## 1. Primitive Usage

```dart
class Product {
  final name = 'Code'.obs.persist('product.name'); // the key [product.name] you can change to anything you like
  final createdAt = 123141212412.obs.persist('product.createdAt');
  final isOnTop = false.obs.persist('product.isOnTop');
  
  final Rx<String> introduction = Rx<String>('free to use').persist('product.introduction');
}
```



## 2. Nullable Usage

```dart
class Product {
  final uuid = Rx<String?>(null).obs.persist('product.uuid');
}

Production().uuid.value = null;
Production().uuid.value = 'uuid';
```



## 3. Object Usage

There are two ways to persist object value.



#### Method 1: Serializable Object

you can use [online json to dart convertor](https://javiercbk.github.io/json_to_dart/) to generate serializable object.

NOTE: you do **NOT** need serializer for serializable object.

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

