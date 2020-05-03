# The project
This is a simple iOS app project to list/add/delete names. 

To build the UI Swift and UIKit will be used, the domain will be build in C++ with Obj-C wrappers to expose the C++ to Swift code, there is also some code in Obj-C to expose NSUserDefaults to C++.

Cocoapods will be used for dependencies manager, it enables the use of a podspec for the C++ framework to be used in the UI project.

This is just a demo project to show the interactions between 3 diferente languages and could be used in a real app. **BUT** you should change how the data is saved! At the moment the data is saved in NSUserDefaults for demo porpuses only! ***Large amounts of data should not be saved in NSUserDefaults!***

# ExampleApp Project
Example app is our UIKit app written in Swift. It imports the Obj-C code that contains C++ to be used. 

Logic shouldn't depend on UI and vice versa so ***no domain logic shoud be in this project, only UI.***

## Project structure
For the iOS app, the MVVM and coordinator pattern are being used, and dependencies are being injected in the constructor. 

* Coordinator responsible for the navigation 
  * ViewControllers are dumb about navigation
  * There is a router object to handle presentation and navigation delegation and stack logic
* ViewController
  * hold main view and setup the user interface
  * is powered by the viewmodel
* ViewModel 
  * responsible to map the domain into the desired UI information
* Theme, responsible to style UI elements supporting dark mode

The binding of the view/view controller to the view model is being done manually, this could be done using the new Combine framework, ReactiveSwift, RxSwift or any other framework.

# ExampleFramework Pod
This framework is represented by a podspec to be used in a cocoapods install. 

This framework could also have a xcodeproj, with unit tests.

Everytime we change code in this project we need to rebuild the project or the changes won't be applied.

Removing files or adding new ones need a new pod install.

Logic shouldn't depend on UI and vice versa so ***no UI allowed in this pod.***


## Api Folder
The framework public interface. The code in here will be available in swift and Obj-C code using import because of the option "public_header_files" in podspec.

In this folder the interface is being defined:
* it should be clean and easy to understand 
* it should be flexible so it don't need to many changes after defining (because the users of the framework can't have their code broken everytime there is a new release)
* use protocols, Framework user's don't know need to know the implementation, they only need to know the existance of something that respects that protocol, if the user needs more information the framework might be bad designed or someone is trying to cheat the system
* ***don't even think in using sigletons in a framework!***
  * framework user should have total control of the framework life cycle
* if the framework need external dependencies, provide protocols for that dependencies, and implementations of that dependencies in a external framework, example:
  * your framework needs http requests, you should provide a interface for that, and the framework user can then use the http client they like more

### Classes & Protocols
* NamesServiceProtocol
  * protocol to represent a name service object
  * to be used in Swift or Obj-C code
  * it provices methods to add/delete/get name objects
* NamesServiceFactory
  * factory class to build name service objects
  * to be used in Swift or Obj-C code
* NameModelProtocol
  * protocol to represent a name object
  * to be used in Swift or Obj-C code
  * name object it's composed by a unique identifier, the name, and the history for that name
  * Framework user don't know the implementation of NameModelProtocol
* NameModelValidatorProtocol
  * protocol to represent a name validator object
  * to be used in Swift or Obj-C code
  * it provices methods to validate the name and the history for that name
  * Framework user don't know the implementation of NameModelValidatorProtocol


## Core Folder
Framework private implementation. All domain logic should be here and exposed only using Obj-C in the **Api Folder**.

### Classes & Protocols
* NamesService
  * The C++ implementation for NamesServiceProtocol
  * it provices methods to add/delete/get name objects
  * NamesService is exposed to Obj-C/Swift in the NamesServiceWrapper Obj-C class
* NameModel
  * The C++ implementation for NameModelProtocol
  * name object it's composed by a unique identifier, the name, and the history for that name
  * NameModel is exposed to Obj-C/Swift in the NameModelWrapper Obj-C class
* NameModelValidator
  * The C++ implementation for NameModelValidatorProtocol
  * it provices methods to validate the name and the history for that name
  * NameModelValidator is exposed to Obj-C/Swift in the NameModelValidatorWrapper Obj-C class
* IDataStore
  * C++ interface to be used to save our domain data
* AppleUserDefaults 
  * The Obj-C implementation of IDataStore that uses Apple NSUserDefaults
  * AppleUserDefaults is exposed to C++ in the AppleUserDefaultsWrapper C++ class
* NameModelSerializer
  * The C++ implementation for name model serialization
  * This class is not exposed to Obj-C or swift
* Logger
  * Loggin macro and function provider for C++, we could provide some external logging mechanism using a protocol, so the framework user could choose the logging implementation

# Other tools
* Cocoapods
  * https://cocoapods.org/
* SwiftLint
  * https://github.com/realm/SwiftLint
* SwiftGen
  * https://github.com/SwiftGen/SwiftGen


# Using C++ in Swift and Obj-C

The called Objective-C++, it enables the use of C++ in a file with the .mm extension.

Don't be tempted to assume you will need C++. Swift and Objc-C are both good languanges. The only acceptable reason is the need to build a cross platform framework:
* build the core in C++ and make wrappers with a JNI layer and a Obj-C layer
* if you need some resource that isn't available in C++ (camera, play sounds, etc.), write a new module in and make a wrapper to use in C++


Build small frameworks in C++ and write a layer in Objc-C to work with that C++ code.
* Avoid mixing both languages, always wrap C++ classes to be used in Obj-C and vice versa.
* Only use .mm extension when needed

