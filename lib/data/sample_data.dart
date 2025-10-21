import '../models/destination.dart';
import '../models/hotel.dart';
import '../models/restaurant.dart';

/// Sample destinations data for Pakistan
final List<Destination> destinations = [
  // Mountains
  Destination(
    id: '1',
    name: 'Hunza Valley',
    location: 'Gilgit-Baltistan, Pakistan',
    description:
        'Known for its breathtaking mountains and peaceful views. The third largest island in the Trang Sea is Koh Muk, which is beautiful and peaceful like a private island. On the island, there will be villagers living as well, by maintaining a simple way of life.',
    imageUrl:
        'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=800',
    category: 'Mountains',
    rating: 4.9,
    hotels: ['hotel1', 'hotel2'],
    restaurants: ['rest1', 'rest2'],
  ),
  Destination(
    id: '2',
    name: 'Fairy Meadows',
    location: 'Gilgit-Baltistan, Pakistan',
    description:
        'A grassland near one of the base camps of Nanga Parbat. It offers stunning views of the ninth-highest mountain in the world.',
    imageUrl:
        'https://images.unsplash.com/photo-1609137144813-7d9921338f24?w=800',
    category: 'Mountains',
    rating: 4.8,
    hotels: ['hotel3'],
    restaurants: ['rest3'],
  ),
  Destination(
    id: '3',
    name: 'Skardu',
    location: 'Gilgit-Baltistan, Pakistan',
    description:
        'Gateway to some of the highest peaks on Earth, including K2. Home to beautiful lakes and ancient forts.',
    imageUrl:
        'https://images.unsplash.com/photo-1570284613060-766c33f6f742?w=800',
    category: 'Mountains',
    rating: 4.7,
    hotels: ['hotel4'],
    restaurants: ['rest4'],
  ),

  // Beaches
  Destination(
    id: '4',
    name: 'Clifton Beach',
    location: 'Karachi, Pakistan',
    description:
        'A beautiful beach with golden sand and blue waves. One of the most popular beaches in Karachi.',
    imageUrl: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
    category: 'Beaches',
    rating: 4.2,
    hotels: ['hotel5'],
    restaurants: ['rest5', 'rest6'],
  ),
  Destination(
    id: '5',
    name: 'Kund Malir',
    location: 'Balochistan, Pakistan',
    description:
        'A pristine beach along the Makran Coastal Highway with stunning sunset views and serene atmosphere.',
    imageUrl:
        'https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800',
    category: 'Beaches',
    rating: 4.6,
    hotels: ['hotel6'],
    restaurants: ['rest7'],
  ),
  Destination(
    id: '6',
    name: 'Gwadar Beach',
    location: 'Gwadar, Balochistan, Pakistan',
    description:
        'Emerging coastal destination with pristine beaches and unique rock formations.',
    imageUrl:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
    category: 'Beaches',
    rating: 4.4,
    hotels: ['hotel7'],
    restaurants: ['rest8'],
  ),

  // Historical
  Destination(
    id: '7',
    name: 'Badshahi Mosque',
    location: 'Lahore, Punjab, Pakistan',
    description:
        'One of the largest mosques in the world, built in 1671 during the Mughal Empire.',
    imageUrl:
        'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800',
    category: 'Historical',
    rating: 4.9,
    hotels: ['hotel8'],
    restaurants: ['rest9'],
  ),
  Destination(
    id: '8',
    name: 'Mohenjo Daro',
    location: 'Sindh, Pakistan',
    description:
        'Ancient Indus Valley civilization site, dating back to 2500 BCE. A UNESCO World Heritage Site.',
    imageUrl: 'https://images.unsplash.com/photo-1548013146-72479768bada?w=800',
    category: 'Historical',
    rating: 4.7,
    hotels: ['hotel9'],
    restaurants: ['rest10'],
  ),
  Destination(
    id: '9',
    name: 'Lahore Fort',
    location: 'Lahore, Punjab, Pakistan',
    description:
        'A citadel in the city of Lahore with a history dating back over 1000 years.',
    imageUrl:
        'https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=800',
    category: 'Historical',
    rating: 4.8,
    hotels: ['hotel8'],
    restaurants: ['rest9'],
  ),

  // Lakes
  Destination(
    id: '10',
    name: 'Saif-ul-Malook',
    location: 'Kaghan Valley, KPK, Pakistan',
    description:
        'A mountainous lake located at the northern end of the Kaghan Valley, surrounded by peaks.',
    imageUrl:
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    category: 'Lakes',
    rating: 4.9,
    hotels: ['hotel10'],
    restaurants: ['rest11'],
  ),
  Destination(
    id: '11',
    name: 'Attabad Lake',
    location: 'Hunza Valley, Gilgit-Baltistan, Pakistan',
    description:
        'A stunning turquoise lake formed in 2010 after a massive landslide. Perfect for boating.',
    imageUrl:
        'https://images.unsplash.com/photo-1439066615861-d1af74d74000?w=800',
    category: 'Lakes',
    rating: 4.8,
    hotels: ['hotel1'],
    restaurants: ['rest2'],
  ),
];

/// Sample hotels data
final List<Hotel> hotels = [
  Hotel(
    id: 'hotel1',
    name: 'Serena Hotel Hunza',
    location: 'Hunza Valley, Gilgit-Baltistan',
    rating: 4.8,
    imageUrl:
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
    price: 'PKR 15,000/night',
    description:
        'Luxury hotel with stunning mountain views and modern amenities.',
  ),
  Hotel(
    id: 'hotel2',
    name: 'Luxus Hunza',
    location: 'Hunza Valley, Gilgit-Baltistan',
    rating: 4.6,
    imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
    price: 'PKR 12,000/night',
    description: 'Comfortable stay with breathtaking views of Rakaposhi.',
  ),
  Hotel(
    id: 'hotel3',
    name: 'Fairy Meadows Cottages',
    location: 'Fairy Meadows, Gilgit-Baltistan',
    rating: 4.5,
    imageUrl:
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
    price: 'PKR 8,000/night',
    description: 'Rustic cottages with views of Nanga Parbat.',
  ),
  Hotel(
    id: 'hotel4',
    name: 'Shangrila Resort Skardu',
    location: 'Skardu, Gilgit-Baltistan',
    rating: 4.7,
    imageUrl:
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
    price: 'PKR 18,000/night',
    description: 'Famous resort with lake views and excellent hospitality.',
  ),
  Hotel(
    id: 'hotel5',
    name: 'Avari Towers Karachi',
    location: 'Karachi, Sindh',
    rating: 4.5,
    imageUrl: 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
    price: 'PKR 20,000/night',
    description: 'Premium hotel near Clifton Beach with all modern facilities.',
  ),
  Hotel(
    id: 'hotel8',
    name: 'Pearl Continental Lahore',
    location: 'Lahore, Punjab',
    rating: 4.7,
    imageUrl:
        'https://images.unsplash.com/photo-1569670517782-46b1e5c96e73?w=800',
    price: 'PKR 22,000/night',
    description:
        'Luxury hotel in the heart of Lahore, near all major attractions.',
  ),
];

/// Sample restaurants data
final List<Restaurant> restaurants = [
  Restaurant(
    id: 'rest1',
    name: 'Cafe de Hunza',
    location: 'Hunza Valley',
    rating: 4.6,
    imageUrl:
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
    cuisine: 'Pakistani, Continental',
    priceRange: 'PKR 500-1500',
  ),
  Restaurant(
    id: 'rest2',
    name: 'Hidden Paradise',
    location: 'Hunza Valley',
    rating: 4.5,
    imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800',
    cuisine: 'Local, Chinese',
    priceRange: 'PKR 400-1200',
  ),
  Restaurant(
    id: 'rest5',
    name: 'Kolachi',
    location: 'Karachi',
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800',
    cuisine: 'Pakistani BBQ, Seafood',
    priceRange: 'PKR 1000-2500',
  ),
  Restaurant(
    id: 'rest6',
    name: 'Beach Luxury',
    location: 'Clifton, Karachi',
    rating: 4.4,
    imageUrl:
        'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800',
    cuisine: 'Continental, Italian',
    priceRange: 'PKR 1500-3000',
  ),
  Restaurant(
    id: 'rest9',
    name: 'Butt Karahi',
    location: 'Lahore',
    rating: 4.8,
    imageUrl:
        'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800',
    cuisine: 'Pakistani Traditional',
    priceRange: 'PKR 600-1800',
  ),
  Restaurant(
    id: 'rest10',
    name: 'Monal Islamabad',
    location: 'Islamabad',
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800',
    cuisine: 'Pakistani, Continental, Chinese',
    priceRange: 'PKR 1200-2800',
  ),
];
