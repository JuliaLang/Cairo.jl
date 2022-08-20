## header to provide surface and context
using Cairo
c = CairoARGBSurface(256,256);
cr = CairoContext(c);

save(cr);
set_source_rgba(cr,0.0,0.0,0.0,0.0); # transparent black
rectangle(cr,0.0,0.0,256.0,256.0); # background
fill(cr);
restore(cr);
save(cr);

## paint the following to a Recording Surface
s1 = CairoRecordingSurface()
c1 = CairoContext(s1)

move_to(c1, 128.0, 25.6);
line_to(c1, 230.4, 230.4);
rel_line_to(c1, -102.4, 0.0);
curve_to(c1, 51.2, 230.4, 51.2, 128.0, 128.0, 128.0);
close_path(c1);

move_to(c1, 64.0, 25.6);
rel_line_to(c1, 51.2, 51.2);
rel_line_to(c1, -51.2, 51.2);
rel_line_to(c1, -51.2, -51.2);
close_path(c1);

set_line_width(c1, 10.0);
set_source_rgb(c1, 0, 0, 1);
fill_preserve(c1);
set_source_rgb(c1, 0, 0, 0);
stroke(c1);

## find ink extents and mark with a rectangle
x0, y0, width, height = recording_surface_ink_extents(s1);
rectangle(c1, x0, y0, width, height)
stroke(c1);

## play back on transform coord
scale(cr,0.5,0.5)
set_source(cr, s1, 128.0, 128.0)

paint(cr)


## mark picture with current date
restore(cr);
move_to(cr,0.0,12.0);
set_source_rgb(cr, 0,0,0);
show_text(cr,Libc.strftime(time()));
write_to_png(c,"sample_record_inkextents.png");

