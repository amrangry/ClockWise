
# ClockWise
ClockWise is a lightweight Swift utilities 

<p align="center">
  <img src ="https://github.com/amrangry/ClockWise/blob/master/logo.png?raw=true"/>
</p>

[![CI Status](https://img.shields.io/travis/amrangry/ClockWise.svg?style=flat)](https://travis-ci.org/amrangry/ClockWise)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/amrangry/ClockWise/blob/master/LICENSE)

[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg)](https://cocoapods.org/pods/ClockWise) [![Version](https://img.shields.io/cocoapods/v/ClockWise.svg?style=flat)](https://cocoapods.org/pods/ClockWise)

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager) ![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/amrangry/ClockWise?sort=semver)

![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/ClockWise.svg?style=flat)](https://cocoapods.org/pods/ClockWise)
![](https://img.shields.io/badge/Platform-iOS-orange) <img src="https://img.shields.io/badge/minimum%20iOS%20version-10-red"> 

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/amrangry/ClockWise)
![GitHub last commit](https://img.shields.io/github/last-commit/amrangry/ClockWise)
![GitHub forks](https://img.shields.io/github/forks/amrangry/ClockWise?style=social)
![GitHub stars](https://img.shields.io/github/stars/amrangry/ClockWise?style=social)

[![Twitter Follow](https://img.shields.io/twitter/follow/amr_elghadban?style=social)](https://twitter.com/intent/follow?screen_name=amr_elghadban)


# Simplified iOS Utilities
This is a collection of utilities I used in many projects, the Simplified suite of products and code bases for iOS.

# Objectives
Generality: the classes and functions should be general-purpose enough to be used independently of the product they are used in.
Absolutely no third party dependencies: we want to be able to use this module anywhere without any additional requirements.
Testability: every utility should be easily unit-testable.


## Table of Contents
* [Getting Started](##getting-started-installation)
    - [CocoaPods](#CocoaPods)
    - [Swift Package Manager (SPM)](#swift-package-manager-spm)
    - [Manually](#Manually)
* [How it works "Usage"](##how-it-works-usage)
* [Exmple](#Example)
* [Supported OS & SDK Versions](#supported-os--sdk-versions)
* [Versioning](#Versioning)
* [TODO](#todo)
* [Contributing](#contributing)
    - [Development](#development)
    - [Feedback](#feedback)
* [CHANGELOG](#changelog)
* [Related Projects](#related-projects)
* [Author](#Author)
* [License](#license)

## Getting Started "Installation"

### CocoaPods
ClockWise is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ClockWise'
```
https://cocoapods.org/pods/ClockWise

### Swift Package Manager (SPM)
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. To integrate using Apple's Swift package manager from xcode :

File -> Swift Packages -> Add Package Dependency...

enter package URL : https://github.com/amrangry/ClockWise.git , choose the latest release

### Manually
To install manually the ClockWise classes in your app, just drag the Source class files (demo files and assets are not needed) into your project.

Add content of folder Source/* to your project

## How it works "Usage"
1. Import `ClockWise` module to your `Swift` class
```swift
    import ClockWise
```
2. Enjoy

# Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Supported OS & SDK Versions

* Supported build target - iOS 10.0 and later (Xcode 11.x)

## Versioning

this project adheres to [Semantic versioning](https://semver.org/)

Given a version number MAJOR.MINOR.PATCH, increment the:

- MAJOR version when you make incompatible API changes,
- MINOR version when you add functionality in a backwards compatible manner, and
- PATCH version when you make backwards compatible bug fixes.

## TODO

* [x] Segregate UIKit & Foundation
* [ ] CI/CD 
* [ ] More test test test ... (and example)

## Contributing

We alway welcome your contributions :clap:

### Development

1. Fork (https://github.com/amrangry/ClockWise) :tada:
1. Create a feature branch :coffee:
1. Run test suite with the `$ make test` command and confirm that it passes :zap:
1. Commit your changes :memo:
1. Rebase your local changes against the `master` branch :bulb:
1. Create new Pull Request :love_letter:

Bugs, feature requests and comments are more than welcome in the [issues](https://github.com/amrangry/ClockWise/issues).

### Feedback

I would like to make `ClockWise` a better tool.  
The goal is to be able to use in various projects.

Therefore, your feedback is very useful.  
I am very happy to tell you your opinions on Issues and PR :heart:

## CHANGELOG

See [CHANGELOG.md](./CHANGELOG.md)

#### Let us know! Apps using ClockWise

We’d be really happy if you sent us links to your projects where you use our component. Just send an email to amr.elghadban@adkatech.com And do let us know if you have any questions or suggestion regards.

- [MotoShop](https://itunes.apple.com/ua/app/).
- [Awoon](https://apps.apple.com/us/app/awoon/id1342324842).

## Author

AmrAngry, <a href="amr.elghadban@gmail.com">amr.elghadban@gmail.com</a>

[![Twitter Follow](https://img.shields.io/twitter/follow/amr_elghadban?style=social)](https://twitter.com/intent/follow?screen_name=amr_elghadban)

[![Linkedin](https://img.shields.io/badge/Lets%20Connect%20via-LinkedIn-blue)](https://www.linkedin.com/in/amrelghadban/)


## License

ClockWise is available under the MIT license. See the [LICENSE](https://github.com/amrangry/ClockWise/blob/master/LICENSE) file for more info.
