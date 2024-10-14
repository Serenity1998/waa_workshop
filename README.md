# SAVE TIME CUSTOMER (version upgraded)

Current version - Flutter 3.13.9
Current flutter channel - stable
Dart version - 3.1.5
Devtools - 2.25.0

## Project initialization
Note: for android development do not use Pixel 6 (simulator) it'll give a error due to pinhole cutout. 
Here is related link: https://stackoverflow.com/questions/73960094/flutter-how-do-i-get-rid-of-fatal-exception-screendecorations

### Dependency installation

1. Remove pubspec.lock file
2. Flutter pub get

#### Firebase configuration

1. Already generated for this project. Check lib/firebase_options.dart

#### To work with local BE

Windows: If you're using simulator(Android) first check your ip address with $ ipconfig command then start your Laravel BE with $ php artisan serve --host 192.168.1.XX --port 80
