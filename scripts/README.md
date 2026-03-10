# Code Generator Scripts

Simple command-line tools to generate boilerplate code for Flutter Clean Architecture with GetX.

## Quick Start

```bash
# Show help
dart run scripts/main.dart help

# Create feature
dart run scripts/main.dart feature:product

# Create page
dart run scripts/main.dart page:product_list feature:product --with-paging

# Create usecase (full flow)
dart run scripts/main.dart usecase-full:login feature:auth method:post endpoint:login request:login_req response:login_res --multipart

# Create model
dart run scripts/main.dart model:login_req feature:auth type:request
```

## Commands

### 1. Create Feature

Creates complete feature module with Clean Architecture structure.

```bash
dart run scripts/main.dart feature:<feature_name>
```

**Example:**
```bash
dart run scripts/main.dart feature:product
```

**Creates:**
- `data/repositories/` - Repository implementation
- `data/src/` - API service
- `domain/models/request/` - Request models
- `domain/models/response/` - Response models
- `domain/repositories/` - Repository interface
- `domain/usecases/` - UseCases
- `presentation/controllers/` - Controllers
- `presentation/pages/` - Pages
- `presentation/widgets/` - Widgets
- Bindings registration

---

### 2. Create Page

Creates page with controller and auto-registers routes.

```bash
dart run scripts/main.dart page:<page_name> feature:<feature_name> [--with-paging]
```

**Examples:**
```bash
# Simple page
dart run scripts/main.dart page:product_detail feature:product

# Page with pagination
dart run scripts/main.dart page:product_list feature:product --with-paging
```

---

### 3. Create UseCase (Full Flow) - **RECOMMENDED**

Creates complete flow: Repository → API → Implementation → UseCase → Bindings.

```bash
dart run scripts/main.dart usecase-full:<name> feature:<feature> method:<http_method> endpoint:<endpoint> [request:<model>] [response:<model>] [--multipart]
```

**Parameters:**
- `method` - `get`, `post`, `put`, or `delete`
- `endpoint` - API endpoint name from `Apis` class
- `request` - Request model name (optional)
- `response` - Response model name (optional, default: DefaultRes)
- `--multipart` - Use for file uploads (optional)

**Examples:**

Simple GET:
```bash
dart run scripts/main.dart usecase-full:get_products feature:product method:get endpoint:products response:product_list_res
```

POST with request/response:
```bash
dart run scripts/main.dart usecase-full:login feature:auth method:post endpoint:login request:login_req response:login_res --multipart
```

PUT request:
```bash
dart run scripts/main.dart usecase-full:update_profile feature:account method:put endpoint:updateProfile request:update_profile_req response:user_res
```

DELETE request:
```bash
dart run scripts/main.dart usecase-full:delete_product feature:product method:delete endpoint:deleteProduct
```

---

### 4. Create Model

Creates Request or Response models with JSON serialization.

```bash
dart run scripts/main.dart model:<model_name> feature:<feature_name> type:<request|response> [--list]
```

**Examples:**

Request model:
```bash
dart run scripts/main.dart model:login_req feature:auth type:request
```

Response model:
```bash
dart run scripts/main.dart model:user_res feature:auth type:response
```

Response model (list):
```bash
dart run scripts/main.dart model:product_list_res feature:product type:response --list
```

**Interactive field input:**
After running the command, you'll be prompted to enter fields:

```
Field 1: String email
Field 2: String password
Field 3: bool rememberMe remember_me
Field 4: String? fcmToken fcm_token
Field 5: done
```

**Field format:** `<type> <name> [jsonKey]`
- `type` - Dart type (String, int, bool, String?, etc.)
- `name` - Variable name (camelCase)
- `jsonKey` - JSON key (snake_case) - optional

---

## Complete Example: Login Feature

```bash
# 1. Create feature
dart run scripts/main.dart feature:auth

# 2. Create request model
dart run scripts/main.dart model:login_req feature:auth type:request
# Enter fields:
#   String email
#   String password
#   bool rememberMe remember_me
#   done

# 3. Create response model
dart run scripts/main.dart model:login_res feature:auth type:response
# Enter fields:
#   String? token
#   done

# 4. Create usecase
dart run scripts/main.dart usecase-full:login feature:auth method:post endpoint:login request:login_req response:login_res --multipart

# 5. Create page
dart run scripts/main.dart page:login feature:auth

# 6. Generate code
dart run build_runner build --delete-conflicting-outputs
```

---

## After Generation

**Always run build_runner after creating models:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Add API endpoint:**
```dart
// lib/shared/constants/apis.dart
class Apis {
  static const String login = '/auth/login';
}
```

---

## HTTP Methods

| Method | Use Case | Example |
|--------|----------|---------|
| `get` | Fetch data | Get products, user profile |
| `post` | Create/Send | Login, register, upload |
| `put` | Update | Update profile, edit product |
| `delete` | Delete | Delete item, remove account |

**When to use `--multipart`:**
- File uploads (images, documents)
- Form data with files
- API requires `multipart/form-data`

---

## Naming Conventions

- **Features:** `snake_case` - `user_management`, `product_catalog`
- **Pages:** `snake_case` - `product_detail`, `user_profile`
- **UseCases:** `snake_case` - `get_products`, `create_order`, `update_profile`
- **Models:** `snake_case` with suffix - `login_req`, `user_res`

---

## Tips

1. ✅ Always create feature first
2. ✅ Create models before usecases
3. ✅ Use `usecase-full` for complete flow
4. ✅ Run build_runner after creating models
5. ✅ Follow snake_case naming

---

## Troubleshooting

**"Feature does not exist"**
```bash
dart run scripts/main.dart feature:your_feature
```

**Build runner fails**
```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

---

## Version

**v1.0.0** - Clean Architecture Code Generator for Albahjah Pustaka Mobile
