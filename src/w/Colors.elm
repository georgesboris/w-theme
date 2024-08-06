
module W.Theme.Colors exposing (gray,mauve,slate,sage,olive,sand,tomato,red,ruby,crimson,pink,plum,purple,violet,iris,indigo,blue,cyan,teal,jade,green,grass,brown,bronze,gold,sky,mint,lime,yellow,amber,orange, grayDark,mauveDark,slateDark,sageDark,oliveDark,sandDark,tomatoDark,redDark,rubyDark,crimsonDark,pinkDark,plumDark,purpleDark,violetDark,irisDark,indigoDark,blueDark,cyanDark,tealDark,jadeDark,greenDark,grassDark,brownDark,bronzeDark,goldDark,skyDark,mintDark,limeDark,yellowDark,amberDark,orangeDark)

import Color exposing (Color)


type alias ColorScale =
    { bg : Color
    , bgSubtle : Color
    , tint : Color
    , tintSubtle : Color
    , tintStrong : Color
    , accent : Color
    , accentSubtle : Color
    , accentStrong : Color
    , solid : Color
    , solidSubtle : Color
    , solidStrong : Color
    , solidText : Color
    , text : Color
    , textSubtle : Color
    , shadow : Color
    }



gray : ColorScale
gray = 
  {
      bg = Color.rgb255 252 252 252,
      bgSubtle = Color.rgb255 249 249 249,
      tintSubtle = Color.rgb255 240 240 240,
      tint = Color.rgb255 232 232 232,
      tintStrong = Color.rgb255 224 224 224,
      accentSubtle = Color.rgb255 217 217 217,
      accent = Color.rgb255 206 206 206,
      accentStrong = Color.rgb255 187 187 187,
      solidSubtle = Color.rgb255 151 151 151,
      solid = Color.rgb255 141 141 141,
      solidStrong = Color.rgb255 131 131 131,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 100 100 100,
      text = Color.rgb255 32 32 32,
  }


mauve : ColorScale
mauve = 
  {
      bg = Color.rgb255 253 252 253,
      bgSubtle = Color.rgb255 250 249 251,
      tintSubtle = Color.rgb255 242 239 243,
      tint = Color.rgb255 234 231 236,
      tintStrong = Color.rgb255 227 223 230,
      accentSubtle = Color.rgb255 219 216 224,
      accent = Color.rgb255 208 205 215,
      accentStrong = Color.rgb255 188 186 199,
      solidSubtle = Color.rgb255 152 150 163,
      solid = Color.rgb255 142 140 153,
      solidStrong = Color.rgb255 132 130 142,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 101 99 109,
      text = Color.rgb255 33 31 38,
  }


slate : ColorScale
slate = 
  {
      bg = Color.rgb255 252 252 253,
      bgSubtle = Color.rgb255 249 249 251,
      tintSubtle = Color.rgb255 240 240 243,
      tint = Color.rgb255 232 232 236,
      tintStrong = Color.rgb255 224 225 230,
      accentSubtle = Color.rgb255 217 217 224,
      accent = Color.rgb255 205 206 214,
      accentStrong = Color.rgb255 185 187 198,
      solidSubtle = Color.rgb255 150 152 162,
      solid = Color.rgb255 139 141 152,
      solidStrong = Color.rgb255 128 131 141,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 96 100 108,
      text = Color.rgb255 28 32 36,
  }


sage : ColorScale
sage = 
  {
      bg = Color.rgb255 251 253 252,
      bgSubtle = Color.rgb255 247 249 248,
      tintSubtle = Color.rgb255 238 241 240,
      tint = Color.rgb255 230 233 232,
      tintStrong = Color.rgb255 223 226 224,
      accentSubtle = Color.rgb255 215 218 217,
      accent = Color.rgb255 203 207 205,
      accentStrong = Color.rgb255 184 188 186,
      solidSubtle = Color.rgb255 144 151 148,
      solid = Color.rgb255 134 142 139,
      solidStrong = Color.rgb255 124 132 129,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 95 101 99,
      text = Color.rgb255 26 33 30,
  }


olive : ColorScale
olive = 
  {
      bg = Color.rgb255 252 253 252,
      bgSubtle = Color.rgb255 248 250 248,
      tintSubtle = Color.rgb255 239 241 239,
      tint = Color.rgb255 231 233 231,
      tintStrong = Color.rgb255 223 226 223,
      accentSubtle = Color.rgb255 215 218 215,
      accent = Color.rgb255 204 207 204,
      accentStrong = Color.rgb255 185 188 184,
      solidSubtle = Color.rgb255 147 151 145,
      solid = Color.rgb255 137 142 135,
      solidStrong = Color.rgb255 127 132 125,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 96 101 95,
      text = Color.rgb255 29 33 28,
  }


sand : ColorScale
sand = 
  {
      bg = Color.rgb255 253 253 252,
      bgSubtle = Color.rgb255 249 249 248,
      tintSubtle = Color.rgb255 241 240 239,
      tint = Color.rgb255 233 232 230,
      tintStrong = Color.rgb255 226 225 222,
      accentSubtle = Color.rgb255 218 217 214,
      accent = Color.rgb255 207 206 202,
      accentStrong = Color.rgb255 188 187 181,
      solidSubtle = Color.rgb255 151 151 144,
      solid = Color.rgb255 141 141 134,
      solidStrong = Color.rgb255 130 130 124,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 99 99 94,
      text = Color.rgb255 33 32 28,
  }


tomato : ColorScale
tomato = 
  {
      bg = Color.rgb255 255 252 252,
      bgSubtle = Color.rgb255 255 248 247,
      tintSubtle = Color.rgb255 254 235 231,
      tint = Color.rgb255 255 220 211,
      tintStrong = Color.rgb255 255 205 194,
      accentSubtle = Color.rgb255 253 189 175,
      accent = Color.rgb255 245 168 152,
      accentStrong = Color.rgb255 236 142 123,
      solidSubtle = Color.rgb255 236 86 55,
      solid = Color.rgb255 229 77 46,
      solidStrong = Color.rgb255 221 68 37,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 209 52 21,
      text = Color.rgb255 92 39 31,
  }


red : ColorScale
red = 
  {
      bg = Color.rgb255 255 252 252,
      bgSubtle = Color.rgb255 255 247 247,
      tintSubtle = Color.rgb255 254 235 236,
      tint = Color.rgb255 255 219 220,
      tintStrong = Color.rgb255 255 205 206,
      accentSubtle = Color.rgb255 253 189 190,
      accent = Color.rgb255 244 169 170,
      accentStrong = Color.rgb255 235 142 144,
      solidSubtle = Color.rgb255 236 83 88,
      solid = Color.rgb255 229 72 77,
      solidStrong = Color.rgb255 220 62 66,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 206 44 49,
      text = Color.rgb255 100 23 35,
  }


ruby : ColorScale
ruby = 
  {
      bg = Color.rgb255 255 252 253,
      bgSubtle = Color.rgb255 255 247 248,
      tintSubtle = Color.rgb255 254 234 237,
      tint = Color.rgb255 255 220 225,
      tintStrong = Color.rgb255 255 206 214,
      accentSubtle = Color.rgb255 248 191 200,
      accent = Color.rgb255 239 172 184,
      accentStrong = Color.rgb255 229 146 163,
      solidSubtle = Color.rgb255 236 82 113,
      solid = Color.rgb255 229 70 102,
      solidStrong = Color.rgb255 220 59 93,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 202 36 77,
      text = Color.rgb255 100 23 43,
  }


crimson : ColorScale
crimson = 
  {
      bg = Color.rgb255 255 252 253,
      bgSubtle = Color.rgb255 254 247 249,
      tintSubtle = Color.rgb255 255 233 240,
      tint = Color.rgb255 254 220 231,
      tintStrong = Color.rgb255 250 206 221,
      accentSubtle = Color.rgb255 243 190 209,
      accent = Color.rgb255 234 172 195,
      accentStrong = Color.rgb255 224 147 178,
      solidSubtle = Color.rgb255 241 71 139,
      solid = Color.rgb255 233 61 130,
      solidStrong = Color.rgb255 223 52 120,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 203 29 99,
      text = Color.rgb255 98 22 57,
  }


pink : ColorScale
pink = 
  {
      bg = Color.rgb255 255 252 254,
      bgSubtle = Color.rgb255 254 247 251,
      tintSubtle = Color.rgb255 254 233 245,
      tint = Color.rgb255 251 220 239,
      tintStrong = Color.rgb255 246 206 231,
      accentSubtle = Color.rgb255 239 191 221,
      accent = Color.rgb255 231 172 208,
      accentStrong = Color.rgb255 221 147 194,
      solidSubtle = Color.rgb255 220 72 166,
      solid = Color.rgb255 214 64 159,
      solidStrong = Color.rgb255 207 56 151,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 194 41 138,
      text = Color.rgb255 101 18 73,
  }


plum : ColorScale
plum = 
  {
      bg = Color.rgb255 254 252 255,
      bgSubtle = Color.rgb255 253 247 253,
      tintSubtle = Color.rgb255 251 235 251,
      tint = Color.rgb255 247 222 248,
      tintStrong = Color.rgb255 242 209 243,
      accentSubtle = Color.rgb255 233 194 236,
      accent = Color.rgb255 222 173 227,
      accentStrong = Color.rgb255 207 145 216,
      solidSubtle = Color.rgb255 177 85 191,
      solid = Color.rgb255 171 74 186,
      solidStrong = Color.rgb255 161 68 175,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 149 62 163,
      text = Color.rgb255 83 25 93,
  }


purple : ColorScale
purple = 
  {
      bg = Color.rgb255 254 252 254,
      bgSubtle = Color.rgb255 251 247 254,
      tintSubtle = Color.rgb255 247 237 254,
      tint = Color.rgb255 242 226 252,
      tintStrong = Color.rgb255 234 213 249,
      accentSubtle = Color.rgb255 224 196 244,
      accent = Color.rgb255 209 175 236,
      accentStrong = Color.rgb255 190 147 228,
      solidSubtle = Color.rgb255 152 86 209,
      solid = Color.rgb255 142 78 198,
      solidStrong = Color.rgb255 131 71 185,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 129 69 181,
      text = Color.rgb255 64 32 96,
  }


violet : ColorScale
violet = 
  {
      bg = Color.rgb255 253 252 254,
      bgSubtle = Color.rgb255 250 248 255,
      tintSubtle = Color.rgb255 244 240 254,
      tint = Color.rgb255 235 228 255,
      tintStrong = Color.rgb255 225 217 255,
      accentSubtle = Color.rgb255 212 202 254,
      accent = Color.rgb255 194 181 245,
      accentStrong = Color.rgb255 170 153 236,
      solidSubtle = Color.rgb255 120 96 216,
      solid = Color.rgb255 110 86 207,
      solidStrong = Color.rgb255 101 77 196,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 101 80 185,
      text = Color.rgb255 47 38 95,
  }


iris : ColorScale
iris = 
  {
      bg = Color.rgb255 253 253 255,
      bgSubtle = Color.rgb255 248 248 255,
      tintSubtle = Color.rgb255 240 241 254,
      tint = Color.rgb255 230 231 255,
      tintStrong = Color.rgb255 218 220 255,
      accentSubtle = Color.rgb255 203 205 255,
      accent = Color.rgb255 184 186 248,
      accentStrong = Color.rgb255 155 158 240,
      solidSubtle = Color.rgb255 101 101 222,
      solid = Color.rgb255 91 91 214,
      solidStrong = Color.rgb255 81 81 205,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 87 83 198,
      text = Color.rgb255 39 41 98,
  }


indigo : ColorScale
indigo = 
  {
      bg = Color.rgb255 253 253 254,
      bgSubtle = Color.rgb255 247 249 255,
      tintSubtle = Color.rgb255 237 242 254,
      tint = Color.rgb255 225 233 255,
      tintStrong = Color.rgb255 210 222 255,
      accentSubtle = Color.rgb255 193 208 255,
      accent = Color.rgb255 171 189 249,
      accentStrong = Color.rgb255 141 164 239,
      solidSubtle = Color.rgb255 73 110 229,
      solid = Color.rgb255 62 99 221,
      solidStrong = Color.rgb255 51 88 212,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 58 91 199,
      text = Color.rgb255 31 45 92,
  }


blue : ColorScale
blue = 
  {
      bg = Color.rgb255 251 253 255,
      bgSubtle = Color.rgb255 244 250 255,
      tintSubtle = Color.rgb255 230 244 254,
      tint = Color.rgb255 213 239 255,
      tintStrong = Color.rgb255 194 229 255,
      accentSubtle = Color.rgb255 172 216 252,
      accent = Color.rgb255 142 200 246,
      accentStrong = Color.rgb255 94 177 239,
      solidSubtle = Color.rgb255 5 148 260,
      solid = Color.rgb255 0 144 255,
      solidStrong = Color.rgb255 5 136 240,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 13 116 206,
      text = Color.rgb255 17 50 100,
  }


cyan : ColorScale
cyan = 
  {
      bg = Color.rgb255 250 253 254,
      bgSubtle = Color.rgb255 242 250 251,
      tintSubtle = Color.rgb255 222 247 249,
      tint = Color.rgb255 202 241 246,
      tintStrong = Color.rgb255 181 233 240,
      accentSubtle = Color.rgb255 157 221 231,
      accent = Color.rgb255 125 206 220,
      accentStrong = Color.rgb255 61 185 207,
      solidSubtle = Color.rgb255 247 172 213,
      solid = Color.rgb255 0 162 199,
      solidStrong = Color.rgb255 7 151 185,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 16 125 152,
      text = Color.rgb255 13 60 72,
  }


teal : ColorScale
teal = 
  {
      bg = Color.rgb255 250 254 253,
      bgSubtle = Color.rgb255 243 251 249,
      tintSubtle = Color.rgb255 224 248 243,
      tint = Color.rgb255 204 243 234,
      tintStrong = Color.rgb255 184 234 224,
      accentSubtle = Color.rgb255 161 222 210,
      accent = Color.rgb255 131 205 193,
      accentStrong = Color.rgb255 83 185 171,
      solidSubtle = Color.rgb255 23 174 156,
      solid = Color.rgb255 18 165 148,
      solidStrong = Color.rgb255 13 155 138,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 0 133 115,
      text = Color.rgb255 13 61 56,
  }


jade : ColorScale
jade = 
  {
      bg = Color.rgb255 251 254 253,
      bgSubtle = Color.rgb255 244 251 247,
      tintSubtle = Color.rgb255 230 247 237,
      tint = Color.rgb255 214 241 227,
      tintStrong = Color.rgb255 195 233 215,
      accentSubtle = Color.rgb255 172 222 200,
      accent = Color.rgb255 139 206 182,
      accentStrong = Color.rgb255 86 186 159,
      solidSubtle = Color.rgb255 44 172 139,
      solid = Color.rgb255 41 163 131,
      solidStrong = Color.rgb255 38 153 123,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 32 131 104,
      text = Color.rgb255 29 59 49,
  }


green : ColorScale
green = 
  {
      bg = Color.rgb255 251 254 252,
      bgSubtle = Color.rgb255 244 251 246,
      tintSubtle = Color.rgb255 230 246 235,
      tint = Color.rgb255 214 241 223,
      tintStrong = Color.rgb255 196 232 209,
      accentSubtle = Color.rgb255 173 221 192,
      accent = Color.rgb255 142 206 170,
      accentStrong = Color.rgb255 91 185 139,
      solidSubtle = Color.rgb255 53 173 115,
      solid = Color.rgb255 48 164 108,
      solidStrong = Color.rgb255 43 154 102,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 33 131 88,
      text = Color.rgb255 25 59 45,
  }


grass : ColorScale
grass = 
  {
      bg = Color.rgb255 251 254 251,
      bgSubtle = Color.rgb255 245 251 245,
      tintSubtle = Color.rgb255 233 246 233,
      tint = Color.rgb255 218 241 219,
      tintStrong = Color.rgb255 201 232 202,
      accentSubtle = Color.rgb255 178 221 181,
      accent = Color.rgb255 148 206 154,
      accentStrong = Color.rgb255 101 186 116,
      solidSubtle = Color.rgb255 79 177 97,
      solid = Color.rgb255 70 167 88,
      solidStrong = Color.rgb255 62 155 79,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 42 126 59,
      text = Color.rgb255 32 60 37,
  }


brown : ColorScale
brown = 
  {
      bg = Color.rgb255 254 253 252,
      bgSubtle = Color.rgb255 252 249 246,
      tintSubtle = Color.rgb255 246 238 231,
      tint = Color.rgb255 240 228 217,
      tintStrong = Color.rgb255 235 218 202,
      accentSubtle = Color.rgb255 228 205 183,
      accent = Color.rgb255 220 188 159,
      accentStrong = Color.rgb255 206 163 126,
      solidSubtle = Color.rgb255 181 136 97,
      solid = Color.rgb255 173 127 88,
      solidStrong = Color.rgb255 160 117 83,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 129 94 70,
      text = Color.rgb255 62 51 46,
  }


bronze : ColorScale
bronze = 
  {
      bg = Color.rgb255 253 252 252,
      bgSubtle = Color.rgb255 253 247 245,
      tintSubtle = Color.rgb255 246 237 234,
      tint = Color.rgb255 239 228 223,
      tintStrong = Color.rgb255 231 217 211,
      accentSubtle = Color.rgb255 223 205 197,
      accent = Color.rgb255 211 188 179,
      accentStrong = Color.rgb255 194 164 153,
      solidSubtle = Color.rgb255 172 138 124,
      solid = Color.rgb255 161 128 114,
      solidStrong = Color.rgb255 149 116 104,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 125 94 84,
      text = Color.rgb255 67 48 43,
  }


gold : ColorScale
gold = 
  {
      bg = Color.rgb255 253 253 252,
      bgSubtle = Color.rgb255 250 249 242,
      tintSubtle = Color.rgb255 242 240 231,
      tint = Color.rgb255 234 230 219,
      tintStrong = Color.rgb255 225 220 207,
      accentSubtle = Color.rgb255 216 208 191,
      accent = Color.rgb255 203 192 170,
      accentStrong = Color.rgb255 185 168 141,
      solidSubtle = Color.rgb255 159 139 110,
      solid = Color.rgb255 151 131 101,
      solidStrong = Color.rgb255 140 122 94,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 113 98 75,
      text = Color.rgb255 59 53 43,
  }


sky : ColorScale
sky = 
  {
      bg = Color.rgb255 249 254 255,
      bgSubtle = Color.rgb255 241 250 253,
      tintSubtle = Color.rgb255 225 246 253,
      tint = Color.rgb255 209 240 250,
      tintStrong = Color.rgb255 190 231 245,
      accentSubtle = Color.rgb255 169 218 237,
      accent = Color.rgb255 141 202 227,
      accentStrong = Color.rgb255 96 179 215,
      solidSubtle = Color.rgb255 133 231 258,
      solid = Color.rgb255 124 226 254,
      solidStrong = Color.rgb255 116 218 248,
      solidText = Color.rgb255 29 62 86,
      textSubtle = Color.rgb255 0 116 158,
      text = Color.rgb255 29 62 86,
  }


mint : ColorScale
mint = 
  {
      bg = Color.rgb255 249 254 253,
      bgSubtle = Color.rgb255 242 251 249,
      tintSubtle = Color.rgb255 221 249 242,
      tint = Color.rgb255 200 244 233,
      tintStrong = Color.rgb255 179 236 222,
      accentSubtle = Color.rgb255 156 224 208,
      accent = Color.rgb255 126 207 189,
      accentStrong = Color.rgb255 76 187 165,
      solidSubtle = Color.rgb255 144 242 220,
      solid = Color.rgb255 134 234 212,
      solidStrong = Color.rgb255 125 224 203,
      solidText = Color.rgb255 22 67 60,
      textSubtle = Color.rgb255 2 120 100,
      text = Color.rgb255 22 67 60,
  }


lime : ColorScale
lime = 
  {
      bg = Color.rgb255 252 253 250,
      bgSubtle = Color.rgb255 248 250 243,
      tintSubtle = Color.rgb255 238 246 214,
      tint = Color.rgb255 226 240 189,
      tintStrong = Color.rgb255 211 231 166,
      accentSubtle = Color.rgb255 194 218 145,
      accent = Color.rgb255 171 201 120,
      accentStrong = Color.rgb255 141 182 84,
      solidSubtle = Color.rgb255 201 244 123,
      solid = Color.rgb255 189 238 99,
      solidStrong = Color.rgb255 176 230 76,
      solidText = Color.rgb255 55 64 28,
      textSubtle = Color.rgb255 92 124 47,
      text = Color.rgb255 55 64 28,
  }


yellow : ColorScale
yellow = 
  {
      bg = Color.rgb255 253 253 249,
      bgSubtle = Color.rgb255 254 252 233,
      tintSubtle = Color.rgb255 255 250 184,
      tint = Color.rgb255 255 243 148,
      tintStrong = Color.rgb255 255 231 112,
      accentSubtle = Color.rgb255 243 215 104,
      accent = Color.rgb255 228 199 103,
      accentStrong = Color.rgb255 213 174 57,
      solidSubtle = Color.rgb255 255 234 82,
      solid = Color.rgb255 255 230 41,
      solidStrong = Color.rgb255 255 220 0,
      solidText = Color.rgb255 71 59 31,
      textSubtle = Color.rgb255 158 108 0,
      text = Color.rgb255 71 59 31,
  }


amber : ColorScale
amber = 
  {
      bg = Color.rgb255 254 253 251,
      bgSubtle = Color.rgb255 254 251 233,
      tintSubtle = Color.rgb255 255 247 194,
      tint = Color.rgb255 255 238 156,
      tintStrong = Color.rgb255 251 229 119,
      accentSubtle = Color.rgb255 243 214 115,
      accent = Color.rgb255 233 193 98,
      accentStrong = Color.rgb255 226 163 54,
      solidSubtle = Color.rgb255 255 208 97,
      solid = Color.rgb255 255 197 61,
      solidStrong = Color.rgb255 255 186 24,
      solidText = Color.rgb255 79 52 34,
      textSubtle = Color.rgb255 171 100 0,
      text = Color.rgb255 79 52 34,
  }


orange : ColorScale
orange = 
  {
      bg = Color.rgb255 254 252 251,
      bgSubtle = Color.rgb255 255 247 237,
      tintSubtle = Color.rgb255 255 239 214,
      tint = Color.rgb255 255 223 181,
      tintStrong = Color.rgb255 255 209 154,
      accentSubtle = Color.rgb255 255 193 130,
      accent = Color.rgb255 245 174 115,
      accentStrong = Color.rgb255 236 148 85,
      solidSubtle = Color.rgb255 240 126 56,
      solid = Color.rgb255 247 107 21,
      solidStrong = Color.rgb255 239 95 0,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 204 78 0,
      text = Color.rgb255 88 45 29,
  }


grayDark : ColorScale
grayDark = 
  {
      bg = Color.rgb255 25 25 25,
      bgSubtle = Color.rgb255 17 17 17,
      tintSubtle = Color.rgb255 34 34 34,
      tint = Color.rgb255 42 42 42,
      tintStrong = Color.rgb255 49 49 49,
      accentSubtle = Color.rgb255 58 58 58,
      accent = Color.rgb255 72 72 72,
      accentStrong = Color.rgb255 96 96 96,
      solidSubtle = Color.rgb255 97 97 97,
      solid = Color.rgb255 110 110 110,
      solidStrong = Color.rgb255 123 123 123,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 180 180 180,
      text = Color.rgb255 238 238 238,
  }


mauveDark : ColorScale
mauveDark = 
  {
      bg = Color.rgb255 26 25 27,
      bgSubtle = Color.rgb255 18 17 19,
      tintSubtle = Color.rgb255 35 34 37,
      tint = Color.rgb255 43 41 45,
      tintStrong = Color.rgb255 50 48 53,
      accentSubtle = Color.rgb255 60 57 63,
      accent = Color.rgb255 73 71 78,
      accentStrong = Color.rgb255 98 95 105,
      solidSubtle = Color.rgb255 98 96 106,
      solid = Color.rgb255 111 109 120,
      solidStrong = Color.rgb255 124 122 133,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 181 178 188,
      text = Color.rgb255 238 238 240,
  }


slateDark : ColorScale
slateDark = 
  {
      bg = Color.rgb255 24 25 27,
      bgSubtle = Color.rgb255 17 17 19,
      tintSubtle = Color.rgb255 33 34 37,
      tint = Color.rgb255 39 42 45,
      tintStrong = Color.rgb255 46 49 53,
      accentSubtle = Color.rgb255 54 58 63,
      accent = Color.rgb255 67 72 78,
      accentStrong = Color.rgb255 90 97 105,
      solidSubtle = Color.rgb255 91 96 105,
      solid = Color.rgb255 105 110 119,
      solidStrong = Color.rgb255 119 123 132,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 176 180 186,
      text = Color.rgb255 237 238 240,
  }


sageDark : ColorScale
sageDark = 
  {
      bg = Color.rgb255 23 25 24,
      bgSubtle = Color.rgb255 16 18 17,
      tintSubtle = Color.rgb255 32 34 33,
      tint = Color.rgb255 39 42 41,
      tintStrong = Color.rgb255 46 49 48,
      accentSubtle = Color.rgb255 55 59 57,
      accent = Color.rgb255 68 73 71,
      accentStrong = Color.rgb255 91 98 95,
      solidSubtle = Color.rgb255 85 98 93,
      solid = Color.rgb255 99 112 107,
      solidStrong = Color.rgb255 113 125 121,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 173 181 178,
      text = Color.rgb255 236 238 237,
  }


oliveDark : ColorScale
oliveDark = 
  {
      bg = Color.rgb255 24 25 23,
      bgSubtle = Color.rgb255 17 18 16,
      tintSubtle = Color.rgb255 33 34 32,
      tint = Color.rgb255 40 42 39,
      tintStrong = Color.rgb255 47 49 46,
      accentSubtle = Color.rgb255 56 58 54,
      accent = Color.rgb255 69 72 67,
      accentStrong = Color.rgb255 92 98 91,
      solidSubtle = Color.rgb255 90 98 88,
      solid = Color.rgb255 104 112 102,
      solidStrong = Color.rgb255 118 125 116,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 175 181 173,
      text = Color.rgb255 236 238 236,
  }


sandDark : ColorScale
sandDark = 
  {
      bg = Color.rgb255 25 25 24,
      bgSubtle = Color.rgb255 17 17 16,
      tintSubtle = Color.rgb255 34 34 33,
      tint = Color.rgb255 42 42 40,
      tintStrong = Color.rgb255 49 49 46,
      accentSubtle = Color.rgb255 59 58 55,
      accent = Color.rgb255 73 72 68,
      accentStrong = Color.rgb255 98 96 91,
      solidSubtle = Color.rgb255 97 95 88,
      solid = Color.rgb255 111 109 102,
      solidStrong = Color.rgb255 124 123 116,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 181 179 173,
      text = Color.rgb255 238 238 236,
  }


tomatoDark : ColorScale
tomatoDark = 
  {
      bg = Color.rgb255 31 21 19,
      bgSubtle = Color.rgb255 24 17 17,
      tintSubtle = Color.rgb255 57 23 20,
      tint = Color.rgb255 78 21 17,
      tintStrong = Color.rgb255 94 28 22,
      accentSubtle = Color.rgb255 110 41 32,
      accent = Color.rgb255 133 58 45,
      accentStrong = Color.rgb255 172 77 57,
      solidSubtle = Color.rgb255 215 63 32,
      solid = Color.rgb255 229 77 46,
      solidStrong = Color.rgb255 236 97 66,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 255 151 125,
      text = Color.rgb255 251 211 203,
  }


redDark : ColorScale
redDark = 
  {
      bg = Color.rgb255 32 19 20,
      bgSubtle = Color.rgb255 25 17 17,
      tintSubtle = Color.rgb255 59 18 25,
      tint = Color.rgb255 80 15 28,
      tintStrong = Color.rgb255 97 22 35,
      accentSubtle = Color.rgb255 114 35 45,
      accent = Color.rgb255 140 51 58,
      accentStrong = Color.rgb255 181 69 72,
      solidSubtle = Color.rgb255 220 52 57,
      solid = Color.rgb255 229 72 77,
      solidStrong = Color.rgb255 236 93 94,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 255 149 146,
      text = Color.rgb255 255 209 217,
  }


rubyDark : ColorScale
rubyDark = 
  {
      bg = Color.rgb255 30 21 23,
      bgSubtle = Color.rgb255 25 17 19,
      tintSubtle = Color.rgb255 58 20 30,
      tint = Color.rgb255 78 19 37,
      tintStrong = Color.rgb255 94 26 46,
      accentSubtle = Color.rgb255 111 37 57,
      accent = Color.rgb255 136 52 71,
      accentStrong = Color.rgb255 179 68 90,
      solidSubtle = Color.rgb255 220 51 85,
      solid = Color.rgb255 229 70 102,
      solidStrong = Color.rgb255 236 90 114,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 255 148 157,
      text = Color.rgb255 254 210 225,
  }


crimsonDark : ColorScale
crimsonDark = 
  {
      bg = Color.rgb255 32 19 24,
      bgSubtle = Color.rgb255 25 17 20,
      tintSubtle = Color.rgb255 56 21 37,
      tint = Color.rgb255 77 18 47,
      tintStrong = Color.rgb255 92 24 57,
      accentSubtle = Color.rgb255 109 37 69,
      accent = Color.rgb255 135 51 86,
      accentStrong = Color.rgb255 176 67 110,
      solidSubtle = Color.rgb255 227 41 116,
      solid = Color.rgb255 233 61 130,
      solidStrong = Color.rgb255 238 81 138,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 255 146 173,
      text = Color.rgb255 253 211 232,
  }


pinkDark : ColorScale
pinkDark = 
  {
      bg = Color.rgb255 33 18 29,
      bgSubtle = Color.rgb255 25 17 23,
      tintSubtle = Color.rgb255 55 23 47,
      tint = Color.rgb255 75 20 61,
      tintStrong = Color.rgb255 89 28 71,
      accentSubtle = Color.rgb255 105 41 85,
      accent = Color.rgb255 131 56 105,
      accentStrong = Color.rgb255 168 72 133,
      solidSubtle = Color.rgb255 203 49 147,
      solid = Color.rgb255 214 64 159,
      solidStrong = Color.rgb255 222 81 168,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 255 141 204,
      text = Color.rgb255 253 209 234,
  }


plumDark : ColorScale
plumDark = 
  {
      bg = Color.rgb255 32 19 32,
      bgSubtle = Color.rgb255 24 17 24,
      tintSubtle = Color.rgb255 53 26 53,
      tint = Color.rgb255 69 29 71,
      tintStrong = Color.rgb255 81 36 84,
      accentSubtle = Color.rgb255 94 48 97,
      accent = Color.rgb255 115 64 121,
      accentStrong = Color.rgb255 146 84 156,
      solidSubtle = Color.rgb255 154 68 167,
      solid = Color.rgb255 171 74 186,
      solidStrong = Color.rgb255 182 88 196,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 231 150 243,
      text = Color.rgb255 244 212 244,
  }


purpleDark : ColorScale
purpleDark = 
  {
      bg = Color.rgb255 30 21 35,
      bgSubtle = Color.rgb255 24 17 27,
      tintSubtle = Color.rgb255 48 28 59,
      tint = Color.rgb255 61 34 78,
      tintStrong = Color.rgb255 72 41 92,
      accentSubtle = Color.rgb255 84 52 107,
      accent = Color.rgb255 102 66 130,
      accentStrong = Color.rgb255 132 87 170,
      solidSubtle = Color.rgb255 129 66 185,
      solid = Color.rgb255 142 78 198,
      solidStrong = Color.rgb255 154 92 208,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 209 157 255,
      text = Color.rgb255 236 217 250,
  }


violetDark : ColorScale
violetDark = 
  {
      bg = Color.rgb255 27 21 37,
      bgSubtle = Color.rgb255 20 18 31,
      tintSubtle = Color.rgb255 41 31 67,
      tint = Color.rgb255 51 37 91,
      tintStrong = Color.rgb255 60 46 105,
      accentSubtle = Color.rgb255 71 56 118,
      accent = Color.rgb255 86 70 139,
      accentStrong = Color.rgb255 105 88 173,
      solidSubtle = Color.rgb255 95 71 195,
      solid = Color.rgb255 110 86 207,
      solidStrong = Color.rgb255 125 102 217,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 186 167 255,
      text = Color.rgb255 226 221 254,
  }


irisDark : ColorScale
irisDark = 
  {
      bg = Color.rgb255 23 22 37,
      bgSubtle = Color.rgb255 19 19 30,
      tintSubtle = Color.rgb255 32 34 72,
      tint = Color.rgb255 38 42 101,
      tintStrong = Color.rgb255 48 51 116,
      accentSubtle = Color.rgb255 61 62 130,
      accent = Color.rgb255 74 74 149,
      accentStrong = Color.rgb255 89 88 177,
      solidSubtle = Color.rgb255 76 76 205,
      solid = Color.rgb255 91 91 214,
      solidStrong = Color.rgb255 110 106 222,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 177 169 255,
      text = Color.rgb255 224 223 254,
  }


indigoDark : ColorScale
indigoDark = 
  {
      bg = Color.rgb255 20 23 38,
      bgSubtle = Color.rgb255 17 19 31,
      tintSubtle = Color.rgb255 24 36 73,
      tint = Color.rgb255 29 46 98,
      tintStrong = Color.rgb255 37 57 116,
      accentSubtle = Color.rgb255 48 67 132,
      accent = Color.rgb255 58 79 151,
      accentStrong = Color.rgb255 67 93 177,
      solidSubtle = Color.rgb255 41 81 212,
      solid = Color.rgb255 62 99 221,
      solidStrong = Color.rgb255 84 114 228,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 158 177 255,
      text = Color.rgb255 214 225 255,
  }


blueDark : ColorScale
blueDark = 
  {
      bg = Color.rgb255 17 25 39,
      bgSubtle = Color.rgb255 13 21 32,
      tintSubtle = Color.rgb255 13 40 71,
      tint = Color.rgb255 0 51 98,
      tintStrong = Color.rgb255 0 64 116,
      accentSubtle = Color.rgb255 16 77 135,
      accent = Color.rgb255 32 93 158,
      accentStrong = Color.rgb255 40 112 189,
      solidSubtle = Color.rgb255 0 110 195,
      solid = Color.rgb255 0 144 255,
      solidStrong = Color.rgb255 59 158 255,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 112 184 255,
      text = Color.rgb255 194 230 255,
  }


cyanDark : ColorScale
cyanDark = 
  {
      bg = Color.rgb255 16 27 32,
      bgSubtle = Color.rgb255 11 22 26,
      tintSubtle = Color.rgb255 8 44 54,
      tint = Color.rgb255 0 56 72,
      tintStrong = Color.rgb255 0 69 88,
      accentSubtle = Color.rgb255 4 84 104,
      accent = Color.rgb255 18 103 126,
      accentStrong = Color.rgb255 17 128 156,
      solidSubtle = Color.rgb255 232 140 177,
      solid = Color.rgb255 0 162 199,
      solidStrong = Color.rgb255 35 175 208,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 76 204 230,
      text = Color.rgb255 182 236 247,
  }


tealDark : ColorScale
tealDark = 
  {
      bg = Color.rgb255 17 28 27,
      bgSubtle = Color.rgb255 13 21 20,
      tintSubtle = Color.rgb255 13 45 42,
      tint = Color.rgb255 2 59 55,
      tintStrong = Color.rgb255 8 72 67,
      accentSubtle = Color.rgb255 20 87 80,
      accent = Color.rgb255 28 105 97,
      accentStrong = Color.rgb255 32 126 115,
      solidSubtle = Color.rgb255 21 151 136,
      solid = Color.rgb255 18 165 148,
      solidStrong = Color.rgb255 14 179 158,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 11 216 182,
      text = Color.rgb255 173 240 221,
  }


jadeDark : ColorScale
jadeDark = 
  {
      bg = Color.rgb255 18 28 24,
      bgSubtle = Color.rgb255 13 21 18,
      tintSubtle = Color.rgb255 15 46 34,
      tint = Color.rgb255 11 59 44,
      tintStrong = Color.rgb255 17 72 55,
      accentSubtle = Color.rgb255 27 87 69,
      accent = Color.rgb255 36 104 84,
      accentStrong = Color.rgb255 42 126 104,
      solidSubtle = Color.rgb255 42 150 122,
      solid = Color.rgb255 41 163 131,
      solidStrong = Color.rgb255 39 176 139,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 31 216 164,
      text = Color.rgb255 173 240 212,
  }


greenDark : ColorScale
greenDark = 
  {
      bg = Color.rgb255 18 27 23,
      bgSubtle = Color.rgb255 14 21 18,
      tintSubtle = Color.rgb255 19 45 33,
      tint = Color.rgb255 17 59 41,
      tintStrong = Color.rgb255 23 73 51,
      accentSubtle = Color.rgb255 32 87 62,
      accent = Color.rgb255 40 104 74,
      accentStrong = Color.rgb255 47 124 87,
      solidSubtle = Color.rgb255 44 152 100,
      solid = Color.rgb255 48 164 108,
      solidStrong = Color.rgb255 51 176 116,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 61 214 140,
      text = Color.rgb255 177 241 203,
  }


grassDark : ColorScale
grassDark = 
  {
      bg = Color.rgb255 20 26 21,
      bgSubtle = Color.rgb255 14 21 17,
      tintSubtle = Color.rgb255 27 42 30,
      tint = Color.rgb255 29 58 36,
      tintStrong = Color.rgb255 37 72 45,
      accentSubtle = Color.rgb255 45 87 54,
      accent = Color.rgb255 54 103 64,
      accentStrong = Color.rgb255 62 121 73,
      solidSubtle = Color.rgb255 60 151 77,
      solid = Color.rgb255 70 167 88,
      solidStrong = Color.rgb255 83 179 101,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 113 208 131,
      text = Color.rgb255 194 240 194,
  }


brownDark : ColorScale
brownDark = 
  {
      bg = Color.rgb255 28 24 22,
      bgSubtle = Color.rgb255 18 17 15,
      tintSubtle = Color.rgb255 40 33 29,
      tint = Color.rgb255 50 41 34,
      tintStrong = Color.rgb255 62 49 40,
      accentSubtle = Color.rgb255 77 60 47,
      accent = Color.rgb255 97 74 57,
      accentStrong = Color.rgb255 124 95 70,
      solidSubtle = Color.rgb255 155 114 79,
      solid = Color.rgb255 173 127 88,
      solidStrong = Color.rgb255 184 140 103,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 219 181 148,
      text = Color.rgb255 242 225 202,
  }


bronzeDark : ColorScale
bronzeDark = 
  {
      bg = Color.rgb255 28 25 23,
      bgSubtle = Color.rgb255 20 17 16,
      tintSubtle = Color.rgb255 38 34 32,
      tint = Color.rgb255 48 42 39,
      tintStrong = Color.rgb255 59 51 48,
      accentSubtle = Color.rgb255 73 62 58,
      accent = Color.rgb255 90 76 71,
      accentStrong = Color.rgb255 111 95 88,
      solidSubtle = Color.rgb255 146 116 103,
      solid = Color.rgb255 161 128 114,
      solidStrong = Color.rgb255 174 140 126,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 212 179 165,
      text = Color.rgb255 237 224 217,
  }


goldDark : ColorScale
goldDark = 
  {
      bg = Color.rgb255 27 26 23,
      bgSubtle = Color.rgb255 18 18 17,
      tintSubtle = Color.rgb255 36 35 31,
      tint = Color.rgb255 45 43 38,
      tintStrong = Color.rgb255 56 53 46,
      accentSubtle = Color.rgb255 68 64 57,
      accent = Color.rgb255 84 79 70,
      accentStrong = Color.rgb255 105 98 86,
      solidSubtle = Color.rgb255 134 117 91,
      solid = Color.rgb255 151 131 101,
      solidStrong = Color.rgb255 163 144 115,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 203 185 159,
      text = Color.rgb255 232 226 217,
  }


skyDark : ColorScale
skyDark = 
  {
      bg = Color.rgb255 17 26 39,
      bgSubtle = Color.rgb255 13 20 31,
      tintSubtle = Color.rgb255 17 40 64,
      tint = Color.rgb255 17 53 85,
      tintStrong = Color.rgb255 21 68 103,
      accentSubtle = Color.rgb255 27 83 123,
      accent = Color.rgb255 31 102 146,
      accentStrong = Color.rgb255 25 124 174,
      solidSubtle = Color.rgb255 80 215 252,
      solid = Color.rgb255 124 226 254,
      solidStrong = Color.rgb255 168 238 255,
      solidText = Color.rgb255 17 26 39,
      textSubtle = Color.rgb255 117 199 240,
      text = Color.rgb255 194 243 255,
  }


mintDark : ColorScale
mintDark = 
  {
      bg = Color.rgb255 15 27 27,
      bgSubtle = Color.rgb255 14 21 21,
      tintSubtle = Color.rgb255 9 44 43,
      tint = Color.rgb255 0 58 56,
      tintStrong = Color.rgb255 0 71 68,
      accentSubtle = Color.rgb255 16 86 80,
      accent = Color.rgb255 30 104 95,
      accentStrong = Color.rgb255 39 127 112,
      solidSubtle = Color.rgb255 104 218 193,
      solid = Color.rgb255 134 234 212,
      solidStrong = Color.rgb255 168 245 229,
      solidText = Color.rgb255 15 27 27,
      textSubtle = Color.rgb255 88 213 186,
      text = Color.rgb255 196 245 225,
  }


limeDark : ColorScale
limeDark = 
  {
      bg = Color.rgb255 21 26 16,
      bgSubtle = Color.rgb255 17 19 12,
      tintSubtle = Color.rgb255 31 41 23,
      tint = Color.rgb255 41 55 29,
      tintStrong = Color.rgb255 51 68 35,
      accentSubtle = Color.rgb255 61 82 42,
      accent = Color.rgb255 73 98 49,
      accentStrong = Color.rgb255 87 117 56,
      solidSubtle = Color.rgb255 171 215 91,
      solid = Color.rgb255 189 238 99,
      solidStrong = Color.rgb255 212 255 112,
      solidText = Color.rgb255 21 26 16,
      textSubtle = Color.rgb255 189 229 108,
      text = Color.rgb255 227 247 186,
  }


yellowDark : ColorScale
yellowDark = 
  {
      bg = Color.rgb255 27 24 15,
      bgSubtle = Color.rgb255 20 18 11,
      tintSubtle = Color.rgb255 45 35 5,
      tint = Color.rgb255 54 43 0,
      tintStrong = Color.rgb255 67 53 0,
      accentSubtle = Color.rgb255 82 66 2,
      accent = Color.rgb255 102 84 23,
      accentStrong = Color.rgb255 131 106 33,
      solidSubtle = Color.rgb255 250 220 0,
      solid = Color.rgb255 255 230 41,
      solidStrong = Color.rgb255 255 255 87,
      solidText = Color.rgb255 27 24 15,
      textSubtle = Color.rgb255 245 225 71,
      text = Color.rgb255 246 238 180,
  }


amberDark : ColorScale
amberDark = 
  {
      bg = Color.rgb255 29 24 15,
      bgSubtle = Color.rgb255 22 18 12,
      tintSubtle = Color.rgb255 48 32 8,
      tint = Color.rgb255 63 39 0,
      tintStrong = Color.rgb255 77 48 0,
      accentSubtle = Color.rgb255 92 61 5,
      accent = Color.rgb255 113 79 25,
      accentStrong = Color.rgb255 143 100 36,
      solidSubtle = Color.rgb255 255 212 111,
      solid = Color.rgb255 255 197 61,
      solidStrong = Color.rgb255 255 214 10,
      solidText = Color.rgb255 29 24 15,
      textSubtle = Color.rgb255 255 202 22,
      text = Color.rgb255 255 231 179,
  }


orangeDark : ColorScale
orangeDark = 
  {
      bg = Color.rgb255 30 22 15,
      bgSubtle = Color.rgb255 23 18 14,
      tintSubtle = Color.rgb255 51 30 11,
      tint = Color.rgb255 70 33 0,
      tintStrong = Color.rgb255 86 40 0,
      accentSubtle = Color.rgb255 102 53 12,
      accent = Color.rgb255 126 69 29,
      accentStrong = Color.rgb255 163 88 41,
      solidSubtle = Color.rgb255 233 99 16,
      solid = Color.rgb255 247 107 21,
      solidStrong = Color.rgb255 255 128 31,
      solidText = Color.rgb255 255 255 255,
      textSubtle = Color.rgb255 255 160 87,
      text = Color.rgb255 255 224 194,
  }
