# Clean Architecture + SwiftUI

A practical iOS demo application built with **SwiftUI** and **Clean
Architecture**, demonstrating how to structure a scalable and testable
application using modern Swift concepts.

The application fetches users from a REST API and displays them in a
SwiftUI list.

## 🚀 Features

-   SwiftUI-based user interface
-   Clean Architecture
-   MVVM presentation layer
-   Async/await networking
-   REST API integration
-   Repository Pattern
-   Use Case pattern
-   Protocol-based Dependency Injection
-   DTO to Domain Model mapping
-   UI state management
-   Error handling
-   Unit testing with XCTest
-   Test doubles / Spies for dependency isolation

## 🏗️ Architecture

The project follows a layered Clean Architecture approach:

``` text
Presentation
     ↓
   Domain
     ↓
    Data
     ↓
    Core
```

### Dependency Flow

``` text
UserListView
      ↓
UserListViewModel
      ↓
GetUserUseCase
      ↓
UserRepositoryProtocol
      ↓
UserRepository
      ↓
UserAPIProtocol
      ↓
UserAPI
      ↓
NetworkClient
      ↓
URLSession
      ↓
REST API
```

Dependencies point toward abstractions rather than concrete
implementations wherever appropriate.

## 📁 Project Structure

``` text
Clean Architecture + SwiftUI
│
├── Presentation
│   ├── Views
│   │   ├── UserListView.swift
│   │   ├── LoadingView.swift
│   │   └── ErrorView.swift
│   │
│   └── ViewModels
│       └── UserListViewModel.swift
│
├── Domain
│   ├── Models
│   │   └── User.swift
│   │
│   ├── Repositories
│   │   └── UserRepositoryProtocol.swift
│   │
│   └── UseCases
│       ├── GetUserUseCase.swift
│       └── GetUserUseCaseProtocol.swift
│
├── Data
│   ├── API
│   │   ├── UserAPI.swift
│   │   └── UserAPIProtocol.swift
│   │
│   ├── DTOs
│   │   └── UserDTO.swift
│   │
│   └── Repositories
│       └── UserRepository.swift
│
├── Core
│   └── Networking
│       ├── NetworkClient.swift
│       ├── NetworkClientProtocol.swift
│       └── NetworkError.swift
│
└── Tests
    ├── Data
    │   └── UserRepositoryTests.swift
    ├── Domain
    │   └── GetUsersUseCaseTests.swift
    ├── Presentation
    │   └── UserListViewModelTests.swift
    └── Mock
        ├── UserAPISpy.swift
        ├── UserRepositorySpy.swift
        └── GetUsersUseCaseSpy.swift
```

## 🔄 Data Flow

When the application loads the user list:

``` text
UserListView
      │
      ▼
UserListViewModel
      │
      ▼
GetUserUseCase
      │
      ▼
UserRepository
      │
      ▼
UserAPI
      │
      ▼
NetworkClient
      │
      ▼
REST API
```

The API response is decoded into `UserDTO` objects.

The repository maps the DTO into the domain model:

``` text
UserDTO
   ↓
User
```

The domain model is then returned to the ViewModel and displayed by
SwiftUI.

## 🌐 API

This project uses the public **JSONPlaceholder** API:

`https://jsonplaceholder.typicode.com/users`

The response is decoded into `UserDTO` objects.

## 💉 Dependency Injection

Dependencies are injected through protocols.

For example:

``` swift
final class UserRepository: UserRepositoryProtocol {

    private let api: UserAPIProtocol

    init(api: UserAPIProtocol) {
        self.api = api
    }
}
```

This keeps the repository independent of the concrete API implementation
and makes it easier to test.

Production code can use `UserAPI`, while tests can use `UserAPISpy`.

``` text
Production:
UserRepository → UserAPI

Testing:
UserRepository → UserAPISpy
```

## 🧪 Unit Testing

The project includes unit tests for the major layers.

### ViewModel Tests

-   Successful user loading
-   Error handling
-   Use case invocation

### Repository Tests

-   DTO to Domain Model mapping
-   API failure handling

### Use Case Tests

-   Returning users from the repository
-   Propagating repository errors

Tests use spies instead of making real network requests.

Example:

``` text
UserListViewModel
        ↓
GetUserUseCaseSpy
```

This allows components to be tested independently.

## 🛠️ Technologies

-   **Swift**
-   **SwiftUI**
-   **Swift Concurrency**
-   **async/await**
-   **XCTest**
-   **URLSession**
-   **MVVM**
-   **Clean Architecture**
-   **Dependency Injection**
-   **Repository Pattern**

## 🎯 Purpose

This project was created as a practical demonstration of how to build a
**clean, modular, maintainable, and testable SwiftUI application**.

The primary focus is on architecture and separation of responsibilities
rather than application complexity.

## 📌 Key Architectural Principles

### Separation of Concerns

Each layer has a clearly defined responsibility.

### Dependency Inversion

Higher-level components depend on protocols rather than concrete
implementations.

### Testability

Dependencies can be replaced with test doubles, allowing unit tests
without making real network requests.

### Domain Independence

The Domain layer does not depend on SwiftUI, URLSession, or networking
implementation details.

## ▶️ Getting Started

1.  Clone the repository.
2.  Open the Xcode project.
3.  Select an iOS Simulator or connected device.
4.  Build and run the application.
5.  Run unit tests using:

``` text
⌘ + U
```

## 📚 Learning Goals

This project demonstrates practical understanding of:

-   Clean Architecture
-   MVVM
-   Protocol-oriented design
-   Dependency Injection
-   Repository Pattern
-   Use Case Pattern
-   REST API integration
-   Swift Concurrency
-   Error handling
-   Unit Testing
-   Testable architecture

------------------------------------------------------------------------

**Built with Swift & SwiftUI**
