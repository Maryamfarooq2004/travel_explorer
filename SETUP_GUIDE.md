# 🚀 Quick Setup Guide - Travel Explorer Pakistan

## ⚡ Quick Start (5 Minutes)

### Step 1: Install Packages
Open terminal in VS Code and run:
```bash
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

That's it! The app will launch on your connected device or emulator.

---

## 📱 Testing the App

### Navigation Flow:
1. **Splash Screen** (3 seconds) → **Login Screen**
2. Click "Send OTP" or any social button → **Home Screen**
3. Click a **Category Card** (e.g., Mountains) → **Destination List**
4. Click a **Destination Card** → **Details Screen**
5. Click **"Find Hotels"** → **Hotels Screen**
6. Click **"View Restaurants"** → **Restaurants Screen**
7. Click **"View Reviews"** → **Reviews Screen**
8. Click **❤️ (Heart Icon)** → Adds to **Favorites**
9. Bottom Nav → Click **Heart** → **Favorites Screen**
10. Bottom Nav → Click **User** → **About Screen**

---

## 🎯 Key Features to Demonstrate

### 1. **Search Function**
- On Home Screen, type in search bar
- Try: "Hunza", "Karachi", "Lahore"
- Results filter in real-time

### 2. **Add to Favorites**
- Go to any destination detail
- Click the heart icon (top right)
- Check Favorites screen (bottom nav)
- Data persists even after closing app!

### 3. **Add Review**
- Go to any destination detail
- Click "View Reviews"
- Scroll to bottom form
- Fill name, comment, select stars
- Submit → Review appears instantly

### 4. **Categories Filter**
- Home screen has 4 categories
- Each shows only relevant destinations
- Mountains, Beaches, Historical, Lakes

---

## 📂 File Organization

```
✅ All screens in: lib/screens/
✅ All models in: lib/models/
✅ Sample data in: lib/data/sample_data.dart
✅ Widgets in: lib/widgets/
✅ Utilities in: lib/utils/
```

---

## 🎨 Customization Tips

### Change App Name
**File:** `pubspec.yaml` (line 1)
```yaml
name: your_app_name
```

### Change Primary Color
**File:** `lib/main.dart` (line 28)
```dart
seedColor: const Color(0xFFYourHexColor),
```

### Add More Destinations
**File:** `lib/data/sample_data.dart`
```dart
Destination(
  id: '12',
  name: 'Neelum Valley',
  location: 'AJK, Pakistan',
  description: 'Beautiful valley...',
  imageUrl: 'https://images.unsplash.com/...',
  category: 'Mountains',
  rating: 4.7,
),
```

### Change User Name on Home Screen
**File:** `lib/screens/home_screen.dart` (line 30)
```dart
Text('Hi YourName 👋',
```

---

## 🖼️ Using Local Images (Optional)

### 1. Add images to folder:
```
assets/images/hunza.jpg
assets/images/clifton.jpg
```

### 2. Update image URL in sample_data.dart:
```dart
imageUrl: 'assets/images/hunza.jpg',
```

### 3. Already configured in pubspec.yaml ✅

---

## 🔧 Common Commands

```bash
# Install packages
flutter pub get

# Run app
flutter run

# Clean build
flutter clean

# Check for errors
flutter analyze

# Run on specific device
flutter run -d chrome
flutter run -d windows
```

---

## 📊 App Statistics

- **Total Screens**: 9
- **Total Files Created**: 25+
- **Lines of Code**: ~2500+
- **Models**: 4 (Destination, Hotel, Restaurant, Review)
- **Sample Destinations**: 11
- **Sample Hotels**: 6
- **Sample Restaurants**: 6

---

## ✅ Lab Submission Checklist

- [x] No database integration
- [x] Widget-based navigation
- [x] Named routes implemented
- [x] Separate files for organization
- [x] Clean, commented code
- [x] Modern UI design
- [x] Functional search
- [x] Local storage (favorites & reviews)
- [x] Multiple screens (9 total)
- [x] Reusable widgets

---

## 🎥 Demo Script

**For presenting your app:**

1. **Start** → "This is Travel Explorer Pakistan, a database-free travel app"
2. **Splash** → "Beautiful animated splash screen with auto-navigation"
3. **Login** → "Multiple login options including social authentication"
4. **Home** → "Categories, search, and recommended destinations"
5. **Search** → "Real-time search functionality"
6. **Category** → "Click Mountains → shows filtered destinations"
7. **Details** → "Hero image, ratings, action buttons"
8. **Hotels** → "List of nearby hotels with pricing"
9. **Reviews** → "Add and view reviews, stored locally"
10. **Favorites** → "Persistent storage using SharedPreferences"
11. **About** → "App info and team credits"

---

## 🐛 Quick Fixes

### Problem: White screen on start
**Fix:** Check if `main.dart` is properly configured with routes

### Problem: Images not showing
**Fix:** Ensure internet connection (using network images from Unsplash)

### Problem: Build errors
**Fix:** Run:
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📞 Support

If you encounter any issues:
1. Check this guide
2. Run `flutter doctor`
3. Check error messages in terminal
4. Google the specific error

---

## 🌟 Bonus Points

Want to impress? Add these:
- [ ] Dark mode toggle
- [ ] Animation on category cards
- [ ] Share destination feature
- [ ] Export favorites to text

---

**Your app is ready! Run `flutter run` and enjoy! 🎉**
