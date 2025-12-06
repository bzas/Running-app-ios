# 🏃‍♂️ Renn - Running
![CI](https://github.com/bzas/Running-app-ios/actions/workflows/ci.yml/badge.svg?branch=develop)
  [![Unit Tests Coverage](https://img.shields.io/codecov/c/gh/bzas/Running-app-ios?branch=develop&label=Unit%20Tests%20Coverage)](https://codecov.io/gh/bzas/Running-app-ios)
  
iOS application (SwiftUI, Clean Architecture, Coordinators, MVVM) for running data and stats. It imports Garmin `.fit` files, stores workouts with SwiftData, and presents charts/routes while keeping navigation and data flow split into small, testable modules (Workouts, Profile, UserConfiguration, Search, WorkoutDetail) wired through coordinators and use cases.

## 🧱 Architecture

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

## 📱 Features

<p align="left">
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Detail.PNG" width="250" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Profile.PNG" width="250" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/HeartRate.PNG" width="250" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/DetailInfo.PNG" width="250" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Metrics.PNG" width="250" />
<img src="https://github.com/bzas/bzas/blob/main/images/Renn/Workouts.PNG" width="250" />
</p>

- Garmin integration for reading fitness data
- Route mapping (MapKit) and real-time route tracking
- Workout history and session details
- Graphs (pace, heart rate, elevation, heart rate zones...etc)
- Goals, personal records, stats
- VoiceOver-ready UI (key lists, placeholders, and summaries have accessibility labels/hints)

## 🔎 How it works

- Import a `.fit` file from Garmin: open the Workouts tab, tap the `+` button (top right) and pick a `.fit` file. The Garmin importer parses the FIT data (using `GarminKit`), persists it via SwiftData, and updates derived metrics (pace per km, HR zones, route coordinates, photos).
- Browse sessions: workouts are listed with name, time, distance, pace and HR highlights. Tap one to open the detail view with charts (pace, HR, elevation), map route, splits per km, photos, and metadata.
- Profile: See cumulative stats, activity grid, gallery, and HR zones tailored to the user.
- Configure user: Set basic profile and HR zones; data is used to compute zones and personalized insights.

## 🧭 Decisions and takeaways

- Coordinators own navigation and injection so view models stay about state, not routing; makes Views reusable in different parts.
- UseCases per feature (Application layer) define what the app does; repositories are passed in via protocols, which keeps tests fast and UIs decoupled from data sources.
- FIT parsing lives in `GarminKit` with DTO-to-domain mappers so future sources (Apple Health, Coros...etc) can slot in without touching UI.
- SwiftData picked over Core Data/GRDB for quick local persistence; mapper layer shields domain from persistence models and enforces validation at the boundary.
- Derived metrics (splits, zones, pace per km) are computed on import, cached, and reused by charts to avoid recomputation in the UI.
- Accessibility and localization are treated as first-class: reusable components come with labels/hints/strings so features inherit them by default.

## ✅ Quality & Testing

- Unit tests across modules (Domain, Database, Application, Features...). Run from Xcode or via:

```sh
swift test
```

## 🚦 CI/CD

- GitHub Actions builds and tests the app on pushes/PRs to `main` and `develop` (`.github/workflows/ci.yml`).
- Tests run with coverage enabled and upload the `.xcresult` bundle as an artifact; coverage is published to Codecov (see badge arriba).
- Para repos privados, añade el secreto `CODECOV_TOKEN` en Settings → Secrets → Actions. For public repos, no token is needed.

## 📦 Requirements

- Xcode 26 or higher
- iOS 26 or higher
- Swift 6 or higher
