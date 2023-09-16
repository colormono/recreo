from blackstripes import spiral
from blackstripes import crossed

crossed.draw("placeholder.png",   # input
             "render-crossed.svg",           # output
             # nibsize (line size in output svg)
             0.7,
             "#2200aa",                     # line color
             0.32,                          # scaling factor
             200, 0, 110, 0,                # levels ** just null two invisible layers **
             2,                             # type
             540, 1021, 0.0                   # signature transform
             )

spiral.draw("placeholder.png",                # input
            "render-spiral.svg",         # output
            0.7,                       # nibsize (line size in output svg)
            "#aa0000",                  # line color
            0.32,                       # scaling factor
            180, 108, 180, 108,         # levels
            2,                          # linespacing
            540, 1021, 0.0                # signature transform
            )

spiral.draw("placeholder.png",                # input
            "render-spiral_round.svg",   # output
            0.7,                       # nibsize (line size in output svg)
            "#aa0000",                  # line color
            0.32,                       # scaling factor
            180, 108, 180, 108,         # levels
            2,                          # linespacing
            540, 1021, 0.0,               # signature transform
            1                           # round shaped drawing if True
            )
