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
### ios screens
```
fastlane ios screens
```
Creates new screenshots and uploads them to iTunes Connect
### ios beta
```
fastlane ios beta
```
Release a new beta version on TestFlight

This action does the following:



- Verifies API keys are non-empty

- Ensures a clean git status

- Increment the build number

- Build and sign the app

- Upload the ipa file to testFlight

- Post a message to slack containing the download link

- Commit and push the version bump
### ios weeklybuild
```
fastlane ios weeklybuild
```
Submit a new weekly build to Apple TestFlight

A weekly build is sent to Guava team by default
### ios appstore
```
fastlane ios appstore
```
Deploy a new version to the App Store

----

This README.md is auto-generated and will be re-generated every time to run [fastlane](https://fastlane.tools).
More information about fastlane can be found on [https://fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [GitHub](https://github.com/fastlane/fastlane/tree/master/fastlane).