from blackstripes import crossed
from blackstripes import sketchy
from blackstripes import spiral
from PIL import Image


def levels_by_preview_name(name):
    return (100, 150, 200, 230)


def crop_by_preview_name(name):
    return name


def classic_small(image_path, path, color):

    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((500, 500), Image.ANTIALIAS)
    im.save(selected_crop)

    crossed.draw(selected_crop,         # input
                 path,                   # output
                 3,                      # nibsize (line size in output svg)
                 color,                  # line color
                 1.00,                   # scaling factor
                 l1, l2, l3, l4,         # levels
                 1,                      # type
                 380, 500, 0.2              # signature transform
                 )


def sketchy_small(image_path, path, color):

    im = Image.open(image_path)
    im = im.resize((500, 500), Image.ANTIALIAS)
    im.save(image_path)

    sketchy.draw(image_path,            # input
                 path,                   # output
                 2,                      # nibsize (line size in output svg)
                 100,                    # max line length
                 color,                  # line color
                 1.00,                   # scaling factor
                 # line size (internal line size for calculations)
                 1,
                 380, 500, 0.2              # signature transform
                 )


def spiral_small(image_path, path, color):

    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((500, 500), Image.ANTIALIAS)
    im.save(selected_crop)

    spiral.draw(selected_crop,             # input
                path,                      # output
                4,                         # nibsize (line size in output svg)
                color,                     # line color
                1.00,                      # scaling factor
                l1, l2, l3, l4,            # levels
                3,                         # line spacing
                380, 500, 0.2                # signature transform
                )


def classic_large(image_path, path, color):

    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((1000, 1000), Image.ANTIALIAS)
    im.save(selected_crop)

    crossed.draw(selected_crop,         # input
                 path,                   # output
                 3,                      # nibsize (line size in output svg)
                 color,                  # line color
                 1.06,                   # scaling factor
                 l1, l2, l3, l4,         # levels
                 1,                      # type
                 820, 975, 0.3             # signature transform
                 )


def sketchy_large(image_path, path, color):

    im = Image.open(image_path)
    im = im.resize((1000, 1000), Image.ANTIALIAS)
    im.save(image_path)

    sketchy.draw(image_path,            # input
                 path,                   # output
                 2,                      # nibsize (line size in output svg)
                 100,                    # max line length
                 color,                  # line color
                 1.06,                   # scaling factor
                 # line size (internal line size for calculations)
                 1,
                 820, 975, 0.3            # signature transform
                 )


def spiral_large(image_path, path, color):

    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((1000, 1000), Image.ANTIALIAS)
    im.save(selected_crop)

    spiral.draw(selected_crop,             # input
                path,                      # output
                4,                         # nibsize (line size in output svg)
                color,                     # line color
                1.06,                      # scaling factor
                l1, l2, l3, l4,            # levels
                3,                         # line spacing
                820, 975, 0.3               # signature transform
                )


def classic_extra_large(image_path, path, color):
    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((1000, 1000), Image.ANTIALIAS)
    im.save(selected_crop)

    sig_scale = 1.0/1.39

    crossed.draw(selected_crop,     # input
                 path,                   # output
                 3,                      # nibsize (line size in output svg)
                 color,                  # line color
                 1.39,                   # scaling factor
                 l1, l2, l3, l4,         # levels
                 2,                      # type
                 840, 975, 0.3       # signature transform
                 )


def spiral_extra_large(image_path, path, color):
    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((1000, 1000), Image.ANTIALIAS)
    im.save(selected_crop)

    sig_scale = 1.0/1.39

    spiral.draw(selected_crop,         # input
                path,                      # output
                3,                         # nibsize (line size in output svg)
                color,                     # line color
                1.39,                      # scaling factor
                l1, l2, l3, l4,            # levels
                2,                         # line spacing
                840, 975, 0.3        # signature transform
                )


def sketchy_extra_large(image_path, path, color):

    im = Image.open(image_path)
    im = im.resize((1390, 1390), Image.ANTIALIAS)
    im.save(image_path)

    sig_scale = 1.0/1.39

    sketchy.draw(image_path,            # input
                 path,                   # output
                 2,                      # nibsize (line size in output svg)
                 100,                    # max line length
                 color,                  # line color
                 1.00,                   # scaling factor
                 # line size (internal line size for calculations)
                 1,
                 1225, 1370, 0.3   # signature transform
                 )


def classic_pen_a3_portrait(image_path, path, color):
    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((668, 1000), Image.ANTIALIAS)
    im.save(selected_crop)

    crossed.draw(selected_crop,     # input
                 path,                   # output
                 2,                      # nibsize (line size in output svg)
                 color,                  # line color
                 0.32,                   # scaling factor
                 l1, l2, l3, l4,         # levels
                 2,                      # type
                 500, 975, 0.3            # signature transform
                 )


def classic_pen_a3_landscape(image_path, path, color):
    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((1000, 572), Image.ANTIALIAS)
    im.save(selected_crop)

    crossed.draw(selected_crop,     # input
                 path,                   # output
                 2,                      # nibsize (line size in output svg)
                 color,                  # line color
                 0.34,                   # scaling factor
                 l1, l2, l3, l4,         # levels
                 2,                      # type
                 830, 550, 0.3            # signature transform
                 )


def spiral_pen_a3_portrait(image_path, path, color):
    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((668, 1000), Image.ANTIALIAS)
    im.save(selected_crop)

    spiral.draw(selected_crop,         # input
                path,                      # output
                2,                         # nibsize (line size in output svg)
                color,                     # line color
                0.32,                      # scaling factor
                l1, l2, l3, l4,            # levels
                2,                         # line spacing
                500, 975, 0.3               # signature transform
                )


def spiral_pen_a3_landscape(image_path, path, color):
    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((1000, 572), Image.ANTIALIAS)
    im.save(selected_crop)

    spiral.draw(selected_crop,         # input
                path,                      # output
                2,                         # nibsize (line size in output svg)
                color,                     # line color
                0.34,                      # scaling factor
                l1, l2, l3, l4,            # levels
                2,                         # line spacing
                830, 550, 0.3               # signature transform
                )


def sketchy_pen_a3_portrait(image_path, path, color):

    im = Image.open(image_path)
    im = im.resize((668, 1000), Image.ANTIALIAS)
    im.save(image_path)

    sketchy.draw(image_path,            # input
                 path,                   # outputsketchy_pen_a3
                 2,                      # nibsize (line size in output svg)
                 100,                    # max line length
                 color,                  # line color
                 0.32,                   # scaling factor
                 # line size (internal line size for calculations)
                 1,
                 500, 975, 0.3           # signature transform
                 )


def sketchy_pen_a3_landscape(image_path, path, color):

    im = Image.open(image_path)
    im = im.resize((1000, 572), Image.ANTIALIAS)
    im.save(image_path)

    sketchy.draw(image_path,            # input
                 path,                   # outputsketchy_pen_a3
                 2,                      # nibsize (line size in output svg)
                 100,                    # max line length
                 color,                  # line color
                 0.34,                   # scaling factor
                 # line size (internal line size for calculations)
                 1,
                 830, 550, 0.3           # signature transform
                 )


def classic_pen_a3(image_path, path, color):
    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((1000, 1000), Image.ANTIALIAS)
    im.save(selected_crop)

    crossed.draw(selected_crop,     # input
                 path,                   # output
                 3,                      # nibsize (line size in output svg)
                 color,                  # line color
                 0.21,                   # scaling factor
                 l1, l2, l3, l4,         # levels
                 1,                      # type
                 730, 970, 0.5          # signature transform
                 )


def spiral_pen_a3(image_path, path, color):
    l1, l2, l3, l4 = levels_by_preview_name(image_path)
    selected_crop = crop_by_preview_name(image_path)

    im = Image.open(selected_crop)
    im = im.resize((1000, 1000), Image.ANTIALIAS)
    im.save(selected_crop)

    spiral.draw(selected_crop,         # input
                path,                      # output
                3,                         # nibsize (line size in output svg)
                color,                     # line color
                0.21,                      # scaling factor
                l1, l2, l3, l4,            # levels
                2,                         # line spacing
                730, 970, 0.5               # signature transform
                )


def sketchy_pen_a3(image_path, path, color):

    im = Image.open(image_path)
    im = im.resize((1000, 1000), Image.ANTIALIAS)
    im.save(image_path)

    sketchy.draw(image_path,            # input
                 path,                   # output
                 3,                      # nibsize (line size in output svg)
                 100,                    # max line length
                 color,                  # line color
                 0.21,                   # scaling factor
                 # line size (internal line size for calculations)
                 1,
                 730, 970, 0.5          # signature transform
                 )


sketchy_pen_a3("base.png", "render.svg", "#ff0000")
spiral_pen_a3("base.png", "base.svg", "#ff0000")
classic_pen_a3("base.png", "tini3.svg", "#ff0000")

sketchy_pen_a3_landscape("base.png", "tini4.svg", "#ff0000")
spiral_pen_a3_landscape("base.png", "tini5.svg", "#ff0000")
classic_pen_a3_landscape("base.png", "tini6.svg", "#ff0000")

sketchy_pen_a3_portrait("base.png", "tini7.svg", "#ff0000")
spiral_pen_a3_portrait("base.png", "tini8.svg", "#ff0000")
classic_pen_a3_portrait("base.png", "tini9.svg", "#ff0000")

sketchy_extra_large("base.png", "render0.svg", "#ff00ff")
spiral_extra_large("base.png", "render1.svg", "#ff00ff")
classic_extra_large("base.png", "render2.svg", "#ff00ff")

sketchy_large("base.png", "render3.svg", "#ff0000")
spiral_large("base.png", "render4.svg", "#ff0000")
classic_large("base.png", "render5.svg", "#ff0000")

sketchy_small("base.png", "render6.svg", "#ffff00")
spiral_small("base.png", "render7.svg", "#ffff00")
classic_small("base.png", "render8.svg", "#ffff00")
