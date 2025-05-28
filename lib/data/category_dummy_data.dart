// lib/data/category_dummy_data.dart
import 'package:satufakta/models/category_page_models.dart'; // Sesuaikan path

final List<CategoryItemModel> DUMMY_CATEGORIES_PAGE = [
  CategoryItemModel(
    id: 'cat1',
    title: 'Mobil',
    imageUrl: 'https://picsum.photos/seed/car_cat_page/300/200',
    subCategories: ['Berita Mobil', 'Artikel Mobil', 'Harga Mobil', 'Video Mobil'],
  ),
  CategoryItemModel(
    id: 'cat2',
    title: 'Gaya Hidup',
    imageUrl: 'https://picsum.photos/seed/lifestyle_cat_page/300/200',
    subCategories: ['Pelatihan Tari', 'Film & Buku', 'Pelatihan Memasak'],
  ),
  CategoryItemModel(
    id: 'cat3',
    title: 'Memasak',
    imageUrl: 'https://picsum.photos/seed/cooking_cat_page2/300/200',
    subCategories: ['Membuat Kue', 'Pelatihan Memasak Pro'],
  ),
  CategoryItemModel(
    id: 'cat4',
    title: 'Teknologi',
    imageUrl: 'https://picsum.photos/seed/tech_cat_page2/300/200',
    subCategories: ['Sistem Operasi', 'Internet & Jaringan'],
  ),
  CategoryItemModel(
    id: 'cat5',
    title: 'Olahraga',
    imageUrl: 'https://picsum.photos/seed/sport_cat_page2/300/200',
    subCategories: ['Berita Olahraga', 'Hasil Sepak Bola', 'Hasil Tinju'],
  ),
  CategoryItemModel(
    id: 'cat6',
    title: 'Musik',
    imageUrl: 'https://picsum.photos/seed/music_cat_page2/300/200',
    subCategories: ['Komposisi', 'Efek Musik', 'Mix Musik'],
  ),
];

final List<ArticleItemModel> DUMMY_ARTICLES_PAGE = [
  ArticleItemModel(
    id: 'art1',
    title: 'Musim Balap Mobil Dimulai di Sirkuit Mandalika',
    imageUrl: 'https://picsum.photos/seed/car_article_page/600/350',
    authorName: 'Budi Santoso',
    authorImageUrl: 'https://picsum.photos/seed/author_budi/50/50',
    date: 'Mei 28, 2025',
    categoryId: 'cat1',
  ),
  ArticleItemModel(
    id: 'art2',
    title: 'Resep Kue Coklat Lumer Anti Gagal',
    imageUrl: 'https://picsum.photos/seed/cooking_article_page/600/350',
    authorName: 'Chef Aiko',
    authorImageUrl: 'https://picsum.photos/seed/author_aiko/50/50',
    date: 'Mei 27, 2025',
    categoryId: 'cat3',
  ),
  ArticleItemModel(
    id: 'art3',
    title: 'Update Terbaru OS Android: Fitur dan Keamanan',
    imageUrl: 'https://picsum.photos/seed/tech_article_page/600/350',
    authorName: 'Gadget Master',
    authorImageUrl: 'https://picsum.photos/seed/author_gadget/50/50',
    date: 'Mei 26, 2025',
    categoryId: 'cat4',
  ),
  // Tambahkan artikel lain untuk kategori lain jika diperlukan
   ArticleItemModel(
    id: 'art4',
    title: 'Tips Membeli Mobil Bekas Berkualitas',
    imageUrl: 'https://picsum.photos/seed/car_article_page2/600/350',
    authorName: 'Rian Otomotif',
    authorImageUrl: 'https://picsum.photos/seed/author_rian/50/50',
    date: 'Mei 25, 2025',
    categoryId: 'cat1',
  ),
];