# Renn - Running
iOS application (SwiftUI) for running data and stats. This project is in its initial phase and currently displays basic views

## Architecture
The app follows a modular Clean Architecture combined with MVVM and a Coordinator system to ensure scalability, testability, and maintainability. Each layer has a clear responsibility and communicates only through well-defined interfaces.

The project is divided into independent modules:
- App:
    - Main app target, AppCoordinator, AppAssembly and DependencyContainer
    - It's main responsability is the creation and wiring of Coordinators, ViewModels, and global services
    - It consumes UseCases provided by the Application layer and injects them into the UI
- Domain:
    - Domain entities and repository protocols used by UseCases
    - This layer has no dependency on UI, database, or frameworks
- Application:
    - Contains the UseCase definition and their dependencies
    - This layer defines application-level actions (e.g. importing a FIT file, loading workouts, managing the user)
    - It knows what operations the app performs but doesn’t contain UI code
- Database:
    - Data models and mappers
    - Repository implementations (conforming to domain protocols)
    - Local persistence (SwiftData)
    - This layer transforms external data into Domain models
- GarminKit:
    - Handles parsing and mapping of Garmin .fit files into Database models
    - Based on FITSwiftSDK
    - Garmin DTO models
- Features: (Workouts, Profile, Launch, Search, WorkoutDetail)
    - Its own Coordinator
    - A RootView
    - An Assembly protocol
    - Local ViewModels
    - Features remain isolated and only depend on Domain + their UseCases.
- Localization: String localizations
- Common: Reusable components, entities....etc

## Features
- Garmin integration for reading fitness data
- Route mapping (MapKit) and real-time route tracking
- Workout history and session details
- Graphs (pace, heart rate, elevation, heart rate zones...etc)
- Goals, personal records, stats
- Widgets

## Requirements
- Xcode 26 or higher
- iOS 26 or higher
- Swift 6 or higher
