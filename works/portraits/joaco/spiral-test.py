from blackstripes import spiral

spiral.draw("placeholder.png",   # input
            "render_spiral.svg",           # output
            0.5,                       # nibsize (line size in output svg)
            "#000000",                  # line color
            0.32,                       # scaling factor
            180, 108, 180, 108,         # levels
            2,                          # linespacing
            540, 1021, 0.7                # signature transform
            )
