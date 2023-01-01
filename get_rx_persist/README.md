# get_rx_persist

A flutter project makes your Rx value auto restore and persist.
[check out exmaple](https://github.com/rua-flutter/get_rx_persist.dart/tree/main/get_rx_persist/exmaple/example.md)



## Features

- [x]  Easy to use
- [x]  Using in multiple real world projects
- [x]  Support all platform
- [x]  Support various and customized storage



## Supported Types

int, num, double, String, bool, Null, Object, List, Set, Map




## Maintenance
This project is maintaining.



## Install

`flutter pub add get_rx_persist`


## Storage

### Provided Storage

- DefaultStorageProvider/GetStorageProvider: use GetStorage as storage
- MemoryStorageProvider:  use memory as storage
- MockStorageProvider:  used for test,  provide some test helper methods, check source code for more info



### Customize Storage

Create a customized class that extends [**StorageProvider**](https://github.com/rua-flutter/get_rx_persist.dart/blob/main/get_rx_persist/lib/src/storage_provider.dart)

```dart
import 'package:get_rx_persist/src/storage_provider.dart';

// your customized storage provider
class CustomizedStorageProvider extends StorageProvider {
	// implements all abstract methods here
}
```

