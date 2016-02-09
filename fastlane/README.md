fastlane documentation
================
# Installation
```
sudo gem install fastlane
```
# Available Actions
## iOS
### ios test
```
fastlane ios test
```
Runs all the tests
### ios dailybuild
```
fastlane ios dailybuild
```
Submit a new daily build to TestFlight

A daily build is sent to Guava team by default
### ios beta
```
fastlane ios beta
```
Submit a new Beta Build to Apple TestFlight

This will also make sure the profile is up to date
### ios appstore
```
fastlane ios appstore
```
Deploy a new version to the App Store

----

This README.md is auto-generated and will be re-generated every time to run [fastlane](https://fastlane.tools).  
More information about fastlane can be found on [https://fastlane.tools](https://fastlane.tools).  
The documentation of fastlane can be found on [GitHub](https://github.com/fastlane/fastlane).