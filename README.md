# get_rx_persist

A flutter project makes your Rx value auto restore and persist.



## Features

- [x]  Easy to use
- [x]  Using in multiple real world projects
- [x]  Support All Platform
- [x]  Support Various Storage
- [x]  Support Customize Storage



## Maintenance
This project is maintaining.



## Install

`flutter pub add get_rx_persist`



## Usage

### Setup

```dart
import 'package:get_rx_persist/get_rx_persist.dart';

void main() async {
  await GetRxPersist.init(); // one step: call and await full restore
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

### Instance Value

#### Method 1: Implement One Interface

```dart
class ProfileDTO implements JsonSerializable {
	
}
```



### List & Set & Map



### Customize Storage