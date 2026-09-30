# Clean Architecture + SwiftUI

A practical iOS demo application built with **SwiftUI** and **Clean Architecture**, demonstrating how to structure a scalable and testable application using modern Swift concepts.

The application fetches users from a REST API and displays them in a SwiftUI list.

## 🚀 Features

- SwiftUI-based user interface
- Clean Architecture
- MVVM presentation layer
- Async/await networking
- REST API integration
- Repository Pattern
- Use Case pattern
- Protocol-based Dependency Injection
- DTO to Domain Model mapping
- UI state management
- Error handling
- Unit testing with XCTest
- Test doubles / Spies for dependency isolation

## 🏗️ Architecture

The project follows a layered Clean Architecture approach:

```text
Presentation
     ↓
   Domain
     ↓
    Data
     ↓
    Core
