from blackstripes import sketchy

sketchy.draw("placeholder.png",   # input
             "render_sketchy.svg",          # output
             1,                          # nibsize (line size in output svg)
             100,                        # max line length
             "#000000",                  # line color
             0.32,                       # scaling factor
             # line size (internal line size for calculations)
             1,
             1000, 1000, 0.7              # signature transform tx, ty, scale
             )
