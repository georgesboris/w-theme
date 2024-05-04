
import gleam_cummunity/colour

type ColorScale {
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


      pub const gray = ColorScale(
    
      bg: colour.from_rgb(252, 252, 252),
    
      bg_subtle: colour.from_rgb(249, 249, 249),
    
      tint_subtle: colour.from_rgb(240, 240, 240),
    
      tint: colour.from_rgb(232, 232, 232),
    
      tint_strong: colour.from_rgb(224, 224, 224),
    
      accent_subtle: colour.from_rgb(217, 217, 217),
    
      accent: colour.from_rgb(206, 206, 206),
    
      accent_strong: colour.from_rgb(187, 187, 187),
    
      solid_subtle: colour.from_rgb(151, 151, 151),
    
      solid: colour.from_rgb(141, 141, 141),
    
      solid_strong: colour.from_rgb(131, 131, 131),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(100, 100, 100),
    
      text: colour.from_rgb(32, 32, 32),
    
  ))
      
      pub const mauve = ColorScale(
    
      bg: colour.from_rgb(253, 252, 253),
    
      bg_subtle: colour.from_rgb(250, 249, 251),
    
      tint_subtle: colour.from_rgb(242, 239, 243),
    
      tint: colour.from_rgb(234, 231, 236),
    
      tint_strong: colour.from_rgb(227, 223, 230),
    
      accent_subtle: colour.from_rgb(219, 216, 224),
    
      accent: colour.from_rgb(208, 205, 215),
    
      accent_strong: colour.from_rgb(188, 186, 199),
    
      solid_subtle: colour.from_rgb(152, 150, 163),
    
      solid: colour.from_rgb(142, 140, 153),
    
      solid_strong: colour.from_rgb(132, 130, 142),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(101, 99, 109),
    
      text: colour.from_rgb(33, 31, 38),
    
  ))
      
      pub const slate = ColorScale(
    
      bg: colour.from_rgb(252, 252, 253),
    
      bg_subtle: colour.from_rgb(249, 249, 251),
    
      tint_subtle: colour.from_rgb(240, 240, 243),
    
      tint: colour.from_rgb(232, 232, 236),
    
      tint_strong: colour.from_rgb(224, 225, 230),
    
      accent_subtle: colour.from_rgb(217, 217, 224),
    
      accent: colour.from_rgb(205, 206, 214),
    
      accent_strong: colour.from_rgb(185, 187, 198),
    
      solid_subtle: colour.from_rgb(150, 152, 162),
    
      solid: colour.from_rgb(139, 141, 152),
    
      solid_strong: colour.from_rgb(128, 131, 141),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(96, 100, 108),
    
      text: colour.from_rgb(28, 32, 36),
    
  ))
      
      pub const sage = ColorScale(
    
      bg: colour.from_rgb(251, 253, 252),
    
      bg_subtle: colour.from_rgb(247, 249, 248),
    
      tint_subtle: colour.from_rgb(238, 241, 240),
    
      tint: colour.from_rgb(230, 233, 232),
    
      tint_strong: colour.from_rgb(223, 226, 224),
    
      accent_subtle: colour.from_rgb(215, 218, 217),
    
      accent: colour.from_rgb(203, 207, 205),
    
      accent_strong: colour.from_rgb(184, 188, 186),
    
      solid_subtle: colour.from_rgb(144, 151, 148),
    
      solid: colour.from_rgb(134, 142, 139),
    
      solid_strong: colour.from_rgb(124, 132, 129),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(95, 101, 99),
    
      text: colour.from_rgb(26, 33, 30),
    
  ))
      
      pub const olive = ColorScale(
    
      bg: colour.from_rgb(252, 253, 252),
    
      bg_subtle: colour.from_rgb(248, 250, 248),
    
      tint_subtle: colour.from_rgb(239, 241, 239),
    
      tint: colour.from_rgb(231, 233, 231),
    
      tint_strong: colour.from_rgb(223, 226, 223),
    
      accent_subtle: colour.from_rgb(215, 218, 215),
    
      accent: colour.from_rgb(204, 207, 204),
    
      accent_strong: colour.from_rgb(185, 188, 184),
    
      solid_subtle: colour.from_rgb(147, 151, 145),
    
      solid: colour.from_rgb(137, 142, 135),
    
      solid_strong: colour.from_rgb(127, 132, 125),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(96, 101, 95),
    
      text: colour.from_rgb(29, 33, 28),
    
  ))
      
      pub const sand = ColorScale(
    
      bg: colour.from_rgb(253, 253, 252),
    
      bg_subtle: colour.from_rgb(249, 249, 248),
    
      tint_subtle: colour.from_rgb(241, 240, 239),
    
      tint: colour.from_rgb(233, 232, 230),
    
      tint_strong: colour.from_rgb(226, 225, 222),
    
      accent_subtle: colour.from_rgb(218, 217, 214),
    
      accent: colour.from_rgb(207, 206, 202),
    
      accent_strong: colour.from_rgb(188, 187, 181),
    
      solid_subtle: colour.from_rgb(151, 151, 144),
    
      solid: colour.from_rgb(141, 141, 134),
    
      solid_strong: colour.from_rgb(130, 130, 124),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(99, 99, 94),
    
      text: colour.from_rgb(33, 32, 28),
    
  ))
      
      pub const tomato = ColorScale(
    
      bg: colour.from_rgb(255, 252, 252),
    
      bg_subtle: colour.from_rgb(255, 248, 247),
    
      tint_subtle: colour.from_rgb(254, 235, 231),
    
      tint: colour.from_rgb(255, 220, 211),
    
      tint_strong: colour.from_rgb(255, 205, 194),
    
      accent_subtle: colour.from_rgb(253, 189, 175),
    
      accent: colour.from_rgb(245, 168, 152),
    
      accent_strong: colour.from_rgb(236, 142, 123),
    
      solid_subtle: colour.from_rgb(236, 86, 55),
    
      solid: colour.from_rgb(229, 77, 46),
    
      solid_strong: colour.from_rgb(221, 68, 37),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(209, 52, 21),
    
      text: colour.from_rgb(92, 39, 31),
    
  ))
      
      pub const red = ColorScale(
    
      bg: colour.from_rgb(255, 252, 252),
    
      bg_subtle: colour.from_rgb(255, 247, 247),
    
      tint_subtle: colour.from_rgb(254, 235, 236),
    
      tint: colour.from_rgb(255, 219, 220),
    
      tint_strong: colour.from_rgb(255, 205, 206),
    
      accent_subtle: colour.from_rgb(253, 189, 190),
    
      accent: colour.from_rgb(244, 169, 170),
    
      accent_strong: colour.from_rgb(235, 142, 144),
    
      solid_subtle: colour.from_rgb(236, 83, 88),
    
      solid: colour.from_rgb(229, 72, 77),
    
      solid_strong: colour.from_rgb(220, 62, 66),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(206, 44, 49),
    
      text: colour.from_rgb(100, 23, 35),
    
  ))
      
      pub const ruby = ColorScale(
    
      bg: colour.from_rgb(255, 252, 253),
    
      bg_subtle: colour.from_rgb(255, 247, 248),
    
      tint_subtle: colour.from_rgb(254, 234, 237),
    
      tint: colour.from_rgb(255, 220, 225),
    
      tint_strong: colour.from_rgb(255, 206, 214),
    
      accent_subtle: colour.from_rgb(248, 191, 200),
    
      accent: colour.from_rgb(239, 172, 184),
    
      accent_strong: colour.from_rgb(229, 146, 163),
    
      solid_subtle: colour.from_rgb(236, 82, 113),
    
      solid: colour.from_rgb(229, 70, 102),
    
      solid_strong: colour.from_rgb(220, 59, 93),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(202, 36, 77),
    
      text: colour.from_rgb(100, 23, 43),
    
  ))
      
      pub const crimson = ColorScale(
    
      bg: colour.from_rgb(255, 252, 253),
    
      bg_subtle: colour.from_rgb(254, 247, 249),
    
      tint_subtle: colour.from_rgb(255, 233, 240),
    
      tint: colour.from_rgb(254, 220, 231),
    
      tint_strong: colour.from_rgb(250, 206, 221),
    
      accent_subtle: colour.from_rgb(243, 190, 209),
    
      accent: colour.from_rgb(234, 172, 195),
    
      accent_strong: colour.from_rgb(224, 147, 178),
    
      solid_subtle: colour.from_rgb(241, 71, 139),
    
      solid: colour.from_rgb(233, 61, 130),
    
      solid_strong: colour.from_rgb(223, 52, 120),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(203, 29, 99),
    
      text: colour.from_rgb(98, 22, 57),
    
  ))
      
      pub const pink = ColorScale(
    
      bg: colour.from_rgb(255, 252, 254),
    
      bg_subtle: colour.from_rgb(254, 247, 251),
    
      tint_subtle: colour.from_rgb(254, 233, 245),
    
      tint: colour.from_rgb(251, 220, 239),
    
      tint_strong: colour.from_rgb(246, 206, 231),
    
      accent_subtle: colour.from_rgb(239, 191, 221),
    
      accent: colour.from_rgb(231, 172, 208),
    
      accent_strong: colour.from_rgb(221, 147, 194),
    
      solid_subtle: colour.from_rgb(220, 72, 166),
    
      solid: colour.from_rgb(214, 64, 159),
    
      solid_strong: colour.from_rgb(207, 56, 151),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(194, 41, 138),
    
      text: colour.from_rgb(101, 18, 73),
    
  ))
      
      pub const plum = ColorScale(
    
      bg: colour.from_rgb(254, 252, 255),
    
      bg_subtle: colour.from_rgb(253, 247, 253),
    
      tint_subtle: colour.from_rgb(251, 235, 251),
    
      tint: colour.from_rgb(247, 222, 248),
    
      tint_strong: colour.from_rgb(242, 209, 243),
    
      accent_subtle: colour.from_rgb(233, 194, 236),
    
      accent: colour.from_rgb(222, 173, 227),
    
      accent_strong: colour.from_rgb(207, 145, 216),
    
      solid_subtle: colour.from_rgb(177, 85, 191),
    
      solid: colour.from_rgb(171, 74, 186),
    
      solid_strong: colour.from_rgb(161, 68, 175),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(149, 62, 163),
    
      text: colour.from_rgb(83, 25, 93),
    
  ))
      
      pub const purple = ColorScale(
    
      bg: colour.from_rgb(254, 252, 254),
    
      bg_subtle: colour.from_rgb(251, 247, 254),
    
      tint_subtle: colour.from_rgb(247, 237, 254),
    
      tint: colour.from_rgb(242, 226, 252),
    
      tint_strong: colour.from_rgb(234, 213, 249),
    
      accent_subtle: colour.from_rgb(224, 196, 244),
    
      accent: colour.from_rgb(209, 175, 236),
    
      accent_strong: colour.from_rgb(190, 147, 228),
    
      solid_subtle: colour.from_rgb(152, 86, 209),
    
      solid: colour.from_rgb(142, 78, 198),
    
      solid_strong: colour.from_rgb(131, 71, 185),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(129, 69, 181),
    
      text: colour.from_rgb(64, 32, 96),
    
  ))
      
      pub const violet = ColorScale(
    
      bg: colour.from_rgb(253, 252, 254),
    
      bg_subtle: colour.from_rgb(250, 248, 255),
    
      tint_subtle: colour.from_rgb(244, 240, 254),
    
      tint: colour.from_rgb(235, 228, 255),
    
      tint_strong: colour.from_rgb(225, 217, 255),
    
      accent_subtle: colour.from_rgb(212, 202, 254),
    
      accent: colour.from_rgb(194, 181, 245),
    
      accent_strong: colour.from_rgb(170, 153, 236),
    
      solid_subtle: colour.from_rgb(120, 96, 216),
    
      solid: colour.from_rgb(110, 86, 207),
    
      solid_strong: colour.from_rgb(101, 77, 196),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(101, 80, 185),
    
      text: colour.from_rgb(47, 38, 95),
    
  ))
      
      pub const iris = ColorScale(
    
      bg: colour.from_rgb(253, 253, 255),
    
      bg_subtle: colour.from_rgb(248, 248, 255),
    
      tint_subtle: colour.from_rgb(240, 241, 254),
    
      tint: colour.from_rgb(230, 231, 255),
    
      tint_strong: colour.from_rgb(218, 220, 255),
    
      accent_subtle: colour.from_rgb(203, 205, 255),
    
      accent: colour.from_rgb(184, 186, 248),
    
      accent_strong: colour.from_rgb(155, 158, 240),
    
      solid_subtle: colour.from_rgb(101, 101, 222),
    
      solid: colour.from_rgb(91, 91, 214),
    
      solid_strong: colour.from_rgb(81, 81, 205),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(87, 83, 198),
    
      text: colour.from_rgb(39, 41, 98),
    
  ))
      
      pub const indigo = ColorScale(
    
      bg: colour.from_rgb(253, 253, 254),
    
      bg_subtle: colour.from_rgb(247, 249, 255),
    
      tint_subtle: colour.from_rgb(237, 242, 254),
    
      tint: colour.from_rgb(225, 233, 255),
    
      tint_strong: colour.from_rgb(210, 222, 255),
    
      accent_subtle: colour.from_rgb(193, 208, 255),
    
      accent: colour.from_rgb(171, 189, 249),
    
      accent_strong: colour.from_rgb(141, 164, 239),
    
      solid_subtle: colour.from_rgb(73, 110, 229),
    
      solid: colour.from_rgb(62, 99, 221),
    
      solid_strong: colour.from_rgb(51, 88, 212),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(58, 91, 199),
    
      text: colour.from_rgb(31, 45, 92),
    
  ))
      
      pub const blue = ColorScale(
    
      bg: colour.from_rgb(251, 253, 255),
    
      bg_subtle: colour.from_rgb(244, 250, 255),
    
      tint_subtle: colour.from_rgb(230, 244, 254),
    
      tint: colour.from_rgb(213, 239, 255),
    
      tint_strong: colour.from_rgb(194, 229, 255),
    
      accent_subtle: colour.from_rgb(172, 216, 252),
    
      accent: colour.from_rgb(142, 200, 246),
    
      accent_strong: colour.from_rgb(94, 177, 239),
    
      solid_subtle: colour.from_rgb(5, 148, 260),
    
      solid: colour.from_rgb(0, 144, 255),
    
      solid_strong: colour.from_rgb(5, 136, 240),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(13, 116, 206),
    
      text: colour.from_rgb(17, 50, 100),
    
  ))
      
      pub const cyan = ColorScale(
    
      bg: colour.from_rgb(250, 253, 254),
    
      bg_subtle: colour.from_rgb(242, 250, 251),
    
      tint_subtle: colour.from_rgb(222, 247, 249),
    
      tint: colour.from_rgb(202, 241, 246),
    
      tint_strong: colour.from_rgb(181, 233, 240),
    
      accent_subtle: colour.from_rgb(157, 221, 231),
    
      accent: colour.from_rgb(125, 206, 220),
    
      accent_strong: colour.from_rgb(61, 185, 207),
    
      solid_subtle: colour.from_rgb(-8, 172, 213),
    
      solid: colour.from_rgb(0, 162, 199),
    
      solid_strong: colour.from_rgb(7, 151, 185),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(16, 125, 152),
    
      text: colour.from_rgb(13, 60, 72),
    
  ))
      
      pub const teal = ColorScale(
    
      bg: colour.from_rgb(250, 254, 253),
    
      bg_subtle: colour.from_rgb(243, 251, 249),
    
      tint_subtle: colour.from_rgb(224, 248, 243),
    
      tint: colour.from_rgb(204, 243, 234),
    
      tint_strong: colour.from_rgb(184, 234, 224),
    
      accent_subtle: colour.from_rgb(161, 222, 210),
    
      accent: colour.from_rgb(131, 205, 193),
    
      accent_strong: colour.from_rgb(83, 185, 171),
    
      solid_subtle: colour.from_rgb(23, 174, 156),
    
      solid: colour.from_rgb(18, 165, 148),
    
      solid_strong: colour.from_rgb(13, 155, 138),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(0, 133, 115),
    
      text: colour.from_rgb(13, 61, 56),
    
  ))
      
      pub const jade = ColorScale(
    
      bg: colour.from_rgb(251, 254, 253),
    
      bg_subtle: colour.from_rgb(244, 251, 247),
    
      tint_subtle: colour.from_rgb(230, 247, 237),
    
      tint: colour.from_rgb(214, 241, 227),
    
      tint_strong: colour.from_rgb(195, 233, 215),
    
      accent_subtle: colour.from_rgb(172, 222, 200),
    
      accent: colour.from_rgb(139, 206, 182),
    
      accent_strong: colour.from_rgb(86, 186, 159),
    
      solid_subtle: colour.from_rgb(44, 172, 139),
    
      solid: colour.from_rgb(41, 163, 131),
    
      solid_strong: colour.from_rgb(38, 153, 123),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(32, 131, 104),
    
      text: colour.from_rgb(29, 59, 49),
    
  ))
      
      pub const green = ColorScale(
    
      bg: colour.from_rgb(251, 254, 252),
    
      bg_subtle: colour.from_rgb(244, 251, 246),
    
      tint_subtle: colour.from_rgb(230, 246, 235),
    
      tint: colour.from_rgb(214, 241, 223),
    
      tint_strong: colour.from_rgb(196, 232, 209),
    
      accent_subtle: colour.from_rgb(173, 221, 192),
    
      accent: colour.from_rgb(142, 206, 170),
    
      accent_strong: colour.from_rgb(91, 185, 139),
    
      solid_subtle: colour.from_rgb(53, 173, 115),
    
      solid: colour.from_rgb(48, 164, 108),
    
      solid_strong: colour.from_rgb(43, 154, 102),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(33, 131, 88),
    
      text: colour.from_rgb(25, 59, 45),
    
  ))
      
      pub const grass = ColorScale(
    
      bg: colour.from_rgb(251, 254, 251),
    
      bg_subtle: colour.from_rgb(245, 251, 245),
    
      tint_subtle: colour.from_rgb(233, 246, 233),
    
      tint: colour.from_rgb(218, 241, 219),
    
      tint_strong: colour.from_rgb(201, 232, 202),
    
      accent_subtle: colour.from_rgb(178, 221, 181),
    
      accent: colour.from_rgb(148, 206, 154),
    
      accent_strong: colour.from_rgb(101, 186, 116),
    
      solid_subtle: colour.from_rgb(79, 177, 97),
    
      solid: colour.from_rgb(70, 167, 88),
    
      solid_strong: colour.from_rgb(62, 155, 79),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(42, 126, 59),
    
      text: colour.from_rgb(32, 60, 37),
    
  ))
      
      pub const brown = ColorScale(
    
      bg: colour.from_rgb(254, 253, 252),
    
      bg_subtle: colour.from_rgb(252, 249, 246),
    
      tint_subtle: colour.from_rgb(246, 238, 231),
    
      tint: colour.from_rgb(240, 228, 217),
    
      tint_strong: colour.from_rgb(235, 218, 202),
    
      accent_subtle: colour.from_rgb(228, 205, 183),
    
      accent: colour.from_rgb(220, 188, 159),
    
      accent_strong: colour.from_rgb(206, 163, 126),
    
      solid_subtle: colour.from_rgb(181, 136, 97),
    
      solid: colour.from_rgb(173, 127, 88),
    
      solid_strong: colour.from_rgb(160, 117, 83),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(129, 94, 70),
    
      text: colour.from_rgb(62, 51, 46),
    
  ))
      
      pub const bronze = ColorScale(
    
      bg: colour.from_rgb(253, 252, 252),
    
      bg_subtle: colour.from_rgb(253, 247, 245),
    
      tint_subtle: colour.from_rgb(246, 237, 234),
    
      tint: colour.from_rgb(239, 228, 223),
    
      tint_strong: colour.from_rgb(231, 217, 211),
    
      accent_subtle: colour.from_rgb(223, 205, 197),
    
      accent: colour.from_rgb(211, 188, 179),
    
      accent_strong: colour.from_rgb(194, 164, 153),
    
      solid_subtle: colour.from_rgb(172, 138, 124),
    
      solid: colour.from_rgb(161, 128, 114),
    
      solid_strong: colour.from_rgb(149, 116, 104),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(125, 94, 84),
    
      text: colour.from_rgb(67, 48, 43),
    
  ))
      
      pub const gold = ColorScale(
    
      bg: colour.from_rgb(253, 253, 252),
    
      bg_subtle: colour.from_rgb(250, 249, 242),
    
      tint_subtle: colour.from_rgb(242, 240, 231),
    
      tint: colour.from_rgb(234, 230, 219),
    
      tint_strong: colour.from_rgb(225, 220, 207),
    
      accent_subtle: colour.from_rgb(216, 208, 191),
    
      accent: colour.from_rgb(203, 192, 170),
    
      accent_strong: colour.from_rgb(185, 168, 141),
    
      solid_subtle: colour.from_rgb(159, 139, 110),
    
      solid: colour.from_rgb(151, 131, 101),
    
      solid_strong: colour.from_rgb(140, 122, 94),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(113, 98, 75),
    
      text: colour.from_rgb(59, 53, 43),
    
  ))
      
      pub const sky = ColorScale(
    
      bg: colour.from_rgb(249, 254, 255),
    
      bg_subtle: colour.from_rgb(241, 250, 253),
    
      tint_subtle: colour.from_rgb(225, 246, 253),
    
      tint: colour.from_rgb(209, 240, 250),
    
      tint_strong: colour.from_rgb(190, 231, 245),
    
      accent_subtle: colour.from_rgb(169, 218, 237),
    
      accent: colour.from_rgb(141, 202, 227),
    
      accent_strong: colour.from_rgb(96, 179, 215),
    
      solid_subtle: colour.from_rgb(133, 231, 258),
    
      solid: colour.from_rgb(124, 226, 254),
    
      solid_strong: colour.from_rgb(116, 218, 248),
    
      solid_text: colour.from_rgb(29, 62, 86),
    
      text_subtle: colour.from_rgb(0, 116, 158),
    
      text: colour.from_rgb(29, 62, 86),
    
  ))
      
      pub const mint = ColorScale(
    
      bg: colour.from_rgb(249, 254, 253),
    
      bg_subtle: colour.from_rgb(242, 251, 249),
    
      tint_subtle: colour.from_rgb(221, 249, 242),
    
      tint: colour.from_rgb(200, 244, 233),
    
      tint_strong: colour.from_rgb(179, 236, 222),
    
      accent_subtle: colour.from_rgb(156, 224, 208),
    
      accent: colour.from_rgb(126, 207, 189),
    
      accent_strong: colour.from_rgb(76, 187, 165),
    
      solid_subtle: colour.from_rgb(144, 242, 220),
    
      solid: colour.from_rgb(134, 234, 212),
    
      solid_strong: colour.from_rgb(125, 224, 203),
    
      solid_text: colour.from_rgb(22, 67, 60),
    
      text_subtle: colour.from_rgb(2, 120, 100),
    
      text: colour.from_rgb(22, 67, 60),
    
  ))
      
      pub const lime = ColorScale(
    
      bg: colour.from_rgb(252, 253, 250),
    
      bg_subtle: colour.from_rgb(248, 250, 243),
    
      tint_subtle: colour.from_rgb(238, 246, 214),
    
      tint: colour.from_rgb(226, 240, 189),
    
      tint_strong: colour.from_rgb(211, 231, 166),
    
      accent_subtle: colour.from_rgb(194, 218, 145),
    
      accent: colour.from_rgb(171, 201, 120),
    
      accent_strong: colour.from_rgb(141, 182, 84),
    
      solid_subtle: colour.from_rgb(201, 244, 123),
    
      solid: colour.from_rgb(189, 238, 99),
    
      solid_strong: colour.from_rgb(176, 230, 76),
    
      solid_text: colour.from_rgb(55, 64, 28),
    
      text_subtle: colour.from_rgb(92, 124, 47),
    
      text: colour.from_rgb(55, 64, 28),
    
  ))
      
      pub const yellow = ColorScale(
    
      bg: colour.from_rgb(253, 253, 249),
    
      bg_subtle: colour.from_rgb(254, 252, 233),
    
      tint_subtle: colour.from_rgb(255, 250, 184),
    
      tint: colour.from_rgb(255, 243, 148),
    
      tint_strong: colour.from_rgb(255, 231, 112),
    
      accent_subtle: colour.from_rgb(243, 215, 104),
    
      accent: colour.from_rgb(228, 199, 103),
    
      accent_strong: colour.from_rgb(213, 174, 57),
    
      solid_subtle: colour.from_rgb(255, 234, 82),
    
      solid: colour.from_rgb(255, 230, 41),
    
      solid_strong: colour.from_rgb(255, 220, 0),
    
      solid_text: colour.from_rgb(71, 59, 31),
    
      text_subtle: colour.from_rgb(158, 108, 0),
    
      text: colour.from_rgb(71, 59, 31),
    
  ))
      
      pub const amber = ColorScale(
    
      bg: colour.from_rgb(254, 253, 251),
    
      bg_subtle: colour.from_rgb(254, 251, 233),
    
      tint_subtle: colour.from_rgb(255, 247, 194),
    
      tint: colour.from_rgb(255, 238, 156),
    
      tint_strong: colour.from_rgb(251, 229, 119),
    
      accent_subtle: colour.from_rgb(243, 214, 115),
    
      accent: colour.from_rgb(233, 193, 98),
    
      accent_strong: colour.from_rgb(226, 163, 54),
    
      solid_subtle: colour.from_rgb(255, 208, 97),
    
      solid: colour.from_rgb(255, 197, 61),
    
      solid_strong: colour.from_rgb(255, 186, 24),
    
      solid_text: colour.from_rgb(79, 52, 34),
    
      text_subtle: colour.from_rgb(171, 100, 0),
    
      text: colour.from_rgb(79, 52, 34),
    
  ))
      
      pub const orange = ColorScale(
    
      bg: colour.from_rgb(254, 252, 251),
    
      bg_subtle: colour.from_rgb(255, 247, 237),
    
      tint_subtle: colour.from_rgb(255, 239, 214),
    
      tint: colour.from_rgb(255, 223, 181),
    
      tint_strong: colour.from_rgb(255, 209, 154),
    
      accent_subtle: colour.from_rgb(255, 193, 130),
    
      accent: colour.from_rgb(245, 174, 115),
    
      accent_strong: colour.from_rgb(236, 148, 85),
    
      solid_subtle: colour.from_rgb(240, 126, 56),
    
      solid: colour.from_rgb(247, 107, 21),
    
      solid_strong: colour.from_rgb(239, 95, 0),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(204, 78, 0),
    
      text: colour.from_rgb(88, 45, 29),
    
  ))
      
      pub const gray_dark = ColorScale(
    
      bg: colour.from_rgb(25, 25, 25),
    
      bg_subtle: colour.from_rgb(17, 17, 17),
    
      tint_subtle: colour.from_rgb(34, 34, 34),
    
      tint: colour.from_rgb(42, 42, 42),
    
      tint_strong: colour.from_rgb(49, 49, 49),
    
      accent_subtle: colour.from_rgb(58, 58, 58),
    
      accent: colour.from_rgb(72, 72, 72),
    
      accent_strong: colour.from_rgb(96, 96, 96),
    
      solid_subtle: colour.from_rgb(97, 97, 97),
    
      solid: colour.from_rgb(110, 110, 110),
    
      solid_strong: colour.from_rgb(123, 123, 123),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(180, 180, 180),
    
      text: colour.from_rgb(238, 238, 238),
    
  ))
      
      pub const mauve_dark = ColorScale(
    
      bg: colour.from_rgb(26, 25, 27),
    
      bg_subtle: colour.from_rgb(18, 17, 19),
    
      tint_subtle: colour.from_rgb(35, 34, 37),
    
      tint: colour.from_rgb(43, 41, 45),
    
      tint_strong: colour.from_rgb(50, 48, 53),
    
      accent_subtle: colour.from_rgb(60, 57, 63),
    
      accent: colour.from_rgb(73, 71, 78),
    
      accent_strong: colour.from_rgb(98, 95, 105),
    
      solid_subtle: colour.from_rgb(98, 96, 106),
    
      solid: colour.from_rgb(111, 109, 120),
    
      solid_strong: colour.from_rgb(124, 122, 133),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(181, 178, 188),
    
      text: colour.from_rgb(238, 238, 240),
    
  ))
      
      pub const slate_dark = ColorScale(
    
      bg: colour.from_rgb(24, 25, 27),
    
      bg_subtle: colour.from_rgb(17, 17, 19),
    
      tint_subtle: colour.from_rgb(33, 34, 37),
    
      tint: colour.from_rgb(39, 42, 45),
    
      tint_strong: colour.from_rgb(46, 49, 53),
    
      accent_subtle: colour.from_rgb(54, 58, 63),
    
      accent: colour.from_rgb(67, 72, 78),
    
      accent_strong: colour.from_rgb(90, 97, 105),
    
      solid_subtle: colour.from_rgb(91, 96, 105),
    
      solid: colour.from_rgb(105, 110, 119),
    
      solid_strong: colour.from_rgb(119, 123, 132),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(176, 180, 186),
    
      text: colour.from_rgb(237, 238, 240),
    
  ))
      
      pub const sage_dark = ColorScale(
    
      bg: colour.from_rgb(23, 25, 24),
    
      bg_subtle: colour.from_rgb(16, 18, 17),
    
      tint_subtle: colour.from_rgb(32, 34, 33),
    
      tint: colour.from_rgb(39, 42, 41),
    
      tint_strong: colour.from_rgb(46, 49, 48),
    
      accent_subtle: colour.from_rgb(55, 59, 57),
    
      accent: colour.from_rgb(68, 73, 71),
    
      accent_strong: colour.from_rgb(91, 98, 95),
    
      solid_subtle: colour.from_rgb(85, 98, 93),
    
      solid: colour.from_rgb(99, 112, 107),
    
      solid_strong: colour.from_rgb(113, 125, 121),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(173, 181, 178),
    
      text: colour.from_rgb(236, 238, 237),
    
  ))
      
      pub const olive_dark = ColorScale(
    
      bg: colour.from_rgb(24, 25, 23),
    
      bg_subtle: colour.from_rgb(17, 18, 16),
    
      tint_subtle: colour.from_rgb(33, 34, 32),
    
      tint: colour.from_rgb(40, 42, 39),
    
      tint_strong: colour.from_rgb(47, 49, 46),
    
      accent_subtle: colour.from_rgb(56, 58, 54),
    
      accent: colour.from_rgb(69, 72, 67),
    
      accent_strong: colour.from_rgb(92, 98, 91),
    
      solid_subtle: colour.from_rgb(90, 98, 88),
    
      solid: colour.from_rgb(104, 112, 102),
    
      solid_strong: colour.from_rgb(118, 125, 116),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(175, 181, 173),
    
      text: colour.from_rgb(236, 238, 236),
    
  ))
      
      pub const sand_dark = ColorScale(
    
      bg: colour.from_rgb(25, 25, 24),
    
      bg_subtle: colour.from_rgb(17, 17, 16),
    
      tint_subtle: colour.from_rgb(34, 34, 33),
    
      tint: colour.from_rgb(42, 42, 40),
    
      tint_strong: colour.from_rgb(49, 49, 46),
    
      accent_subtle: colour.from_rgb(59, 58, 55),
    
      accent: colour.from_rgb(73, 72, 68),
    
      accent_strong: colour.from_rgb(98, 96, 91),
    
      solid_subtle: colour.from_rgb(97, 95, 88),
    
      solid: colour.from_rgb(111, 109, 102),
    
      solid_strong: colour.from_rgb(124, 123, 116),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(181, 179, 173),
    
      text: colour.from_rgb(238, 238, 236),
    
  ))
      
      pub const tomato_dark = ColorScale(
    
      bg: colour.from_rgb(31, 21, 19),
    
      bg_subtle: colour.from_rgb(24, 17, 17),
    
      tint_subtle: colour.from_rgb(57, 23, 20),
    
      tint: colour.from_rgb(78, 21, 17),
    
      tint_strong: colour.from_rgb(94, 28, 22),
    
      accent_subtle: colour.from_rgb(110, 41, 32),
    
      accent: colour.from_rgb(133, 58, 45),
    
      accent_strong: colour.from_rgb(172, 77, 57),
    
      solid_subtle: colour.from_rgb(215, 63, 32),
    
      solid: colour.from_rgb(229, 77, 46),
    
      solid_strong: colour.from_rgb(236, 97, 66),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(255, 151, 125),
    
      text: colour.from_rgb(251, 211, 203),
    
  ))
      
      pub const red_dark = ColorScale(
    
      bg: colour.from_rgb(32, 19, 20),
    
      bg_subtle: colour.from_rgb(25, 17, 17),
    
      tint_subtle: colour.from_rgb(59, 18, 25),
    
      tint: colour.from_rgb(80, 15, 28),
    
      tint_strong: colour.from_rgb(97, 22, 35),
    
      accent_subtle: colour.from_rgb(114, 35, 45),
    
      accent: colour.from_rgb(140, 51, 58),
    
      accent_strong: colour.from_rgb(181, 69, 72),
    
      solid_subtle: colour.from_rgb(220, 52, 57),
    
      solid: colour.from_rgb(229, 72, 77),
    
      solid_strong: colour.from_rgb(236, 93, 94),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(255, 149, 146),
    
      text: colour.from_rgb(255, 209, 217),
    
  ))
      
      pub const ruby_dark = ColorScale(
    
      bg: colour.from_rgb(30, 21, 23),
    
      bg_subtle: colour.from_rgb(25, 17, 19),
    
      tint_subtle: colour.from_rgb(58, 20, 30),
    
      tint: colour.from_rgb(78, 19, 37),
    
      tint_strong: colour.from_rgb(94, 26, 46),
    
      accent_subtle: colour.from_rgb(111, 37, 57),
    
      accent: colour.from_rgb(136, 52, 71),
    
      accent_strong: colour.from_rgb(179, 68, 90),
    
      solid_subtle: colour.from_rgb(220, 51, 85),
    
      solid: colour.from_rgb(229, 70, 102),
    
      solid_strong: colour.from_rgb(236, 90, 114),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(255, 148, 157),
    
      text: colour.from_rgb(254, 210, 225),
    
  ))
      
      pub const crimson_dark = ColorScale(
    
      bg: colour.from_rgb(32, 19, 24),
    
      bg_subtle: colour.from_rgb(25, 17, 20),
    
      tint_subtle: colour.from_rgb(56, 21, 37),
    
      tint: colour.from_rgb(77, 18, 47),
    
      tint_strong: colour.from_rgb(92, 24, 57),
    
      accent_subtle: colour.from_rgb(109, 37, 69),
    
      accent: colour.from_rgb(135, 51, 86),
    
      accent_strong: colour.from_rgb(176, 67, 110),
    
      solid_subtle: colour.from_rgb(227, 41, 116),
    
      solid: colour.from_rgb(233, 61, 130),
    
      solid_strong: colour.from_rgb(238, 81, 138),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(255, 146, 173),
    
      text: colour.from_rgb(253, 211, 232),
    
  ))
      
      pub const pink_dark = ColorScale(
    
      bg: colour.from_rgb(33, 18, 29),
    
      bg_subtle: colour.from_rgb(25, 17, 23),
    
      tint_subtle: colour.from_rgb(55, 23, 47),
    
      tint: colour.from_rgb(75, 20, 61),
    
      tint_strong: colour.from_rgb(89, 28, 71),
    
      accent_subtle: colour.from_rgb(105, 41, 85),
    
      accent: colour.from_rgb(131, 56, 105),
    
      accent_strong: colour.from_rgb(168, 72, 133),
    
      solid_subtle: colour.from_rgb(203, 49, 147),
    
      solid: colour.from_rgb(214, 64, 159),
    
      solid_strong: colour.from_rgb(222, 81, 168),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(255, 141, 204),
    
      text: colour.from_rgb(253, 209, 234),
    
  ))
      
      pub const plum_dark = ColorScale(
    
      bg: colour.from_rgb(32, 19, 32),
    
      bg_subtle: colour.from_rgb(24, 17, 24),
    
      tint_subtle: colour.from_rgb(53, 26, 53),
    
      tint: colour.from_rgb(69, 29, 71),
    
      tint_strong: colour.from_rgb(81, 36, 84),
    
      accent_subtle: colour.from_rgb(94, 48, 97),
    
      accent: colour.from_rgb(115, 64, 121),
    
      accent_strong: colour.from_rgb(146, 84, 156),
    
      solid_subtle: colour.from_rgb(154, 68, 167),
    
      solid: colour.from_rgb(171, 74, 186),
    
      solid_strong: colour.from_rgb(182, 88, 196),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(231, 150, 243),
    
      text: colour.from_rgb(244, 212, 244),
    
  ))
      
      pub const purple_dark = ColorScale(
    
      bg: colour.from_rgb(30, 21, 35),
    
      bg_subtle: colour.from_rgb(24, 17, 27),
    
      tint_subtle: colour.from_rgb(48, 28, 59),
    
      tint: colour.from_rgb(61, 34, 78),
    
      tint_strong: colour.from_rgb(72, 41, 92),
    
      accent_subtle: colour.from_rgb(84, 52, 107),
    
      accent: colour.from_rgb(102, 66, 130),
    
      accent_strong: colour.from_rgb(132, 87, 170),
    
      solid_subtle: colour.from_rgb(129, 66, 185),
    
      solid: colour.from_rgb(142, 78, 198),
    
      solid_strong: colour.from_rgb(154, 92, 208),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(209, 157, 255),
    
      text: colour.from_rgb(236, 217, 250),
    
  ))
      
      pub const violet_dark = ColorScale(
    
      bg: colour.from_rgb(27, 21, 37),
    
      bg_subtle: colour.from_rgb(20, 18, 31),
    
      tint_subtle: colour.from_rgb(41, 31, 67),
    
      tint: colour.from_rgb(51, 37, 91),
    
      tint_strong: colour.from_rgb(60, 46, 105),
    
      accent_subtle: colour.from_rgb(71, 56, 118),
    
      accent: colour.from_rgb(86, 70, 139),
    
      accent_strong: colour.from_rgb(105, 88, 173),
    
      solid_subtle: colour.from_rgb(95, 71, 195),
    
      solid: colour.from_rgb(110, 86, 207),
    
      solid_strong: colour.from_rgb(125, 102, 217),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(186, 167, 255),
    
      text: colour.from_rgb(226, 221, 254),
    
  ))
      
      pub const iris_dark = ColorScale(
    
      bg: colour.from_rgb(23, 22, 37),
    
      bg_subtle: colour.from_rgb(19, 19, 30),
    
      tint_subtle: colour.from_rgb(32, 34, 72),
    
      tint: colour.from_rgb(38, 42, 101),
    
      tint_strong: colour.from_rgb(48, 51, 116),
    
      accent_subtle: colour.from_rgb(61, 62, 130),
    
      accent: colour.from_rgb(74, 74, 149),
    
      accent_strong: colour.from_rgb(89, 88, 177),
    
      solid_subtle: colour.from_rgb(76, 76, 205),
    
      solid: colour.from_rgb(91, 91, 214),
    
      solid_strong: colour.from_rgb(110, 106, 222),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(177, 169, 255),
    
      text: colour.from_rgb(224, 223, 254),
    
  ))
      
      pub const indigo_dark = ColorScale(
    
      bg: colour.from_rgb(20, 23, 38),
    
      bg_subtle: colour.from_rgb(17, 19, 31),
    
      tint_subtle: colour.from_rgb(24, 36, 73),
    
      tint: colour.from_rgb(29, 46, 98),
    
      tint_strong: colour.from_rgb(37, 57, 116),
    
      accent_subtle: colour.from_rgb(48, 67, 132),
    
      accent: colour.from_rgb(58, 79, 151),
    
      accent_strong: colour.from_rgb(67, 93, 177),
    
      solid_subtle: colour.from_rgb(41, 81, 212),
    
      solid: colour.from_rgb(62, 99, 221),
    
      solid_strong: colour.from_rgb(84, 114, 228),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(158, 177, 255),
    
      text: colour.from_rgb(214, 225, 255),
    
  ))
      
      pub const blue_dark = ColorScale(
    
      bg: colour.from_rgb(17, 25, 39),
    
      bg_subtle: colour.from_rgb(13, 21, 32),
    
      tint_subtle: colour.from_rgb(13, 40, 71),
    
      tint: colour.from_rgb(0, 51, 98),
    
      tint_strong: colour.from_rgb(0, 64, 116),
    
      accent_subtle: colour.from_rgb(16, 77, 135),
    
      accent: colour.from_rgb(32, 93, 158),
    
      accent_strong: colour.from_rgb(40, 112, 189),
    
      solid_subtle: colour.from_rgb(0, 110, 195),
    
      solid: colour.from_rgb(0, 144, 255),
    
      solid_strong: colour.from_rgb(59, 158, 255),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(112, 184, 255),
    
      text: colour.from_rgb(194, 230, 255),
    
  ))
      
      pub const cyan_dark = ColorScale(
    
      bg: colour.from_rgb(16, 27, 32),
    
      bg_subtle: colour.from_rgb(11, 22, 26),
    
      tint_subtle: colour.from_rgb(8, 44, 54),
    
      tint: colour.from_rgb(0, 56, 72),
    
      tint_strong: colour.from_rgb(0, 69, 88),
    
      accent_subtle: colour.from_rgb(4, 84, 104),
    
      accent: colour.from_rgb(18, 103, 126),
    
      accent_strong: colour.from_rgb(17, 128, 156),
    
      solid_subtle: colour.from_rgb(-23, 140, 177),
    
      solid: colour.from_rgb(0, 162, 199),
    
      solid_strong: colour.from_rgb(35, 175, 208),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(76, 204, 230),
    
      text: colour.from_rgb(182, 236, 247),
    
  ))
      
      pub const teal_dark = ColorScale(
    
      bg: colour.from_rgb(17, 28, 27),
    
      bg_subtle: colour.from_rgb(13, 21, 20),
    
      tint_subtle: colour.from_rgb(13, 45, 42),
    
      tint: colour.from_rgb(2, 59, 55),
    
      tint_strong: colour.from_rgb(8, 72, 67),
    
      accent_subtle: colour.from_rgb(20, 87, 80),
    
      accent: colour.from_rgb(28, 105, 97),
    
      accent_strong: colour.from_rgb(32, 126, 115),
    
      solid_subtle: colour.from_rgb(21, 151, 136),
    
      solid: colour.from_rgb(18, 165, 148),
    
      solid_strong: colour.from_rgb(14, 179, 158),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(11, 216, 182),
    
      text: colour.from_rgb(173, 240, 221),
    
  ))
      
      pub const jade_dark = ColorScale(
    
      bg: colour.from_rgb(18, 28, 24),
    
      bg_subtle: colour.from_rgb(13, 21, 18),
    
      tint_subtle: colour.from_rgb(15, 46, 34),
    
      tint: colour.from_rgb(11, 59, 44),
    
      tint_strong: colour.from_rgb(17, 72, 55),
    
      accent_subtle: colour.from_rgb(27, 87, 69),
    
      accent: colour.from_rgb(36, 104, 84),
    
      accent_strong: colour.from_rgb(42, 126, 104),
    
      solid_subtle: colour.from_rgb(42, 150, 122),
    
      solid: colour.from_rgb(41, 163, 131),
    
      solid_strong: colour.from_rgb(39, 176, 139),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(31, 216, 164),
    
      text: colour.from_rgb(173, 240, 212),
    
  ))
      
      pub const green_dark = ColorScale(
    
      bg: colour.from_rgb(18, 27, 23),
    
      bg_subtle: colour.from_rgb(14, 21, 18),
    
      tint_subtle: colour.from_rgb(19, 45, 33),
    
      tint: colour.from_rgb(17, 59, 41),
    
      tint_strong: colour.from_rgb(23, 73, 51),
    
      accent_subtle: colour.from_rgb(32, 87, 62),
    
      accent: colour.from_rgb(40, 104, 74),
    
      accent_strong: colour.from_rgb(47, 124, 87),
    
      solid_subtle: colour.from_rgb(44, 152, 100),
    
      solid: colour.from_rgb(48, 164, 108),
    
      solid_strong: colour.from_rgb(51, 176, 116),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(61, 214, 140),
    
      text: colour.from_rgb(177, 241, 203),
    
  ))
      
      pub const grass_dark = ColorScale(
    
      bg: colour.from_rgb(20, 26, 21),
    
      bg_subtle: colour.from_rgb(14, 21, 17),
    
      tint_subtle: colour.from_rgb(27, 42, 30),
    
      tint: colour.from_rgb(29, 58, 36),
    
      tint_strong: colour.from_rgb(37, 72, 45),
    
      accent_subtle: colour.from_rgb(45, 87, 54),
    
      accent: colour.from_rgb(54, 103, 64),
    
      accent_strong: colour.from_rgb(62, 121, 73),
    
      solid_subtle: colour.from_rgb(60, 151, 77),
    
      solid: colour.from_rgb(70, 167, 88),
    
      solid_strong: colour.from_rgb(83, 179, 101),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(113, 208, 131),
    
      text: colour.from_rgb(194, 240, 194),
    
  ))
      
      pub const brown_dark = ColorScale(
    
      bg: colour.from_rgb(28, 24, 22),
    
      bg_subtle: colour.from_rgb(18, 17, 15),
    
      tint_subtle: colour.from_rgb(40, 33, 29),
    
      tint: colour.from_rgb(50, 41, 34),
    
      tint_strong: colour.from_rgb(62, 49, 40),
    
      accent_subtle: colour.from_rgb(77, 60, 47),
    
      accent: colour.from_rgb(97, 74, 57),
    
      accent_strong: colour.from_rgb(124, 95, 70),
    
      solid_subtle: colour.from_rgb(155, 114, 79),
    
      solid: colour.from_rgb(173, 127, 88),
    
      solid_strong: colour.from_rgb(184, 140, 103),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(219, 181, 148),
    
      text: colour.from_rgb(242, 225, 202),
    
  ))
      
      pub const bronze_dark = ColorScale(
    
      bg: colour.from_rgb(28, 25, 23),
    
      bg_subtle: colour.from_rgb(20, 17, 16),
    
      tint_subtle: colour.from_rgb(38, 34, 32),
    
      tint: colour.from_rgb(48, 42, 39),
    
      tint_strong: colour.from_rgb(59, 51, 48),
    
      accent_subtle: colour.from_rgb(73, 62, 58),
    
      accent: colour.from_rgb(90, 76, 71),
    
      accent_strong: colour.from_rgb(111, 95, 88),
    
      solid_subtle: colour.from_rgb(146, 116, 103),
    
      solid: colour.from_rgb(161, 128, 114),
    
      solid_strong: colour.from_rgb(174, 140, 126),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(212, 179, 165),
    
      text: colour.from_rgb(237, 224, 217),
    
  ))
      
      pub const gold_dark = ColorScale(
    
      bg: colour.from_rgb(27, 26, 23),
    
      bg_subtle: colour.from_rgb(18, 18, 17),
    
      tint_subtle: colour.from_rgb(36, 35, 31),
    
      tint: colour.from_rgb(45, 43, 38),
    
      tint_strong: colour.from_rgb(56, 53, 46),
    
      accent_subtle: colour.from_rgb(68, 64, 57),
    
      accent: colour.from_rgb(84, 79, 70),
    
      accent_strong: colour.from_rgb(105, 98, 86),
    
      solid_subtle: colour.from_rgb(134, 117, 91),
    
      solid: colour.from_rgb(151, 131, 101),
    
      solid_strong: colour.from_rgb(163, 144, 115),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(203, 185, 159),
    
      text: colour.from_rgb(232, 226, 217),
    
  ))
      
      pub const sky_dark = ColorScale(
    
      bg: colour.from_rgb(17, 26, 39),
    
      bg_subtle: colour.from_rgb(13, 20, 31),
    
      tint_subtle: colour.from_rgb(17, 40, 64),
    
      tint: colour.from_rgb(17, 53, 85),
    
      tint_strong: colour.from_rgb(21, 68, 103),
    
      accent_subtle: colour.from_rgb(27, 83, 123),
    
      accent: colour.from_rgb(31, 102, 146),
    
      accent_strong: colour.from_rgb(25, 124, 174),
    
      solid_subtle: colour.from_rgb(80, 215, 252),
    
      solid: colour.from_rgb(124, 226, 254),
    
      solid_strong: colour.from_rgb(168, 238, 255),
    
      solid_text: colour.from_rgb(17, 26, 39),
    
      text_subtle: colour.from_rgb(117, 199, 240),
    
      text: colour.from_rgb(194, 243, 255),
    
  ))
      
      pub const mint_dark = ColorScale(
    
      bg: colour.from_rgb(15, 27, 27),
    
      bg_subtle: colour.from_rgb(14, 21, 21),
    
      tint_subtle: colour.from_rgb(9, 44, 43),
    
      tint: colour.from_rgb(0, 58, 56),
    
      tint_strong: colour.from_rgb(0, 71, 68),
    
      accent_subtle: colour.from_rgb(16, 86, 80),
    
      accent: colour.from_rgb(30, 104, 95),
    
      accent_strong: colour.from_rgb(39, 127, 112),
    
      solid_subtle: colour.from_rgb(104, 218, 193),
    
      solid: colour.from_rgb(134, 234, 212),
    
      solid_strong: colour.from_rgb(168, 245, 229),
    
      solid_text: colour.from_rgb(15, 27, 27),
    
      text_subtle: colour.from_rgb(88, 213, 186),
    
      text: colour.from_rgb(196, 245, 225),
    
  ))
      
      pub const lime_dark = ColorScale(
    
      bg: colour.from_rgb(21, 26, 16),
    
      bg_subtle: colour.from_rgb(17, 19, 12),
    
      tint_subtle: colour.from_rgb(31, 41, 23),
    
      tint: colour.from_rgb(41, 55, 29),
    
      tint_strong: colour.from_rgb(51, 68, 35),
    
      accent_subtle: colour.from_rgb(61, 82, 42),
    
      accent: colour.from_rgb(73, 98, 49),
    
      accent_strong: colour.from_rgb(87, 117, 56),
    
      solid_subtle: colour.from_rgb(171, 215, 91),
    
      solid: colour.from_rgb(189, 238, 99),
    
      solid_strong: colour.from_rgb(212, 255, 112),
    
      solid_text: colour.from_rgb(21, 26, 16),
    
      text_subtle: colour.from_rgb(189, 229, 108),
    
      text: colour.from_rgb(227, 247, 186),
    
  ))
      
      pub const yellow_dark = ColorScale(
    
      bg: colour.from_rgb(27, 24, 15),
    
      bg_subtle: colour.from_rgb(20, 18, 11),
    
      tint_subtle: colour.from_rgb(45, 35, 5),
    
      tint: colour.from_rgb(54, 43, 0),
    
      tint_strong: colour.from_rgb(67, 53, 0),
    
      accent_subtle: colour.from_rgb(82, 66, 2),
    
      accent: colour.from_rgb(102, 84, 23),
    
      accent_strong: colour.from_rgb(131, 106, 33),
    
      solid_subtle: colour.from_rgb(250, 220, 0),
    
      solid: colour.from_rgb(255, 230, 41),
    
      solid_strong: colour.from_rgb(255, 255, 87),
    
      solid_text: colour.from_rgb(27, 24, 15),
    
      text_subtle: colour.from_rgb(245, 225, 71),
    
      text: colour.from_rgb(246, 238, 180),
    
  ))
      
      pub const amber_dark = ColorScale(
    
      bg: colour.from_rgb(29, 24, 15),
    
      bg_subtle: colour.from_rgb(22, 18, 12),
    
      tint_subtle: colour.from_rgb(48, 32, 8),
    
      tint: colour.from_rgb(63, 39, 0),
    
      tint_strong: colour.from_rgb(77, 48, 0),
    
      accent_subtle: colour.from_rgb(92, 61, 5),
    
      accent: colour.from_rgb(113, 79, 25),
    
      accent_strong: colour.from_rgb(143, 100, 36),
    
      solid_subtle: colour.from_rgb(255, 212, 111),
    
      solid: colour.from_rgb(255, 197, 61),
    
      solid_strong: colour.from_rgb(255, 214, 10),
    
      solid_text: colour.from_rgb(29, 24, 15),
    
      text_subtle: colour.from_rgb(255, 202, 22),
    
      text: colour.from_rgb(255, 231, 179),
    
  ))
      
      pub const orange_dark = ColorScale(
    
      bg: colour.from_rgb(30, 22, 15),
    
      bg_subtle: colour.from_rgb(23, 18, 14),
    
      tint_subtle: colour.from_rgb(51, 30, 11),
    
      tint: colour.from_rgb(70, 33, 0),
    
      tint_strong: colour.from_rgb(86, 40, 0),
    
      accent_subtle: colour.from_rgb(102, 53, 12),
    
      accent: colour.from_rgb(126, 69, 29),
    
      accent_strong: colour.from_rgb(163, 88, 41),
    
      solid_subtle: colour.from_rgb(233, 99, 16),
    
      solid: colour.from_rgb(247, 107, 21),
    
      solid_strong: colour.from_rgb(255, 128, 31),
    
      solid_text: colour.from_rgb(255, 255, 255),
    
      text_subtle: colour.from_rgb(255, 160, 87),
    
      text: colour.from_rgb(255, 224, 194),
    
  ))
      