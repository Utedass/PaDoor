#!/usr/bin/python3

#########################################
#Script Name:				#
#Decription: 				#
#Args:					#
#Author:				#
#Email:					#
#########################################
from PIL import Image, ImageDraw

# Tile size
width, height = 64, 32

# Create transparent image
tile = Image.new("RGBA", (width, height), (0, 0, 0, 0))
draw = ImageDraw.Draw(tile)

# Diamond points (isometric shape)
diamond = [
    (width // 2, 0),             # Top middle
    (width, height // 2),        # Right middle
    (width // 2, height),        # Bottom middle
    (0, height // 2)             # Left middle
]

# Fill diamond
fill_color = (100, 200, 100, 255)  # Green
draw.polygon(diamond, fill=fill_color)

# Optional: outline
outline_color = (60, 120, 60, 255)
draw.line(diamond + [diamond[0]], fill=outline_color, width=1)

# Save
tile.save("reftile.png")

