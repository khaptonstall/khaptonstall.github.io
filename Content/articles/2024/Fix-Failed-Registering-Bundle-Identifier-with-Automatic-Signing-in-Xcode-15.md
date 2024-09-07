# Fix “Failed Registering Bundle Identifier” with Automatic Signing in Xcode 15

# Problem

Using Automatic Signing in Xcode 15.4, I received a “Failed Registering Bundle Identifier” error when I went to go add a new Capability for one of my Targets:

![](images/3CC89754-611B-41FE-A4B8-FCD084BE7DB8.png)

While the error message states:

> **The app identifier “…” cannot be registered to your development team because it is not available.** Change your bundle identifier to a unique string to try again.

the app identifier (Bundle Identifier) was already registered under my account in App Store Connect, and signing was previously working prior to adding a new Capability (which updates the Provisioning Profile).

# Solution

The solution was to prefix my Bundle Identifier in Xcode with my Apple Developer Team ID (which can be found at [https://developer.apple.com/account](https://developer.apple.com/account) under Membership Details).