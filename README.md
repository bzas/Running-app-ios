# Renn - Running (Work in Progress)
iOS application (SwiftUI) for running data and stats. This project is in its initial phase and currently displays basic views

## Architecture

The app follows a modular Clean Architecture combined with MVVM and a Coordinator system to ensure scalability, testability, and maintainability. Each layer has a clear responsibility and communicates only through well-defined interfaces.

<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Architecture.svg" width="600" />

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
- Features: (Workouts, Profile, UserConfiguration, Search, WorkoutDetail)
    - Its own Coordinator
    - A RootView
    - An Assembly protocol
    - Local ViewModels
    - Features remain isolated and only depend on Domain + their UseCases.
- Localization: String localizations
- Common: Reusable components, entities....etc
- TestSupport:
    - Mocks for repositories and services
    - Shared helpers for unit tests across packages

## Features

<p align="left">
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Detail.PNG" width="275" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Profile.PNG" width="275" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/HeartRate.PNG" width="275" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/DetailInfo.PNG" width="275" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Metrics.PNG" width="275" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Workouts.PNG" width="275" />
</p>

- Garmin integration for reading fitness data
- Route mapping (MapKit) and real-time route tracking
- Workout history and session details
- Graphs (pace, heart rate, elevation, heart rate zones...etc)
- Goals, personal records, stats

## How it works

- Import a `.fit` file from Garmin: open the Workouts tab, tap the `+` button (top right) and pick a `.fit` file. The Garmin importer parses the FIT data (using `GarminKit`), persists it via SwiftData, and updates derived metrics (pace per km, HR zones, route coordinates, photos).
- Browse sessions: workouts are listed with name, time, distance, pace and HR highlights. Tap one to open the detail view with charts (pace, HR, elevation), map route, splits per km, photos, and metadata.
- Profile: See cumulative stats, activity grid, gallery, and HR zones tailored to the user.
- Configure user: Set basic profile and HR zones; data is used to compute zones and personalized insights.

## Requirements

- Xcode 26 or higher
- iOS 26 or higher
- Swift 6 or higher
