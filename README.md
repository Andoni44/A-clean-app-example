# Vívora: A clean app example

With this project, I would like to show how to apply an architectural pattern like VIPER to implement a clean architecture.

## Clean Architecture and good practices

Based on the premise that inner layers should not depend on outer layers, we have one-directional flow from the presentation layer to the deepest one, the data components. Notice that a presenter and a VC have a bidirectional flow as they are from the same layer, although a presenter does not know anything about UIKit.

**Clean layering**

<img src="readmeResources/clean.png?raw=true" width="400" /> 

To achieve the previous point and also avoid coupling that can lead to hard testing, we have to take into account the following features:

- Dependency injection and control inversion: we have to decide what entities are going to be dependent on other ones. This feature, plus having a layering architecture, makes the app easier to test.

- Protocol oriented programming: classes should know nothing about their dependencies. This feature also makes test doubles creation easier.

- Single responsability: each entity should be responsible for one mission.

## Testing

Because VIPER has great modulation, we can easily test each component.

### TestDoubles 

Using protocol oriented programming makes testing easier regardless; we can simply create TestDoubles from protocols that classes that we want to test implement.

### Hard dependencies

Dependencies that can make our test a headpain, we can mock it by creating protocols, for example URLSession or UserDefaults(notice that it is recommended to create a userdefaults mock for testing due to timing and realability).

## Third party libs

We use here some interesting libraries:
- SDWebImage: for network image handling
- Lumberjack: for log creation
- Sourcery: this fantastic library allows us to create testdoubles automatically from desired protocols. Notice that VIPER has a lot of entities. This means that creating mocks by hand could be costly.
- Lottie: for awesome animations
- CryptoSwift: in order to handle som hashing

## Interesting features

- Search locally and on the internet
- Mostly code covered by tests
- Localization for English and Spanish
- Light and Dark modes
- Implementation of different configurations, schemes and targets

## Next objectives

- Implement favourites functionality
- UI testing independant from network
- Migrate to Async/Await
- Make collectionViews middle point cell to grow
- Add collectionViews cell titles

## Screenshots

**Light and Dark modes**

<img style="float: right;" src="readmeResources/s2.jpeg?raw=true" width="200" /> 

<img style="float: right;" src="readmeResources/s4.jpeg?raw=true" width="200" />

**Detail**

<img src="readmeResources/s3.jpeg?raw=true" width="200" />

**Search on the web**

<img src="readmeResources/s5.jpeg?raw=true" width="200" />
