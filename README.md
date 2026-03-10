# Flutter Project Template

A production-ready Flutter template project implementing Clean Architecture with GetX state management, multi-flavor support, and comprehensive CRUD examples. This template serves as a solid foundation for building scalable Flutter applications.

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Running the Application](#running-the-application)
- [Building for Production](#building-for-production)
- [Architecture Overview](#architecture-overview)
- [Key Components](#key-components)
- [Adding New Features](#adding-new-features)
- [Available Utilities](#available-utilities)
- [Configuration Files](#configuration-files)
- [Dependencies](#dependencies)
- [License](#license)

---

## Features

- **Clean Architecture** with clear separation of concerns (Data, Domain, Presentation)
- **GetX** for state management, dependency injection, and routing
- **Multi-flavor support** (Development & Production)
- **Complete CRUD example** with Products module
- **Retrofit + Dio** for type-safe API calls
- **Firebase Integration** (Cloud Messaging, Analytics)
- **Local Notifications** support
- **Reusable UI Components** (20+ common widgets)
- **Base Classes** for controllers, repositories, and use cases
- **Pagination Support** with pull-to-refresh
- **Error Handling** with unified DataState pattern
- **Session Management** with secure token storage
- **Code Generation** for models, API services, and assets
- **Localization Ready** (English/Indonesian)
- **Custom Theme** with consistent styling
- **SSL Certificate Patch** (ISRG Root)
- **In-App Updates** support (Android)

---

## Project Structure

```
poke_vault_mobile_app/
├── lib/
│   ├── app/                           # Application configuration
│   │   ├── bindings/                  # Dependency injection bindings
│   │   │   ├── core_bindings.dart     # Global dependencies (Dio, Session, etc.)
│   │   │   ├── feature_bindings.dart  # Feature-specific bindings
│   │   │   └── app_bindings.dart      # Main bindings aggregator
│   │   └── routes/                    # Route definitions
│   │       ├── routes.dart            # Route constants
│   │       └── pages.dart             # Route-page mappings
│   ├── config/                        # App-level configuration
│   │   ├── bases/                     # Base classes (UseCase, Repository, etc.)
│   │   ├── network/                   # Network setup (Dio, Interceptors)
│   │   └── theme/                     # Theme configuration
│   ├── features/                      # Feature modules (Clean Architecture)
│   │   ├── common/                    # Shared widgets & utilities
│   │   │   ├── presentation/
│   │   │   │   └── pages/             # Common pages (initialization, etc.)
│   │   │   └── widget/                # Reusable widgets
│   │   └── products/                  # Example CRUD feature
│   │       ├── data/                  # Data layer
│   │       │   ├── repositories/      # Repository implementations
│   │       │   └── src/               # API services (Retrofit)
│   │       ├── domain/                # Domain layer
│   │       │   ├── models/            # DTOs (Request/Response)
│   │       │   ├── repositories/      # Repository interfaces
│   │       │   └── usecases/          # Business logic use cases
│   │       └── presentation/          # Presentation layer
│   │           ├── controllers/       # GetX controllers
│   │           ├── pages/             # Full pages
│   │           └── widgets/           # Feature-specific widgets
│   ├── main/                          # Entry points
│   │   ├── main_development.dart      # Development flavor entry
│   │   └── main_production.dart       # Production flavor entry
│   ├── shared/                        # Shared utilities
│   │   ├── constants/                 # Constants & generated assets
│   │   ├── enums/                     # Enumerations
│   │   ├── extensions/                # Dart extensions
│   │   ├── services/                  # Global services (Notifications, FCM)
│   │   └── utils/                     # Utility classes & mixins
│   └── bootstrap.dart                 # App initialization logic
├── assets/                            # Static assets
│   ├── fonts/                         # Custom fonts (Poppins, Nunito)
│   ├── image/                         # Images
│   └── svg/                           # SVG icons
├── android/                           # Android platform
│   └── app/
│       ├── build.gradle.kts           # Build configuration with flavors
│       └── src/
│           ├── development/           # Development flavor resources
│           ├── production/            # Production flavor resources
│           └── main/                  # Shared Android resources
├── ios/                               # iOS platform
├── test/                              # Unit & widget tests
└── pubspec.yaml                       # Dependencies & configuration
```

---

## Prerequisites

- **Flutter SDK**: 3.0.0 or higher ([Install Flutter](https://flutter.dev/docs/get-started/install))
- **Dart SDK**: 3.0.0 or higher (comes with Flutter)
- **Android Studio** / **Xcode** for platform-specific builds
- **Git** for version control
- **Firebase Account** (optional, if using Firebase features)

---

## Running the Application

### Development Flavor

**Using Command Line:**
```bash
flutter run --flavor development --target lib/main/main_development.dart
```

**Using VS Code:**
Press `F5` or go to Run > Start Debugging, then select "development" from the launch configuration.

**Using Android Studio:**
1. Go to Run > Edit Configurations
2. Add new Flutter configuration
3. Set Dart entrypoint: `lib/main/main_development.dart`
4. Set Build flavor: `development`

### Production Flavor

**Using Command Line:**
```bash
flutter run --flavor production --target lib/main/main_production.dart
```

**Using VS Code:**
Select "production" from the launch configuration.

---

## Building for Production

### Android

#### Development APK
```bash
flutter build apk --flavor development --target lib/main/main_development.dart
```

#### Production APK
```bash
flutter build apk --flavor production --target lib/main/main_production.dart
```

#### Production App Bundle (Google Play)
```bash
flutter build appbundle --flavor production --target lib/main/main_production.dart
```

**Note:** For production release builds, you need to:
1. Create a keystore file
2. Create `android/key.properties` with signing configuration:
   ```properties
   storePassword=your-store-password
   keyPassword=your-key-password
   keyAlias=your-key-alias
   storeFile=path/to/your/keystore.jks
   ```

### iOS

```bash
flutter build ios --flavor production --target lib/main/main_production.dart
```

Then use Xcode to archive and upload to App Store.

---

## Architecture Overview

This template follows **Clean Architecture** principles with three distinct layers:

### 1. Data Layer (`data/`)
- **Responsibilities:** API calls, data persistence, external data sources
- **Components:**
  - `src/`: Retrofit API service definitions
  - `repositories/`: Repository implementations
- **Example:** `ProductsApiService`, `ProductsRepositoryImpl`

### 2. Domain Layer (`domain/`)
- **Responsibilities:** Business logic, data models, repository contracts
- **Components:**
  - `models/`: Request/Response DTOs
  - `repositories/`: Repository interfaces (abstractions)
  - `usecases/`: Single-responsibility business logic
- **Example:** `GetProductsUc`, `CreateProductsUc`, `Product` model

### 3. Presentation Layer (`presentation/`)
- **Responsibilities:** UI, state management, user interactions
- **Components:**
  - `controllers/`: GetX controllers (ViewModels)
  - `pages/`: Full-screen pages
  - `widgets/`: Feature-specific UI components
- **Example:** `ProductsController`, `ProductsPage`, `ProductCard`

### Data Flow

```
User Interaction → Controller → Use Case → Repository → API Service
                                    ↓
User Interface ← Controller ← DataState<T> ← Repository
```

---

## Key Components

### Base Classes

Located in `lib/config/bases/`:

1. **BaseUseCase** - Abstract use case interface
   ```dart
   abstract class UseCase<T, Request> {
     Future<T> call({Request request});
   }
   ```

2. **BaseDataState** - Unified API response wrapper
   ```dart
   DataState<User> result = await getUserUseCase();
   if (result is DataSuccess) {
     // Handle success
   } else if (result is DataFailed) {
     // Handle error
   }
   ```

3. **BaseApiRepository** - Common repository functionality
   - HTTP response handling
   - DataState conversion
   - Error handling with DioException

4. **BaseApiPagination** - Pagination mixin for controllers
   - Manages paginated data
   - Pull-to-refresh
   - Load more
   - Empty/error states

### Dependency Injection

Uses GetX bindings with lazy loading:

```dart
// Registering dependencies
Get.lazyPut<ProductsApiService>(
  () => ProductsApiService(Get.find()),
  fenix: true,
);

// Using dependencies
final apiService = Get.find<ProductsApiService>();
```

**Binding Hierarchy:**
- `AppBindings`: Root bindings
  - `CoreBindings`: Global dependencies (Dio, Session, etc.)
  - `FeatureBindings`: Feature-specific dependencies

### Network Layer

**Dio Configuration** (`lib/config/network/dio_config.dart`):
- Base URL from AppConfig
- Timeouts: 60s connect, 60s receive
- Custom interceptor for logging & auth

**Dio Interceptor** (`lib/config/network/dio_interceptor.dart`):
- Adds Bearer token to requests
- Logs all requests/responses
- Handles 401 (clears session)
- Custom error messages

### Routing

**Routes Definition** (`lib/app/routes/routes.dart`):
```dart
class Routes {
  static const String products = '/products';
  static const String productForm = '/product-form';
}
```

**Navigation:**
```dart
// Navigate to page
Get.toNamed(Routes.productForm);

// Navigate with arguments
Get.toNamed(Routes.productForm, arguments: {'id': 123});

// Get arguments in controller
final args = Get.arguments;
```

---

## Adding New Features

Follow these steps to add a new feature following Clean Architecture:

### 1. Create Feature Structure

```
lib/features/your_feature/
├── data/
│   ├── repositories/
│   │   └── your_feature_repository_impl.dart
│   └── src/
│       └── your_feature_api_service.dart
├── domain/
│   ├── models/
│   │   ├── request/
│   │   │   └── your_request.dart
│   │   └── response/
│   │       └── your_response.dart
│   ├── repositories/
│   │   └── your_feature_repository.dart
│   └── usecases/
│       ├── get_your_data_uc.dart
│       └── create_your_data_uc.dart
└── presentation/
    ├── controllers/
    │   └── your_feature_controller.dart
    ├── pages/
    │   └── your_feature_page.dart
    └── widgets/
        └── your_widget.dart
```

### 2. Define API Service (Retrofit)

```dart
// lib/features/your_feature/data/src/your_feature_api_service.dart
@RestApi()
abstract class YourFeatureApiService {
  factory YourFeatureApiService(Dio dio) = _YourFeatureApiService;

  @GET('/your-endpoint')
  Future<HttpResponse<YourResponse>> getData();
}
```

### 3. Create Repository

**Interface:**
```dart
// lib/features/your_feature/domain/repositories/your_feature_repository.dart
abstract class YourFeatureRepository {
  Future<DataState<YourData>> getData();
}
```

**Implementation:**
```dart
// lib/features/your_feature/data/repositories/your_feature_repository_impl.dart
class YourFeatureRepositoryImpl extends BaseApiRepository
    implements YourFeatureRepository {
  final YourFeatureApiService _apiService;

  YourFeatureRepositoryImpl(this._apiService);

  @override
  Future<DataState<YourData>> getData() async {
    return await handleHttpResponse(() => _apiService.getData());
  }
}
```

### 4. Create Use Cases

```dart
// lib/features/your_feature/domain/usecases/get_your_data_uc.dart
class GetYourDataUc implements UseCase<DataState<YourData>, void> {
  final YourFeatureRepository _repository;

  GetYourDataUc(this._repository);

  @override
  Future<DataState<YourData>> call({void request}) {
    return _repository.getData();
  }
}
```

### 5. Create Controller

```dart
// lib/features/your_feature/presentation/controllers/your_feature_controller.dart
class YourFeatureController extends GetxController {
  final GetYourDataUc _getYourDataUc;

  YourFeatureController(this._getYourDataUc);

  final data = Rxn<YourData>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    final result = await _getYourDataUc();
    if (result is DataSuccess) {
      data.value = result.data;
    }
    isLoading.value = false;
  }
}
```

### 6. Create Bindings

```dart
// lib/app/bindings/feature_bindings/your_feature_bindings.dart
class YourFeatureBindings {
  static void dependencies() {
    // API Service
    Get.lazyPut<YourFeatureApiService>(
      () => YourFeatureApiService(Get.find()),
      fenix: true,
    );

    // Repository
    Get.lazyPut<YourFeatureRepository>(
      () => YourFeatureRepositoryImpl(Get.find()),
      fenix: true,
    );

    // Use Cases
    Get.lazyPut(() => GetYourDataUc(Get.find()), fenix: true);

    // Controller
    Get.lazyPut(() => YourFeatureController(Get.find()), fenix: true);
  }
}
```

Add to `FeatureBindings`:
```dart
// lib/app/bindings/feature_bindings.dart
class FeatureBindings extends Bindings {
  @override
  void dependencies() {
    ProductsBindings.dependencies();
    YourFeatureBindings.dependencies();  // Add this line
  }
}
```

### 7. Add Routes

```dart
// lib/app/routes/routes.dart
class Routes {
  ...
  static const String yourFeature = '/your-feature';
}

// lib/app/routes/pages.dart
class Pages {
  static final routes = [
    ...
    GetPage(
      name: Routes.yourFeature,
      page: () => const YourFeaturePage(),
    ),
  ];
}
```

### 8. Run Code Generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Available Utilities

### Modal Helpers

Located in `lib/shared/utils/modal_helpers.dart`:

```dart
// Loading dialog
modalHelper.loading();

// Dismiss loading
modalHelper.dismissLoading();

// Info dialog
modalHelper.info(message: 'Information message');

// Error dialog
modalHelper.error(message: 'Error message');

// Confirmation dialog
final confirmed = await modalHelper.confirm(
  message: 'Are you sure?',
  onConfirm: () => print('Confirmed'),
);

// Toast message
modalHelper.showToast(message: 'Success!');

// Snackbar
modalHelper.showSnackBar(message: 'Saved successfully');

// Bottom sheet
modalHelper.showBottomBar(child: YourWidget());

// Date picker
final date = await modalHelper.showDatePicker();

// Image source picker (camera/gallery)
final source = await modalHelper.showImageSource();
```

### Mixins

Located in `lib/shared/utils/`:

1. **HandlerApiMixin** - API response handling
   ```dart
   class MyController extends GetxController with HandlerApiMixin {
     void loadData() async {
       final result = await useCase();
       handleApiResponse(
         result,
         onSuccess: (data) => print('Success: $data'),
         onError: (error) => print('Error: $error'),
       );
     }
   }
   ```

2. **LogMixin** - Logging utilities
   ```dart
   class MyRepository with LogMixin {
     void makeRequest() {
       logRequest('GET', '/api/data', queryParams: {'page': 1});
     }
   }
   ```

3. **ValidatorMixin** - Form validation
4. **FormatterMixin** - Data formatting

### Extensions

Located in `lib/shared/extensions/`:

```dart
// String extensions
'Hello'.minLen(10);  // Check minimum length
nullableString.val('default');  // Get value or default

// Context extensions
context.lorem(50);  // Generate lorem ipsum
context.fakeImg(200, 200);  // Generate placeholder image URL
```

### Common Widgets

Located in `lib/features/common/widget/`:

```dart
// App bar with search
AppBarSearch(
  title: 'Products',
  onSearch: (query) => print(query),
)

// Data list view with pagination
AppDataListView<Product>(
  controller: refreshController,
  itemBuilder: (product) => ProductCard(product: product),
  onRefresh: () => controller.refreshData(),
  onLoadMore: () => controller.loadMore(),
  isEmpty: controller.products.isEmpty,
  isError: controller.isError,
)

// Loading indicator
AppLoading()

// Empty state
AppEmptyData(message: 'No data found')

// Error state
AppListError(onRetry: () => controller.retry())

// Button with loading state
AppButtonLoading(
  onPressed: () => controller.submit(),
  isLoading: controller.isLoading,
  child: Text('Submit'),
)

// Date picker
AppDatePicker(
  onDateSelected: (date) => print(date),
)

// Custom text input
AppTextfieldInput(
  hintText: 'Enter name',
  controller: textController,
)

// Dropdown
AppDropdown<String>(
  items: ['Option 1', 'Option 2'],
  onChanged: (value) => print(value),
)
```

---

## Configuration Files

### API Endpoints

**File:** `lib/shared/constants/apis.dart`

```dart
class Apis {
  static const login = '/auth/login';
  static const products = '/products';
  static const productCategoryLookup = '/lookup/product-categories';
  // Add your endpoints here
}
```

### Theme

**File:** `lib/config/theme/theme.dart`

Customize colors, fonts, and component themes:
```dart
class AppTheme {
  static const primaryColor = Color(0xFF001767);
  static const successColor = Color(0xFF009E0F);
  static const errorColor = Color(0xFFF44336);
  // ... modify as needed
}
```

### Assets

After adding assets to `assets/` folders, run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Then use them with type safety:
```dart
import 'package:your_project_name/shared/constants/gen/assets.gen.dart';

// Images
Image.asset(Assets.image.imgError.path)

// SVG
SvgPicture.asset(Assets.svg.arrowLeft.path)
```

---

## Dependencies

### Core Dependencies
- **get** (^4.6.6) - State management, DI, routing
- **dio** (^5.7.0) - HTTP client
- **retrofit** (^4.9.1) - Type-safe API client
- **json_annotation** (^4.9.0) - JSON serialization

### Firebase & Notifications
- **firebase_core** (^4.1.1)
- **firebase_messaging** (^16.0.2)
- **flutter_local_notifications** (^19.5.0)

### UI Libraries
- **shimmer** (^3.0.0) - Loading skeletons
- **carousel_slider** (^5.0.0)
- **syncfusion_flutter_datepicker** (^31.1.19)
- **flutter_svg** (^2.0.15)
- **pull_to_refresh** (^2.0.0)

### Utilities
- **shared_preferences** (^2.3.3) - Local storage
- **permission_handler** (^12.0.1)
- **image_picker** (^1.2.1)
- **url_launcher** (^6.3.1)

### Dev Dependencies
- **build_runner** (^2.4.13)
- **flutter_gen_runner** (^5.12.0)
- **retrofit_generator** (^10.2.0)
- **json_serializable** (^6.11.2)
- **flutter_lints** (^6.0.0)

For complete list, see [pubspec.yaml](pubspec.yaml).

---

## Common Issues & Solutions

### Issue: "No such file or directory" for generated files
**Solution:** Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Flavor not recognized
**Solution:** Ensure you're using the correct target file:
```bash
flutter run --flavor development --target lib/main/main_development.dart
```

### Issue: Android build fails with signing error
**Solution:** For development, debug signing is automatic. For production release, create `android/key.properties` with your keystore configuration.

### Issue: Firebase not working
**Solution:**
1. Ensure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) are in correct locations
2. Verify package name matches Firebase project configuration
3. Run `flutter clean` and rebuild

### Issue: Assets not found
**Solution:** After adding assets, always run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Best Practices

1. **Feature Organization:** Keep each feature self-contained in its own folder
2. **Dependency Injection:** Always use GetX bindings, avoid direct instantiation
3. **Error Handling:** Use `DataState<T>` pattern for consistent error handling
4. **Code Generation:** Run build_runner after modifying models or API services
5. **Naming Conventions:**
   - Files: `snake_case.dart`
   - Classes: `PascalCase`
   - Variables: `camelCase`
   - Constants: `camelCase` or `UPPER_SNAKE_CASE`
6. **State Management:** Use `Rx` types for reactive state in controllers
7. **Repository Pattern:** Always create interface and implementation
8. **Use Cases:** Keep business logic in use cases, not controllers
9. **Testing:** Write tests for use cases and repositories first
10. **Documentation:** Document complex logic and public APIs

---

## Support

For issues, questions, or contributions, please [open an issue](your-repository-url/issues) or contact the development team.

---

**Happy Coding!** 🚀
