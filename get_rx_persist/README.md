# get_rx_persist

A flutter project makes your Rx value auto restore and persist.



[![pub package](https://img.shields.io/pub/v/get_rx_persist?style=flat)](https://pub.dev/packages/get_rx_persist) ![license](https://img.shields.io/github/license/rua-flutter/get_rx_persist.dart?style=flat)  [![stars](https://img.shields.io/github/stars/rua-flutter/get_rx_persist.dart?style=social)](https://github.com/rua-flutter/get_rx_persist.dart/tree/main/get_rx_persist)

## Examples

[check out](https://github.com/rua-flutter/get_rx_persist.dart/blob/main/get_rx_persist/example/example.md)



## Features

- Easy to use

- Support all platform

- Support various and customized storage

- Using in multiple real world projects

- 100% test coverage



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



### Customized Storage

Create a customized class that extends [**StorageProvider**](https://github.com/rua-flutter/get_rx_persist.dart/blob/main/get_rx_persist/lib/src/storage_provider.dart)

```dart
import 'package:get_rx_persist/src/storage_provider.dart';

// your customized storage provider
class CustomizedStorageProvider extends StorageProvider {
	// implements all abstract methods here
}
```

