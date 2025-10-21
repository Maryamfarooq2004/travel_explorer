# 🌍 Travel Explorer Pakistan

A beautiful, database-free Flutter travel app showcasing Pakistan's top destinations with **offline functionality**, built for lab mid implementation.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue)
![Dart](https://img.shields.io/badge/Dart-Null%20Safety-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

## ✨ Features

✅ **6 Complete Screens**: Splash, Login, Home, Details, Hotels/Restaurants, Reviews, Favorites, About  
✅ **No Database**: All data stored locally in Dart files  
✅ **SharedPreferences**: For favorites and reviews storage  
✅ **Beautiful UI**: Modern gradient cards, smooth animations, pastel themes  
✅ **Named Routes**: Clean navigation system  
✅ **Categories**: Mountains, Beaches, Historical Sites, Lakes  
✅ **Search Functionality**: Filter destinations easily  
✅ **Ratings & Reviews**: Local review system  

---

## 📱 Screens Overview

1. **Splash Screen** - Animated logo with auto-navigation
2. **Login Screen** - Phone number + social login options
3. **Home Screen** - Categories, search, recommended destinations
4. **Destination List** - Filtered by category
5. **Details Screen** - Hero image, ratings, action buttons
6. **Hotels/Restaurants** - Nearby places with info
7. **Reviews** - Add and view reviews locally
8. **Favorites** - Saved destinations
9. **About** - App info and team details

---

## 🚀 Getting Started

### Installation

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the app**
   ```bash
   flutter run
   ```

---

## 🗂️ Project Structure

```
lib/
├── main.dart                      # App entry with routes
├── models/                        # Data models
├── data/                          # Sample Pakistani destinations
├── screens/                       # All 9 screens
├── widgets/                       # Reusable components
└── utils/                         # SharedPreferences helper
```

---

## 🎨 Design Theme

- **Primary**: Sky Blue (#4A90E2)
- **Secondary**: Teal (#50C9C3)
- **Font**: Poppins (Google Fonts)
- **UI**: Modern cards with shadows, rounded corners

---

## 📦 Key Packages

- `google_fonts` - Beautiful typography
- `flutter_animate` - Smooth animations
- `shared_preferences` - Local storage
- `font_awesome_flutter` - Icons
- `iconsax` - Modern icons

---

## 🏞️ Sample Data

### Destinations Included
- **Mountains**: Hunza Valley, Fairy Meadows, Skardu
- **Beaches**: Clifton, Kund Malir, Gwadar
- **Historical**: Badshahi Mosque, Mohenjo Daro, Lahore Fort
- **Lakes**: Saif-ul-Malook, Attabad Lake

### Hotels & Restaurants
- Serena Hotel Hunza
- Pearl Continental Lahore
- Monal Islamabad
- Kolachi Karachi
- And more...

---

## 👥 Development Team

| Name | Contribution |
|------|--------------|
| **Maryam** | Home Screen, Categories, Navigation |
| **Person 2** | Destination Lists, Details, Animations |
| **Person 3** | Favorites, Local Storage, About |

---

## ✅ Lab Requirements Met

- ✅ No database integration
- ✅ Widget-to-widget navigation
- ✅ Named routes
- ✅ Organized file structure
- ✅ Clean, readable code
- ✅ Modern UI design
- ✅ Local data storage

---

## 🛠️ Adding Custom Data

Edit `lib/data/sample_data.dart`:
```dart
Destination(
  id: '12',
  name: 'Your Destination',
  location: 'City, Pakistan',
  description: 'Description...',
  imageUrl: 'https://...',
  category: 'Mountains',
  rating: 4.5,
),
```

---

## 🐛 Troubleshooting

**Images not loading?**
- Check internet connection (using network images)

**Build errors?**
```bash
flutter clean
flutter pub get
```

---

## 📄 License

Open-source for educational purposes.

---

**Made with ❤️ in Pakistan**

