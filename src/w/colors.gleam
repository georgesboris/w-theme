import gleam_community/colour

fn color(r, g, b) {
  let assert Ok(c) = colour.from_rgb255(r, g, b)

  c
}

pub type ColorScale {
  ColorScale(
    bg: colour.Color,
    bg_subtle: colour.Color,
    tint: colour.Color,
    tint_subtle: colour.Color,
    tint_strong: colour.Color,
    accent: colour.Color,
    accent_subtle: colour.Color,
    accent_strong: colour.Color,
    solid: colour.Color,
    solid_subtle: colour.Color,
    solid_strong: colour.Color,
    solid_text: colour.Color,
    text: colour.Color,
    text_subtle: colour.Color,
  )
}

pub fn gray() {
  ColorScale(
    bg: color(252, 252, 252),
    bg_subtle: color(249, 249, 249),
    tint_subtle: color(240, 240, 240),
    tint: color(232, 232, 232),
    tint_strong: color(224, 224, 224),
    accent_subtle: color(217, 217, 217),
    accent: color(206, 206, 206),
    accent_strong: color(187, 187, 187),
    solid_subtle: color(151, 151, 151),
    solid: color(141, 141, 141),
    solid_strong: color(131, 131, 131),
    solid_text: color(255, 255, 255),
    text_subtle: color(100, 100, 100),
    text: color(32, 32, 32),
  )
}

pub fn mauve() {
  ColorScale(
    bg: color(253, 252, 253),
    bg_subtle: color(250, 249, 251),
    tint_subtle: color(242, 239, 243),
    tint: color(234, 231, 236),
    tint_strong: color(227, 223, 230),
    accent_subtle: color(219, 216, 224),
    accent: color(208, 205, 215),
    accent_strong: color(188, 186, 199),
    solid_subtle: color(152, 150, 163),
    solid: color(142, 140, 153),
    solid_strong: color(132, 130, 142),
    solid_text: color(255, 255, 255),
    text_subtle: color(101, 99, 109),
    text: color(33, 31, 38),
  )
}

pub fn slate() {
  ColorScale(
    bg: color(252, 252, 253),
    bg_subtle: color(249, 249, 251),
    tint_subtle: color(240, 240, 243),
    tint: color(232, 232, 236),
    tint_strong: color(224, 225, 230),
    accent_subtle: color(217, 217, 224),
    accent: color(205, 206, 214),
    accent_strong: color(185, 187, 198),
    solid_subtle: color(150, 152, 162),
    solid: color(139, 141, 152),
    solid_strong: color(128, 131, 141),
    solid_text: color(255, 255, 255),
    text_subtle: color(96, 100, 108),
    text: color(28, 32, 36),
  )
}

pub fn sage() {
  ColorScale(
    bg: color(251, 253, 252),
    bg_subtle: color(247, 249, 248),
    tint_subtle: color(238, 241, 240),
    tint: color(230, 233, 232),
    tint_strong: color(223, 226, 224),
    accent_subtle: color(215, 218, 217),
    accent: color(203, 207, 205),
    accent_strong: color(184, 188, 186),
    solid_subtle: color(144, 151, 148),
    solid: color(134, 142, 139),
    solid_strong: color(124, 132, 129),
    solid_text: color(255, 255, 255),
    text_subtle: color(95, 101, 99),
    text: color(26, 33, 30),
  )
}

pub fn olive() {
  ColorScale(
    bg: color(252, 253, 252),
    bg_subtle: color(248, 250, 248),
    tint_subtle: color(239, 241, 239),
    tint: color(231, 233, 231),
    tint_strong: color(223, 226, 223),
    accent_subtle: color(215, 218, 215),
    accent: color(204, 207, 204),
    accent_strong: color(185, 188, 184),
    solid_subtle: color(147, 151, 145),
    solid: color(137, 142, 135),
    solid_strong: color(127, 132, 125),
    solid_text: color(255, 255, 255),
    text_subtle: color(96, 101, 95),
    text: color(29, 33, 28),
  )
}

pub fn sand() {
  ColorScale(
    bg: color(253, 253, 252),
    bg_subtle: color(249, 249, 248),
    tint_subtle: color(241, 240, 239),
    tint: color(233, 232, 230),
    tint_strong: color(226, 225, 222),
    accent_subtle: color(218, 217, 214),
    accent: color(207, 206, 202),
    accent_strong: color(188, 187, 181),
    solid_subtle: color(151, 151, 144),
    solid: color(141, 141, 134),
    solid_strong: color(130, 130, 124),
    solid_text: color(255, 255, 255),
    text_subtle: color(99, 99, 94),
    text: color(33, 32, 28),
  )
}

pub fn tomato() {
  ColorScale(
    bg: color(255, 252, 252),
    bg_subtle: color(255, 248, 247),
    tint_subtle: color(254, 235, 231),
    tint: color(255, 220, 211),
    tint_strong: color(255, 205, 194),
    accent_subtle: color(253, 189, 175),
    accent: color(245, 168, 152),
    accent_strong: color(236, 142, 123),
    solid_subtle: color(236, 86, 55),
    solid: color(229, 77, 46),
    solid_strong: color(221, 68, 37),
    solid_text: color(255, 255, 255),
    text_subtle: color(209, 52, 21),
    text: color(92, 39, 31),
  )
}

pub fn red() {
  ColorScale(
    bg: color(255, 252, 252),
    bg_subtle: color(255, 247, 247),
    tint_subtle: color(254, 235, 236),
    tint: color(255, 219, 220),
    tint_strong: color(255, 205, 206),
    accent_subtle: color(253, 189, 190),
    accent: color(244, 169, 170),
    accent_strong: color(235, 142, 144),
    solid_subtle: color(236, 83, 88),
    solid: color(229, 72, 77),
    solid_strong: color(220, 62, 66),
    solid_text: color(255, 255, 255),
    text_subtle: color(206, 44, 49),
    text: color(100, 23, 35),
  )
}

pub fn ruby() {
  ColorScale(
    bg: color(255, 252, 253),
    bg_subtle: color(255, 247, 248),
    tint_subtle: color(254, 234, 237),
    tint: color(255, 220, 225),
    tint_strong: color(255, 206, 214),
    accent_subtle: color(248, 191, 200),
    accent: color(239, 172, 184),
    accent_strong: color(229, 146, 163),
    solid_subtle: color(236, 82, 113),
    solid: color(229, 70, 102),
    solid_strong: color(220, 59, 93),
    solid_text: color(255, 255, 255),
    text_subtle: color(202, 36, 77),
    text: color(100, 23, 43),
  )
}

pub fn crimson() {
  ColorScale(
    bg: color(255, 252, 253),
    bg_subtle: color(254, 247, 249),
    tint_subtle: color(255, 233, 240),
    tint: color(254, 220, 231),
    tint_strong: color(250, 206, 221),
    accent_subtle: color(243, 190, 209),
    accent: color(234, 172, 195),
    accent_strong: color(224, 147, 178),
    solid_subtle: color(241, 71, 139),
    solid: color(233, 61, 130),
    solid_strong: color(223, 52, 120),
    solid_text: color(255, 255, 255),
    text_subtle: color(203, 29, 99),
    text: color(98, 22, 57),
  )
}

pub fn pink() {
  ColorScale(
    bg: color(255, 252, 254),
    bg_subtle: color(254, 247, 251),
    tint_subtle: color(254, 233, 245),
    tint: color(251, 220, 239),
    tint_strong: color(246, 206, 231),
    accent_subtle: color(239, 191, 221),
    accent: color(231, 172, 208),
    accent_strong: color(221, 147, 194),
    solid_subtle: color(220, 72, 166),
    solid: color(214, 64, 159),
    solid_strong: color(207, 56, 151),
    solid_text: color(255, 255, 255),
    text_subtle: color(194, 41, 138),
    text: color(101, 18, 73),
  )
}

pub fn plum() {
  ColorScale(
    bg: color(254, 252, 255),
    bg_subtle: color(253, 247, 253),
    tint_subtle: color(251, 235, 251),
    tint: color(247, 222, 248),
    tint_strong: color(242, 209, 243),
    accent_subtle: color(233, 194, 236),
    accent: color(222, 173, 227),
    accent_strong: color(207, 145, 216),
    solid_subtle: color(177, 85, 191),
    solid: color(171, 74, 186),
    solid_strong: color(161, 68, 175),
    solid_text: color(255, 255, 255),
    text_subtle: color(149, 62, 163),
    text: color(83, 25, 93),
  )
}

pub fn purple() {
  ColorScale(
    bg: color(254, 252, 254),
    bg_subtle: color(251, 247, 254),
    tint_subtle: color(247, 237, 254),
    tint: color(242, 226, 252),
    tint_strong: color(234, 213, 249),
    accent_subtle: color(224, 196, 244),
    accent: color(209, 175, 236),
    accent_strong: color(190, 147, 228),
    solid_subtle: color(152, 86, 209),
    solid: color(142, 78, 198),
    solid_strong: color(131, 71, 185),
    solid_text: color(255, 255, 255),
    text_subtle: color(129, 69, 181),
    text: color(64, 32, 96),
  )
}

pub fn violet() {
  ColorScale(
    bg: color(253, 252, 254),
    bg_subtle: color(250, 248, 255),
    tint_subtle: color(244, 240, 254),
    tint: color(235, 228, 255),
    tint_strong: color(225, 217, 255),
    accent_subtle: color(212, 202, 254),
    accent: color(194, 181, 245),
    accent_strong: color(170, 153, 236),
    solid_subtle: color(120, 96, 216),
    solid: color(110, 86, 207),
    solid_strong: color(101, 77, 196),
    solid_text: color(255, 255, 255),
    text_subtle: color(101, 80, 185),
    text: color(47, 38, 95),
  )
}

pub fn iris() {
  ColorScale(
    bg: color(253, 253, 255),
    bg_subtle: color(248, 248, 255),
    tint_subtle: color(240, 241, 254),
    tint: color(230, 231, 255),
    tint_strong: color(218, 220, 255),
    accent_subtle: color(203, 205, 255),
    accent: color(184, 186, 248),
    accent_strong: color(155, 158, 240),
    solid_subtle: color(101, 101, 222),
    solid: color(91, 91, 214),
    solid_strong: color(81, 81, 205),
    solid_text: color(255, 255, 255),
    text_subtle: color(87, 83, 198),
    text: color(39, 41, 98),
  )
}

pub fn indigo() {
  ColorScale(
    bg: color(253, 253, 254),
    bg_subtle: color(247, 249, 255),
    tint_subtle: color(237, 242, 254),
    tint: color(225, 233, 255),
    tint_strong: color(210, 222, 255),
    accent_subtle: color(193, 208, 255),
    accent: color(171, 189, 249),
    accent_strong: color(141, 164, 239),
    solid_subtle: color(73, 110, 229),
    solid: color(62, 99, 221),
    solid_strong: color(51, 88, 212),
    solid_text: color(255, 255, 255),
    text_subtle: color(58, 91, 199),
    text: color(31, 45, 92),
  )
}

pub fn blue() {
  ColorScale(
    bg: color(251, 253, 255),
    bg_subtle: color(244, 250, 255),
    tint_subtle: color(230, 244, 254),
    tint: color(213, 239, 255),
    tint_strong: color(194, 229, 255),
    accent_subtle: color(172, 216, 252),
    accent: color(142, 200, 246),
    accent_strong: color(94, 177, 239),
    solid_subtle: color(5, 148, 260),
    solid: color(0, 144, 255),
    solid_strong: color(5, 136, 240),
    solid_text: color(255, 255, 255),
    text_subtle: color(13, 116, 206),
    text: color(17, 50, 100),
  )
}

pub fn cyan() {
  ColorScale(
    bg: color(250, 253, 254),
    bg_subtle: color(242, 250, 251),
    tint_subtle: color(222, 247, 249),
    tint: color(202, 241, 246),
    tint_strong: color(181, 233, 240),
    accent_subtle: color(157, 221, 231),
    accent: color(125, 206, 220),
    accent_strong: color(61, 185, 207),
    solid_subtle: color(247, 172, 213),
    solid: color(0, 162, 199),
    solid_strong: color(7, 151, 185),
    solid_text: color(255, 255, 255),
    text_subtle: color(16, 125, 152),
    text: color(13, 60, 72),
  )
}

pub fn teal() {
  ColorScale(
    bg: color(250, 254, 253),
    bg_subtle: color(243, 251, 249),
    tint_subtle: color(224, 248, 243),
    tint: color(204, 243, 234),
    tint_strong: color(184, 234, 224),
    accent_subtle: color(161, 222, 210),
    accent: color(131, 205, 193),
    accent_strong: color(83, 185, 171),
    solid_subtle: color(23, 174, 156),
    solid: color(18, 165, 148),
    solid_strong: color(13, 155, 138),
    solid_text: color(255, 255, 255),
    text_subtle: color(0, 133, 115),
    text: color(13, 61, 56),
  )
}

pub fn jade() {
  ColorScale(
    bg: color(251, 254, 253),
    bg_subtle: color(244, 251, 247),
    tint_subtle: color(230, 247, 237),
    tint: color(214, 241, 227),
    tint_strong: color(195, 233, 215),
    accent_subtle: color(172, 222, 200),
    accent: color(139, 206, 182),
    accent_strong: color(86, 186, 159),
    solid_subtle: color(44, 172, 139),
    solid: color(41, 163, 131),
    solid_strong: color(38, 153, 123),
    solid_text: color(255, 255, 255),
    text_subtle: color(32, 131, 104),
    text: color(29, 59, 49),
  )
}

pub fn green() {
  ColorScale(
    bg: color(251, 254, 252),
    bg_subtle: color(244, 251, 246),
    tint_subtle: color(230, 246, 235),
    tint: color(214, 241, 223),
    tint_strong: color(196, 232, 209),
    accent_subtle: color(173, 221, 192),
    accent: color(142, 206, 170),
    accent_strong: color(91, 185, 139),
    solid_subtle: color(53, 173, 115),
    solid: color(48, 164, 108),
    solid_strong: color(43, 154, 102),
    solid_text: color(255, 255, 255),
    text_subtle: color(33, 131, 88),
    text: color(25, 59, 45),
  )
}

pub fn grass() {
  ColorScale(
    bg: color(251, 254, 251),
    bg_subtle: color(245, 251, 245),
    tint_subtle: color(233, 246, 233),
    tint: color(218, 241, 219),
    tint_strong: color(201, 232, 202),
    accent_subtle: color(178, 221, 181),
    accent: color(148, 206, 154),
    accent_strong: color(101, 186, 116),
    solid_subtle: color(79, 177, 97),
    solid: color(70, 167, 88),
    solid_strong: color(62, 155, 79),
    solid_text: color(255, 255, 255),
    text_subtle: color(42, 126, 59),
    text: color(32, 60, 37),
  )
}

pub fn brown() {
  ColorScale(
    bg: color(254, 253, 252),
    bg_subtle: color(252, 249, 246),
    tint_subtle: color(246, 238, 231),
    tint: color(240, 228, 217),
    tint_strong: color(235, 218, 202),
    accent_subtle: color(228, 205, 183),
    accent: color(220, 188, 159),
    accent_strong: color(206, 163, 126),
    solid_subtle: color(181, 136, 97),
    solid: color(173, 127, 88),
    solid_strong: color(160, 117, 83),
    solid_text: color(255, 255, 255),
    text_subtle: color(129, 94, 70),
    text: color(62, 51, 46),
  )
}

pub fn bronze() {
  ColorScale(
    bg: color(253, 252, 252),
    bg_subtle: color(253, 247, 245),
    tint_subtle: color(246, 237, 234),
    tint: color(239, 228, 223),
    tint_strong: color(231, 217, 211),
    accent_subtle: color(223, 205, 197),
    accent: color(211, 188, 179),
    accent_strong: color(194, 164, 153),
    solid_subtle: color(172, 138, 124),
    solid: color(161, 128, 114),
    solid_strong: color(149, 116, 104),
    solid_text: color(255, 255, 255),
    text_subtle: color(125, 94, 84),
    text: color(67, 48, 43),
  )
}

pub fn gold() {
  ColorScale(
    bg: color(253, 253, 252),
    bg_subtle: color(250, 249, 242),
    tint_subtle: color(242, 240, 231),
    tint: color(234, 230, 219),
    tint_strong: color(225, 220, 207),
    accent_subtle: color(216, 208, 191),
    accent: color(203, 192, 170),
    accent_strong: color(185, 168, 141),
    solid_subtle: color(159, 139, 110),
    solid: color(151, 131, 101),
    solid_strong: color(140, 122, 94),
    solid_text: color(255, 255, 255),
    text_subtle: color(113, 98, 75),
    text: color(59, 53, 43),
  )
}

pub fn sky() {
  ColorScale(
    bg: color(249, 254, 255),
    bg_subtle: color(241, 250, 253),
    tint_subtle: color(225, 246, 253),
    tint: color(209, 240, 250),
    tint_strong: color(190, 231, 245),
    accent_subtle: color(169, 218, 237),
    accent: color(141, 202, 227),
    accent_strong: color(96, 179, 215),
    solid_subtle: color(133, 231, 258),
    solid: color(124, 226, 254),
    solid_strong: color(116, 218, 248),
    solid_text: color(29, 62, 86),
    text_subtle: color(0, 116, 158),
    text: color(29, 62, 86),
  )
}

pub fn mint() {
  ColorScale(
    bg: color(249, 254, 253),
    bg_subtle: color(242, 251, 249),
    tint_subtle: color(221, 249, 242),
    tint: color(200, 244, 233),
    tint_strong: color(179, 236, 222),
    accent_subtle: color(156, 224, 208),
    accent: color(126, 207, 189),
    accent_strong: color(76, 187, 165),
    solid_subtle: color(144, 242, 220),
    solid: color(134, 234, 212),
    solid_strong: color(125, 224, 203),
    solid_text: color(22, 67, 60),
    text_subtle: color(2, 120, 100),
    text: color(22, 67, 60),
  )
}

pub fn lime() {
  ColorScale(
    bg: color(252, 253, 250),
    bg_subtle: color(248, 250, 243),
    tint_subtle: color(238, 246, 214),
    tint: color(226, 240, 189),
    tint_strong: color(211, 231, 166),
    accent_subtle: color(194, 218, 145),
    accent: color(171, 201, 120),
    accent_strong: color(141, 182, 84),
    solid_subtle: color(201, 244, 123),
    solid: color(189, 238, 99),
    solid_strong: color(176, 230, 76),
    solid_text: color(55, 64, 28),
    text_subtle: color(92, 124, 47),
    text: color(55, 64, 28),
  )
}

pub fn yellow() {
  ColorScale(
    bg: color(253, 253, 249),
    bg_subtle: color(254, 252, 233),
    tint_subtle: color(255, 250, 184),
    tint: color(255, 243, 148),
    tint_strong: color(255, 231, 112),
    accent_subtle: color(243, 215, 104),
    accent: color(228, 199, 103),
    accent_strong: color(213, 174, 57),
    solid_subtle: color(255, 234, 82),
    solid: color(255, 230, 41),
    solid_strong: color(255, 220, 0),
    solid_text: color(71, 59, 31),
    text_subtle: color(158, 108, 0),
    text: color(71, 59, 31),
  )
}

pub fn amber() {
  ColorScale(
    bg: color(254, 253, 251),
    bg_subtle: color(254, 251, 233),
    tint_subtle: color(255, 247, 194),
    tint: color(255, 238, 156),
    tint_strong: color(251, 229, 119),
    accent_subtle: color(243, 214, 115),
    accent: color(233, 193, 98),
    accent_strong: color(226, 163, 54),
    solid_subtle: color(255, 208, 97),
    solid: color(255, 197, 61),
    solid_strong: color(255, 186, 24),
    solid_text: color(79, 52, 34),
    text_subtle: color(171, 100, 0),
    text: color(79, 52, 34),
  )
}

pub fn orange() {
  ColorScale(
    bg: color(254, 252, 251),
    bg_subtle: color(255, 247, 237),
    tint_subtle: color(255, 239, 214),
    tint: color(255, 223, 181),
    tint_strong: color(255, 209, 154),
    accent_subtle: color(255, 193, 130),
    accent: color(245, 174, 115),
    accent_strong: color(236, 148, 85),
    solid_subtle: color(240, 126, 56),
    solid: color(247, 107, 21),
    solid_strong: color(239, 95, 0),
    solid_text: color(255, 255, 255),
    text_subtle: color(204, 78, 0),
    text: color(88, 45, 29),
  )
}

pub fn gray_dark() {
  ColorScale(
    bg: color(25, 25, 25),
    bg_subtle: color(17, 17, 17),
    tint_subtle: color(34, 34, 34),
    tint: color(42, 42, 42),
    tint_strong: color(49, 49, 49),
    accent_subtle: color(58, 58, 58),
    accent: color(72, 72, 72),
    accent_strong: color(96, 96, 96),
    solid_subtle: color(97, 97, 97),
    solid: color(110, 110, 110),
    solid_strong: color(123, 123, 123),
    solid_text: color(255, 255, 255),
    text_subtle: color(180, 180, 180),
    text: color(238, 238, 238),
  )
}

pub fn mauve_dark() {
  ColorScale(
    bg: color(26, 25, 27),
    bg_subtle: color(18, 17, 19),
    tint_subtle: color(35, 34, 37),
    tint: color(43, 41, 45),
    tint_strong: color(50, 48, 53),
    accent_subtle: color(60, 57, 63),
    accent: color(73, 71, 78),
    accent_strong: color(98, 95, 105),
    solid_subtle: color(98, 96, 106),
    solid: color(111, 109, 120),
    solid_strong: color(124, 122, 133),
    solid_text: color(255, 255, 255),
    text_subtle: color(181, 178, 188),
    text: color(238, 238, 240),
  )
}

pub fn slate_dark() {
  ColorScale(
    bg: color(24, 25, 27),
    bg_subtle: color(17, 17, 19),
    tint_subtle: color(33, 34, 37),
    tint: color(39, 42, 45),
    tint_strong: color(46, 49, 53),
    accent_subtle: color(54, 58, 63),
    accent: color(67, 72, 78),
    accent_strong: color(90, 97, 105),
    solid_subtle: color(91, 96, 105),
    solid: color(105, 110, 119),
    solid_strong: color(119, 123, 132),
    solid_text: color(255, 255, 255),
    text_subtle: color(176, 180, 186),
    text: color(237, 238, 240),
  )
}

pub fn sage_dark() {
  ColorScale(
    bg: color(23, 25, 24),
    bg_subtle: color(16, 18, 17),
    tint_subtle: color(32, 34, 33),
    tint: color(39, 42, 41),
    tint_strong: color(46, 49, 48),
    accent_subtle: color(55, 59, 57),
    accent: color(68, 73, 71),
    accent_strong: color(91, 98, 95),
    solid_subtle: color(85, 98, 93),
    solid: color(99, 112, 107),
    solid_strong: color(113, 125, 121),
    solid_text: color(255, 255, 255),
    text_subtle: color(173, 181, 178),
    text: color(236, 238, 237),
  )
}

pub fn olive_dark() {
  ColorScale(
    bg: color(24, 25, 23),
    bg_subtle: color(17, 18, 16),
    tint_subtle: color(33, 34, 32),
    tint: color(40, 42, 39),
    tint_strong: color(47, 49, 46),
    accent_subtle: color(56, 58, 54),
    accent: color(69, 72, 67),
    accent_strong: color(92, 98, 91),
    solid_subtle: color(90, 98, 88),
    solid: color(104, 112, 102),
    solid_strong: color(118, 125, 116),
    solid_text: color(255, 255, 255),
    text_subtle: color(175, 181, 173),
    text: color(236, 238, 236),
  )
}

pub fn sand_dark() {
  ColorScale(
    bg: color(25, 25, 24),
    bg_subtle: color(17, 17, 16),
    tint_subtle: color(34, 34, 33),
    tint: color(42, 42, 40),
    tint_strong: color(49, 49, 46),
    accent_subtle: color(59, 58, 55),
    accent: color(73, 72, 68),
    accent_strong: color(98, 96, 91),
    solid_subtle: color(97, 95, 88),
    solid: color(111, 109, 102),
    solid_strong: color(124, 123, 116),
    solid_text: color(255, 255, 255),
    text_subtle: color(181, 179, 173),
    text: color(238, 238, 236),
  )
}

pub fn tomato_dark() {
  ColorScale(
    bg: color(31, 21, 19),
    bg_subtle: color(24, 17, 17),
    tint_subtle: color(57, 23, 20),
    tint: color(78, 21, 17),
    tint_strong: color(94, 28, 22),
    accent_subtle: color(110, 41, 32),
    accent: color(133, 58, 45),
    accent_strong: color(172, 77, 57),
    solid_subtle: color(215, 63, 32),
    solid: color(229, 77, 46),
    solid_strong: color(236, 97, 66),
    solid_text: color(255, 255, 255),
    text_subtle: color(255, 151, 125),
    text: color(251, 211, 203),
  )
}

pub fn red_dark() {
  ColorScale(
    bg: color(32, 19, 20),
    bg_subtle: color(25, 17, 17),
    tint_subtle: color(59, 18, 25),
    tint: color(80, 15, 28),
    tint_strong: color(97, 22, 35),
    accent_subtle: color(114, 35, 45),
    accent: color(140, 51, 58),
    accent_strong: color(181, 69, 72),
    solid_subtle: color(220, 52, 57),
    solid: color(229, 72, 77),
    solid_strong: color(236, 93, 94),
    solid_text: color(255, 255, 255),
    text_subtle: color(255, 149, 146),
    text: color(255, 209, 217),
  )
}

pub fn ruby_dark() {
  ColorScale(
    bg: color(30, 21, 23),
    bg_subtle: color(25, 17, 19),
    tint_subtle: color(58, 20, 30),
    tint: color(78, 19, 37),
    tint_strong: color(94, 26, 46),
    accent_subtle: color(111, 37, 57),
    accent: color(136, 52, 71),
    accent_strong: color(179, 68, 90),
    solid_subtle: color(220, 51, 85),
    solid: color(229, 70, 102),
    solid_strong: color(236, 90, 114),
    solid_text: color(255, 255, 255),
    text_subtle: color(255, 148, 157),
    text: color(254, 210, 225),
  )
}

pub fn crimson_dark() {
  ColorScale(
    bg: color(32, 19, 24),
    bg_subtle: color(25, 17, 20),
    tint_subtle: color(56, 21, 37),
    tint: color(77, 18, 47),
    tint_strong: color(92, 24, 57),
    accent_subtle: color(109, 37, 69),
    accent: color(135, 51, 86),
    accent_strong: color(176, 67, 110),
    solid_subtle: color(227, 41, 116),
    solid: color(233, 61, 130),
    solid_strong: color(238, 81, 138),
    solid_text: color(255, 255, 255),
    text_subtle: color(255, 146, 173),
    text: color(253, 211, 232),
  )
}

pub fn pink_dark() {
  ColorScale(
    bg: color(33, 18, 29),
    bg_subtle: color(25, 17, 23),
    tint_subtle: color(55, 23, 47),
    tint: color(75, 20, 61),
    tint_strong: color(89, 28, 71),
    accent_subtle: color(105, 41, 85),
    accent: color(131, 56, 105),
    accent_strong: color(168, 72, 133),
    solid_subtle: color(203, 49, 147),
    solid: color(214, 64, 159),
    solid_strong: color(222, 81, 168),
    solid_text: color(255, 255, 255),
    text_subtle: color(255, 141, 204),
    text: color(253, 209, 234),
  )
}

pub fn plum_dark() {
  ColorScale(
    bg: color(32, 19, 32),
    bg_subtle: color(24, 17, 24),
    tint_subtle: color(53, 26, 53),
    tint: color(69, 29, 71),
    tint_strong: color(81, 36, 84),
    accent_subtle: color(94, 48, 97),
    accent: color(115, 64, 121),
    accent_strong: color(146, 84, 156),
    solid_subtle: color(154, 68, 167),
    solid: color(171, 74, 186),
    solid_strong: color(182, 88, 196),
    solid_text: color(255, 255, 255),
    text_subtle: color(231, 150, 243),
    text: color(244, 212, 244),
  )
}

pub fn purple_dark() {
  ColorScale(
    bg: color(30, 21, 35),
    bg_subtle: color(24, 17, 27),
    tint_subtle: color(48, 28, 59),
    tint: color(61, 34, 78),
    tint_strong: color(72, 41, 92),
    accent_subtle: color(84, 52, 107),
    accent: color(102, 66, 130),
    accent_strong: color(132, 87, 170),
    solid_subtle: color(129, 66, 185),
    solid: color(142, 78, 198),
    solid_strong: color(154, 92, 208),
    solid_text: color(255, 255, 255),
    text_subtle: color(209, 157, 255),
    text: color(236, 217, 250),
  )
}

pub fn violet_dark() {
  ColorScale(
    bg: color(27, 21, 37),
    bg_subtle: color(20, 18, 31),
    tint_subtle: color(41, 31, 67),
    tint: color(51, 37, 91),
    tint_strong: color(60, 46, 105),
    accent_subtle: color(71, 56, 118),
    accent: color(86, 70, 139),
    accent_strong: color(105, 88, 173),
    solid_subtle: color(95, 71, 195),
    solid: color(110, 86, 207),
    solid_strong: color(125, 102, 217),
    solid_text: color(255, 255, 255),
    text_subtle: color(186, 167, 255),
    text: color(226, 221, 254),
  )
}

pub fn iris_dark() {
  ColorScale(
    bg: color(23, 22, 37),
    bg_subtle: color(19, 19, 30),
    tint_subtle: color(32, 34, 72),
    tint: color(38, 42, 101),
    tint_strong: color(48, 51, 116),
    accent_subtle: color(61, 62, 130),
    accent: color(74, 74, 149),
    accent_strong: color(89, 88, 177),
    solid_subtle: color(76, 76, 205),
    solid: color(91, 91, 214),
    solid_strong: color(110, 106, 222),
    solid_text: color(255, 255, 255),
    text_subtle: color(177, 169, 255),
    text: color(224, 223, 254),
  )
}

pub fn indigo_dark() {
  ColorScale(
    bg: color(20, 23, 38),
    bg_subtle: color(17, 19, 31),
    tint_subtle: color(24, 36, 73),
    tint: color(29, 46, 98),
    tint_strong: color(37, 57, 116),
    accent_subtle: color(48, 67, 132),
    accent: color(58, 79, 151),
    accent_strong: color(67, 93, 177),
    solid_subtle: color(41, 81, 212),
    solid: color(62, 99, 221),
    solid_strong: color(84, 114, 228),
    solid_text: color(255, 255, 255),
    text_subtle: color(158, 177, 255),
    text: color(214, 225, 255),
  )
}

pub fn blue_dark() {
  ColorScale(
    bg: color(17, 25, 39),
    bg_subtle: color(13, 21, 32),
    tint_subtle: color(13, 40, 71),
    tint: color(0, 51, 98),
    tint_strong: color(0, 64, 116),
    accent_subtle: color(16, 77, 135),
    accent: color(32, 93, 158),
    accent_strong: color(40, 112, 189),
    solid_subtle: color(0, 110, 195),
    solid: color(0, 144, 255),
    solid_strong: color(59, 158, 255),
    solid_text: color(255, 255, 255),
    text_subtle: color(112, 184, 255),
    text: color(194, 230, 255),
  )
}

pub fn cyan_dark() {
  ColorScale(
    bg: color(16, 27, 32),
    bg_subtle: color(11, 22, 26),
    tint_subtle: color(8, 44, 54),
    tint: color(0, 56, 72),
    tint_strong: color(0, 69, 88),
    accent_subtle: color(4, 84, 104),
    accent: color(18, 103, 126),
    accent_strong: color(17, 128, 156),
    solid_subtle: color(232, 140, 177),
    solid: color(0, 162, 199),
    solid_strong: color(35, 175, 208),
    solid_text: color(255, 255, 255),
    text_subtle: color(76, 204, 230),
    text: color(182, 236, 247),
  )
}

pub fn teal_dark() {
  ColorScale(
    bg: color(17, 28, 27),
    bg_subtle: color(13, 21, 20),
    tint_subtle: color(13, 45, 42),
    tint: color(2, 59, 55),
    tint_strong: color(8, 72, 67),
    accent_subtle: color(20, 87, 80),
    accent: color(28, 105, 97),
    accent_strong: color(32, 126, 115),
    solid_subtle: color(21, 151, 136),
    solid: color(18, 165, 148),
    solid_strong: color(14, 179, 158),
    solid_text: color(255, 255, 255),
    text_subtle: color(11, 216, 182),
    text: color(173, 240, 221),
  )
}

pub fn jade_dark() {
  ColorScale(
    bg: color(18, 28, 24),
    bg_subtle: color(13, 21, 18),
    tint_subtle: color(15, 46, 34),
    tint: color(11, 59, 44),
    tint_strong: color(17, 72, 55),
    accent_subtle: color(27, 87, 69),
    accent: color(36, 104, 84),
    accent_strong: color(42, 126, 104),
    solid_subtle: color(42, 150, 122),
    solid: color(41, 163, 131),
    solid_strong: color(39, 176, 139),
    solid_text: color(255, 255, 255),
    text_subtle: color(31, 216, 164),
    text: color(173, 240, 212),
  )
}

pub fn green_dark() {
  ColorScale(
    bg: color(18, 27, 23),
    bg_subtle: color(14, 21, 18),
    tint_subtle: color(19, 45, 33),
    tint: color(17, 59, 41),
    tint_strong: color(23, 73, 51),
    accent_subtle: color(32, 87, 62),
    accent: color(40, 104, 74),
    accent_strong: color(47, 124, 87),
    solid_subtle: color(44, 152, 100),
    solid: color(48, 164, 108),
    solid_strong: color(51, 176, 116),
    solid_text: color(255, 255, 255),
    text_subtle: color(61, 214, 140),
    text: color(177, 241, 203),
  )
}

pub fn grass_dark() {
  ColorScale(
    bg: color(20, 26, 21),
    bg_subtle: color(14, 21, 17),
    tint_subtle: color(27, 42, 30),
    tint: color(29, 58, 36),
    tint_strong: color(37, 72, 45),
    accent_subtle: color(45, 87, 54),
    accent: color(54, 103, 64),
    accent_strong: color(62, 121, 73),
    solid_subtle: color(60, 151, 77),
    solid: color(70, 167, 88),
    solid_strong: color(83, 179, 101),
    solid_text: color(255, 255, 255),
    text_subtle: color(113, 208, 131),
    text: color(194, 240, 194),
  )
}

pub fn brown_dark() {
  ColorScale(
    bg: color(28, 24, 22),
    bg_subtle: color(18, 17, 15),
    tint_subtle: color(40, 33, 29),
    tint: color(50, 41, 34),
    tint_strong: color(62, 49, 40),
    accent_subtle: color(77, 60, 47),
    accent: color(97, 74, 57),
    accent_strong: color(124, 95, 70),
    solid_subtle: color(155, 114, 79),
    solid: color(173, 127, 88),
    solid_strong: color(184, 140, 103),
    solid_text: color(255, 255, 255),
    text_subtle: color(219, 181, 148),
    text: color(242, 225, 202),
  )
}

pub fn bronze_dark() {
  ColorScale(
    bg: color(28, 25, 23),
    bg_subtle: color(20, 17, 16),
    tint_subtle: color(38, 34, 32),
    tint: color(48, 42, 39),
    tint_strong: color(59, 51, 48),
    accent_subtle: color(73, 62, 58),
    accent: color(90, 76, 71),
    accent_strong: color(111, 95, 88),
    solid_subtle: color(146, 116, 103),
    solid: color(161, 128, 114),
    solid_strong: color(174, 140, 126),
    solid_text: color(255, 255, 255),
    text_subtle: color(212, 179, 165),
    text: color(237, 224, 217),
  )
}

pub fn gold_dark() {
  ColorScale(
    bg: color(27, 26, 23),
    bg_subtle: color(18, 18, 17),
    tint_subtle: color(36, 35, 31),
    tint: color(45, 43, 38),
    tint_strong: color(56, 53, 46),
    accent_subtle: color(68, 64, 57),
    accent: color(84, 79, 70),
    accent_strong: color(105, 98, 86),
    solid_subtle: color(134, 117, 91),
    solid: color(151, 131, 101),
    solid_strong: color(163, 144, 115),
    solid_text: color(255, 255, 255),
    text_subtle: color(203, 185, 159),
    text: color(232, 226, 217),
  )
}

pub fn sky_dark() {
  ColorScale(
    bg: color(17, 26, 39),
    bg_subtle: color(13, 20, 31),
    tint_subtle: color(17, 40, 64),
    tint: color(17, 53, 85),
    tint_strong: color(21, 68, 103),
    accent_subtle: color(27, 83, 123),
    accent: color(31, 102, 146),
    accent_strong: color(25, 124, 174),
    solid_subtle: color(80, 215, 252),
    solid: color(124, 226, 254),
    solid_strong: color(168, 238, 255),
    solid_text: color(17, 26, 39),
    text_subtle: color(117, 199, 240),
    text: color(194, 243, 255),
  )
}

pub fn mint_dark() {
  ColorScale(
    bg: color(15, 27, 27),
    bg_subtle: color(14, 21, 21),
    tint_subtle: color(9, 44, 43),
    tint: color(0, 58, 56),
    tint_strong: color(0, 71, 68),
    accent_subtle: color(16, 86, 80),
    accent: color(30, 104, 95),
    accent_strong: color(39, 127, 112),
    solid_subtle: color(104, 218, 193),
    solid: color(134, 234, 212),
    solid_strong: color(168, 245, 229),
    solid_text: color(15, 27, 27),
    text_subtle: color(88, 213, 186),
    text: color(196, 245, 225),
  )
}

pub fn lime_dark() {
  ColorScale(
    bg: color(21, 26, 16),
    bg_subtle: color(17, 19, 12),
    tint_subtle: color(31, 41, 23),
    tint: color(41, 55, 29),
    tint_strong: color(51, 68, 35),
    accent_subtle: color(61, 82, 42),
    accent: color(73, 98, 49),
    accent_strong: color(87, 117, 56),
    solid_subtle: color(171, 215, 91),
    solid: color(189, 238, 99),
    solid_strong: color(212, 255, 112),
    solid_text: color(21, 26, 16),
    text_subtle: color(189, 229, 108),
    text: color(227, 247, 186),
  )
}

pub fn yellow_dark() {
  ColorScale(
    bg: color(27, 24, 15),
    bg_subtle: color(20, 18, 11),
    tint_subtle: color(45, 35, 5),
    tint: color(54, 43, 0),
    tint_strong: color(67, 53, 0),
    accent_subtle: color(82, 66, 2),
    accent: color(102, 84, 23),
    accent_strong: color(131, 106, 33),
    solid_subtle: color(250, 220, 0),
    solid: color(255, 230, 41),
    solid_strong: color(255, 255, 87),
    solid_text: color(27, 24, 15),
    text_subtle: color(245, 225, 71),
    text: color(246, 238, 180),
  )
}

pub fn amber_dark() {
  ColorScale(
    bg: color(29, 24, 15),
    bg_subtle: color(22, 18, 12),
    tint_subtle: color(48, 32, 8),
    tint: color(63, 39, 0),
    tint_strong: color(77, 48, 0),
    accent_subtle: color(92, 61, 5),
    accent: color(113, 79, 25),
    accent_strong: color(143, 100, 36),
    solid_subtle: color(255, 212, 111),
    solid: color(255, 197, 61),
    solid_strong: color(255, 214, 10),
    solid_text: color(29, 24, 15),
    text_subtle: color(255, 202, 22),
    text: color(255, 231, 179),
  )
}

pub fn orange_dark() {
  ColorScale(
    bg: color(30, 22, 15),
    bg_subtle: color(23, 18, 14),
    tint_subtle: color(51, 30, 11),
    tint: color(70, 33, 0),
    tint_strong: color(86, 40, 0),
    accent_subtle: color(102, 53, 12),
    accent: color(126, 69, 29),
    accent_strong: color(163, 88, 41),
    solid_subtle: color(233, 99, 16),
    solid: color(247, 107, 21),
    solid_strong: color(255, 128, 31),
    solid_text: color(255, 255, 255),
    text_subtle: color(255, 160, 87),
    text: color(255, 224, 194),
  )
}
