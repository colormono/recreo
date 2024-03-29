from blackstripes import crossed

crossed.draw("placeholder.png",                    # input
             "render_crossed.svg",          # output
             0.7,                           # nibsize (line size in output svg)
             "#000000",                     # line color
             0.32,                          # scaling factor
             200, 146, 110, 56,                # levels ** just null two invisible layers **
             1,                             # type
             0, 0, 0.0                      # signature transform
             )

crossed.draw("placeholder.png",                    # input
             "render_crossed-2.svg",          # output
             0.7,                           # nibsize (line size in output svg)
             "#000000",                     # line color
             0.32,                          # scaling factor
             170, 180, 70, 50,                # levels ** just null two invisible layers **
             2,                             # type
             0, 0, 0.0                      # signature transform
             )
