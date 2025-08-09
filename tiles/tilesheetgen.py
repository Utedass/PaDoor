#!/usr/bin/python3

from PIL import Image, ImageDraw

colors = {
    "red": (255, 0, 0, 255),
    "green": (0, 255, 0, 255),
    "blue": (0, 0, 255, 255),
    "yellow": (255, 255, 0, 255),
    "cyan": (0, 255, 255, 255),
    "magenta": (255, 0, 255, 255),
    "orange": (255, 165, 0, 255),
    "purple": (128, 0, 128, 255),
    "pink": (255, 192, 203, 255),
    "brown": (139, 69, 19, 255),
    "lime": (191, 255, 0, 255),
    "navy": (0, 0, 128, 255),
    "teal": (0, 128, 128, 255),
    "olive": (128, 128, 0, 255),
    "gray": (128, 128, 128, 255),
    "black": (0, 0, 0, 255)
}

tile_w, tile_h = 64, 32
cols, rows = 4, 4
spritesheet_w = tile_w * cols
spritesheet_h = tile_h * rows

sheet = Image.new("RGBA", (spritesheet_w, spritesheet_h), (0, 0, 0, 0))
diamond = [
    (tile_w // 2, 0),
    (tile_w, tile_h // 2),
    (tile_w // 2, tile_h),
    (0, tile_h // 2)
]

color_names = list(colors.keys())

for idx, name in enumerate(color_names):
    col = idx % cols
    row = idx // cols
    x_offset = col * tile_w
    y_offset = row * tile_h

    tile = Image.new("RGBA", (tile_w, tile_h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(tile)
    draw.polygon(diamond, fill=colors[name])
    outline_color = tuple(max(c - 40, 0) for c in colors[name][:3]) + (255,)
    draw.line(diamond + [diamond[0]], fill=outline_color, width=1)

    sheet.paste(tile, (x_offset, y_offset))

sheet.save("iso_tiles_spritesheet.png")

