# 🧑‍💼 UserSphere — Flutter User List App

UserSphere is a clean and modern Flutter app that displays a list of users fetched from an API, featuring:

- Infinite scroll pagination
- Pull-to-refresh
- Offline detection & retry
- Local search
- Clean Architecture with Riverpod, Dio, and GetIt
- Full widget test coverage

---

## 🚀 Features

✅ Fetch & display user list from `https://reqres.in/api/users`  
✅ Pagination using infinite scroll  
✅ Search functionality (local-only due to API limitation)  
✅ Detail screen for each user  
✅ Offline detection with retry support  
✅ Clean UI & responsive design  
✅ Pull-to-refresh  
✅ Caching-ready structure  
✅ Riverpod for state management  
✅ GetIt for dependency injection  
✅ Widget tests for major components

❌ Offline Caching 

---

## 📁 Project Structure

```
lib/
├── core/
│   └── network/                 # Dio client, exceptions
├── features/
│   └── user/
│       ├── data/                # Models, API service, repository impl
│       ├── domain/              # Repository contract
│       ├── presentation/
│       │   ├── providers/       # Riverpod state notifiers
│       │   ├── screens/         # UserListScreen, UserDetailsScreen
│       │   └── widgets/         # SearchInputField, NoInternetWidget
├── providers/                  # Global providers (connectivity)
└── main.dart
```

---

## 🧪 Testing

All critical widgets and flows are tested under `test/`.

### ✔️ Tests included:
- `SearchInputField` with input and clear behavior  
- `NoInternetWidget` with retry button  
- `UserListScreen`:
  - Infinite scroll pagination
  - Pull-to-refresh
  - Offline → retry → online behavior
- `UserDetailsScreen` displays correct info

### 🔧 Run tests:

```bash
flutter test
```

---

## 🧠 Architecture

- **State Management**: Riverpod
- **Networking**: Dio
- **DI**: GetIt
- **Testing**: flutter_test + mocktail
- **Design Pattern**: Clean Architecture

---

## 🔌 APIs Used

- [Reqres API](https://reqres.in/api/users)

Example endpoint:
```
https://reqres.in/api/users?page=1&per_page=10
```

---

## 🛠 How to Run

```bash
git clone https://github.com/yourusername/usersphere.git
cd usersphere
flutter pub get
flutter run
```

---

## 📸 Screenshots

_Add screenshots here of list view, search, details screen, and offline UI._

---

## 📝 Test Coverage



<!-- ## 🙌 Contributions

PRs are welcome! Please ensure all tests pass and code follows the clean architecture setup.

--- -->

## 📄 License

MIT © Rahat14
