class UserProfile {
  final String name;
  final String username;
  final String bio;
  final String profileImage;
  final String email;
  final String country;
  final String travelStyle;
  final int placesVisited;
  final int countriesExplored;
  final int tripsThisMonth;
  final List<VisitedPlace> visitedPlaces;

  UserProfile({
    required this.name,
    required this.username,
    required this.bio,
    required this.profileImage,
    required this.email,
    required this.country,
    required this.travelStyle,
    required this.placesVisited,
    required this.countriesExplored,
    required this.tripsThisMonth,
    required this.visitedPlaces,
  });
}


class VisitedPlace {
  final String name;
  final String country;
  final String flag;
  final String imageUrl;
  final String date;

  VisitedPlace({
    required this.name,
    required this.country,
    required this.flag,
    required this.imageUrl,
    required this.date,
  });
}

// Sample user data
final sampleUserProfile = UserProfile(
  name: 'Maryam Farooq',
  username: '@maryam_explorer',
  bio: 'Explorer of hidden gems ✈️',
  profileImage: 'https://via.placeholder.com/200',
  email: 'maryam@travelexplorer.com',
  country: 'Pakistan',
  travelStyle: 'Adventure & Solo',
  placesVisited: 42,
  countriesExplored: 7,
  tripsThisMonth: 3,
 
  visitedPlaces: [
    VisitedPlace(
      name: 'Naran Kaghan',
      country: 'Pakistan',
      flag: '🇵🇰',
      imageUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=300&fit=crop',
      date: 'Oct 2025',
    ),
    VisitedPlace(
      name: 'Murree Hills',
      country: 'Pakistan',
      flag: '🇵🇰',
      imageUrl:
          'https://images.unsplash.com/photo-1506929562872-bb421503ef21?w=400&h=300&fit=crop',
      date: 'Jul 2025',
    ),
    VisitedPlace(
      name: 'Fairy Meadows',
      country: 'Pakistan',
      flag: '🇵🇰',
      imageUrl:
          'https://images.unsplash.com/photo-1464207687429-7505649dae38?w=400&h=300&fit=crop',
      date: 'Jun 2025',
    ),
    VisitedPlace(
      name: 'Istanbul',
      country: 'Turkey',
      flag: '🇹🇷',
      imageUrl:
          'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?w=400&h=300&fit=crop',
      date: 'May 2025',
    ),
    VisitedPlace(
      name: 'Dubai Desert',
      country: 'UAE',
      flag: '🇦🇪',
      imageUrl:
          'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=400&h=300&fit=crop',
      date: 'Apr 2025',
    ),
    VisitedPlace(
      name: 'Maldives Beach',
      country: 'Maldives',
      flag: '🇲🇻',
      imageUrl:
          'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?w=400&h=300&fit=crop',
      date: 'Mar 2025',
    ),
  ],
);
