-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Jan 2025 pada 15.33
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `buahsegar`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `category`
--

CREATE TABLE `category` (
  `id_category` int(11) NOT NULL,
  `name_category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `category`
--

INSERT INTO `category` (`id_category`, `name_category`) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

-- --------------------------------------------------------

--
-- Struktur dari tabel `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pesan` text NOT NULL,
  `waktu_kirim` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `messages`
--

INSERT INTO `messages` (`id`, `nama`, `email`, `pesan`, `waktu_kirim`) VALUES
(6, 'cust 1', 'reyza-gigih@gmail.com', 'kak manfaat kelapa kopyor sih apa kak?izin bertanya buat penelitian studi club', '2025-01-05 14:59:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name_product` varchar(100) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `manfaat` varchar(255) DEFAULT NULL,
  `vitamin` int(11) DEFAULT NULL,
  `kategori` tinyint(1) DEFAULT NULL,
  `deskripsi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `product`
--

INSERT INTO `product` (`id`, `name_product`, `image_url`, `manfaat`, `vitamin`, `kategori`, `deskripsi`) VALUES
(36, 'JERUK', 'https://e-katalog.lkpp.go.id/katalog/produk/download/gambar/972049577', 'Jeruk membantu meningkatkan daya tahan tubuh, mencegah flu dan batuk, serta menjaga kesehatan kulit dengan meningkatkan produksi kolagen, DLL', 3, 1, 'Jeruk adalah buah yang mudah ditemukan dengan kulit berwarna oranye terang dan rasa manis asam yang menyegarkan. Selain itu, jeruk kaya akan vitamin C yang sangat baik untuk tubuh.'),
(37, 'MANGGA', 'https://assets.unileversolutions.com/v1/50548755.jpg', 'Mangga mendukung kesehatan mata berkat kandungan vitamin A-nya, Buah ini juga membantu pencernaan dan memberikan kulit yang sehat, DLL', 2, 1, 'Mangga dikenal sebagai \"Raja Buah\" karena rasanya yang manis dan teksturnya yang lembut. Mangga kaya akan vitamin A dan C, serta berbagai antioksidan.'),
(38, 'PISANG', 'https://asset.kompas.com/crops/cS7yZPhl0Hnmn8EQ7itk3FqMVdg=/64x54:554x381/1200x800/data/photo/2023/03/10/640a9a7b1ce3d.jpeg', 'Pisang memberikan energi cepat berkat kandungan karbohidratnya yang mudah dicerna. Selain itu, pisang menjaga keseimbangan elektrolit dalam tubuh, DLL', 3, 1, 'Pisang adalah buah yang kaya kalium dan vitamin B6, memiliki rasa manis alami, dan tekstur lembut yang mudah dikonsumsi.'),
(39, 'APEL', 'https://asset.kompas.com/crops/smfd25xgXRE3HpMLb2aamPeulYM=/21x0:1476x970/1200x800/data/photo/2022/08/30/630d7ae5d041f.jpg', 'Apel membantu menurunkan kolesterol jahat (LDL) berkat kandungan seratnya, meningkatkan pencernaan, serta mendukung kesehatan jantung.DLL', 3, 1, ' Apel adalah buah yang renyah dan segar, biasanya berwarna merah, hijau, atau kuning. Mengandung vitamin C dan serat yang tinggi'),
(40, 'KIWI', 'https://static.honestdocs.id/system/blog_articles/main_hero_images/000/002/004/original/Manfaat_Buah_Kiwi_Bagi_Kesehatan.jpg', 'Kiwi meningkatkan sistem kekebalan tubuh, memperbaiki kesehatan kulit, dan membantu pencernaan dengan kandungan serat dan enzimnya. Kiwi juga kaya akan antioksidan yang melawan radikal bebas dan melindungi sel-sel tubuh.', 3, 1, 'Kiwi memiliki kulit kecoklatan yang berbulu dan daging berwarna hijau terang dengan biji kecil yang dapat dimakan. Kiwi kaya akan vitamin C dan K.'),
(41, 'STRAWBERRY', 'https://assets-pergikuliner.com/xS3aep3w4dgC4eRO3R2MEEO0wLo=/fit-in/1366x768/smart/filters:no_upscale()/https://assets-pergikuliner.com/uploads/bootsy/image/23993/07000-fig1.jpg', ' Strawberry membantu menjaga kesehatan jantung, mengurangi peradangan, dan melawan penuaan berkat kandungan antioksidannya. Selain itu, vitamin C dalam strawberry membantu memperbaiki kulit dan meningkatkan sistem imun tubuh.', 3, 0, 'Strawberry adalah buah kecil berwarna merah cerah dengan rasa manis asam yang menyegarkan. Kaya akan vitamin C, serat, dan antioksidan.'),
(42, 'PEPAYA', 'https://pertanian.sultengprov.go.id/cetak-pepaya-berkualitas/Cara-Mencangkok-Pohon-Pepaya-Yang-Benar.jpg', 'Pepaya mendukung kesehatan mata berkat vitamin A, meningkatkan sistem imun tubuh dengan vitamin C, dan memperbaiki pencernaan berkat enzim papain. Pepaya juga memiliki efek anti-inflamasi yang baik untuk tubuh.', 3, 1, 'Pepaya adalah buah tropis yang memiliki daging berwarna oranye cerah dan rasa manis yang lembut. Kaya akan vitamin A dan C.'),
(43, 'NANAS', 'https://lh3.googleusercontent.com/proxy/UTI9eg6RBRyhandT8Thjn4i_Qk2LrcICScdsdCIzhKrYvspIlQGw9rYhoemSEexR8upQZofyUI9kV3orRtuygXdg2KUZvw2Z074qVGT08lvloA=s0-d', 'Nanas meningkatkan sistem kekebalan tubuh berkat vitamin C-nya, membantu pencernaan berkat enzim bromelain, dan mengurangi peradangan di tubuh. Buah ini juga baik untuk menjaga kesehatan tulang dan gigi.', 3, 0, 'Nanas adalah buah tropis dengan kulit berduri dan daging berwarna kuning cerah yang rasanya manis dan sedikit asam. Nanas mengandung vitamin C dan B6.');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id_category`);

--
-- Indeks untuk tabel `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `category`
--
ALTER TABLE `category`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
