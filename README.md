# google_services.

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

An example application built with dart_frog

First of all please add a uuid for FCM service and add value on it which ddefined in service.dart

## Exapmle Curl
``` Dart 
curl -X POST "https://your-google-services-domain.com/push-services/{uuid}/send" \
     -H "Accept: application/json" \
     -H "Content-Type: application/json" \
     -d '{
           "to": "device_token_or_topic",
           "notification": {
               "title": "Hello",
               "body": "This is a test message"
           },
           "data": {
               "customKey": "customValue"
           }
         }'

```

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
