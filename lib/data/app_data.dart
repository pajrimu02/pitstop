import '../models/product.dart';
import '../models/order.dart';

class AppData {
  static List<Product> products = [
    Product(
      id: 1,
      name: 'Oli Mesin 10W-40',
      category: 'Oli',
      image: 'https://images.unsplash.com/photo-1635784063381-cc2e4a5c1d8e?w=500',
      price: 55000,
      description: 'Oli mesin berkualitas untuk menjaga performa dan keawetan mesin motor.',
    ),
    Product(
      id: 2,
      name: 'Ban Motor Tubeless',
      category: 'Ban',
      image: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=500',
      price: 220000,
      description: 'Ban motor dengan kualitas terbaik dan daya cengkeram optimal.',
    ),
    Product(
      id: 3,
      name: 'Kampas Rem',
      category: 'Rem',
      image: 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=500',
      price: 45000,
      description: 'Kampas rem berkualitas untuk keamanan berkendara.',
    ),
    Product(
      id: 4,
      name: 'Busi Motor',
      category: 'Aki',
      image: 'https://images.unsplash.com/photo-1487754180451-c456f719a1fc?w=500',
      price: 27000,
      description: 'Busi motor untuk membantu pembakaran mesin lebih optimal.',
    ),
    Product(
      id: 5,
      name: 'Oli Gardan',
      category: 'Oli',
      image: 'https://images.unsplash.com/photo-1635784063381-cc2e4a5c1d8e?w=500',
      price: 35000,
      description: 'Oli gardan untuk menjaga sistem transmisi motor matic.',
    ),
    Product(
      id: 6,
      name: 'Ban Sport',
      category: 'Ban',
      image: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=500',
      price: 185000,
      description: 'Ban sport dengan desain modern dan nyaman digunakan.',
    ),
  ];

  static List<Order> orders = [
    Order(
      name: 'Oli Mesin 10W-40',
      date: '19 November 2026',
      price: 55000,
      status: 'Dalam Perjalanan',
      image: 'https://images.unsplash.com/photo-1635784063381-cc2e4a5c1d8e?w=500',
    ),
    Order(
      name: 'Kampas Rem',
      date: '15 November 2026',
      price: 45000,
      status: 'Selesai',
      image: 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=500',
    ),
    Order(
      name: 'Ban Motor Tubeless',
      date: '18 November 2026',
      price: 220000,
      status: 'Masih di PO',
      image: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=500',
    ),
  ];
}