# RadioApp
![image1](https://github.com/user-attachments/assets/116e0ee3-9849-4a94-a101-244e0d5f5ddd)


# RadioApp — an app for iOS with radio stations of the world. Listen, save your favorite stations. Search for the necessary stations.

## Technologies
- Swift, SwiftUI
- Swift Modern Concurrency
- MVVM
- RadioBrowser API
- Firebase
- CoreData
- Kingfisher
- iOS 15.0 +


## Architecture and Design

The app follows modern software design principles:

- **MVVM Architecture** for separating business logic from UI.
- **Coordinator Pattern** for managing navigation, ensuring scalability and separation of concerns.
- **Factory Pattern** for creating views and their ViewModels dynamically.
- **Testing** The app is rigorously tested to ensure reliability and maintainability:
- Developed using **SOLID Principles**, ensuring maintainable, testable, and scalable code.

## Key Features

- **Modern Concurrency:** Efficient asynchronous operations using `async/await`.
- **Persistence:** Data stored using Core Data and images cached with Kingfisher.
- **Custom Animations:** Visually engaging equalizer animation in the Station screen.
- **Offline Support:** Cached data ensures functionality without internet.
