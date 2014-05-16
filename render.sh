#!/usr/bin/env bash

# Render icon
function render {
rsvg-convert --width=$1 --height=$1 --format=png src/icon.svg > rendered/icon_$1.png
}

render 16
render 32
render 64
render 128
render 256
render 512


# Render splash screen
gimp -i --batch-interpreter=python-fu-eval -b - << EOF

import gimpfu

def render(filename):
	img = pdb.gimp_file_load("src/"+filename, filename)
	new_name = "rendered/" + filename.rsplit(".xcf",1)[0] + ".png"
	layer = pdb.gimp_image_merge_visible_layers(img, gimpfu.CLIP_TO_IMAGE)

	pdb.gimp_file_save(img, layer, new_name, new_name)
	pdb.gimp_image_delete(img)

render("splash.xcf.bz2")
pdb.gimp_quit(1)

EOF
