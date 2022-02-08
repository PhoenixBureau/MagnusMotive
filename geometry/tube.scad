
module tube(height, radius, thickness) {
    half_thickness = thickness / 2;

    // Main hollow tube column.
    difference() {
        cylinder(h=height, r=radius + half_thickness, $fn=60);
        translate([0, 0, -1])
        cylinder(h=height+2, r=radius - half_thickness, $fn=60);
    }

}

module tubular(rank, off, h, r, th) {
    if (rank <= 0) {
        tube(h, r, th);
    } else {
        subrank = rank - 1;
        dist = 2^subrank * off;
        tubular(subrank, off, h, r, th);
        translate([dist, 0, 0])
            tubular(subrank, off, h, r, th);
        translate([dist * cos(60), dist * sin(60), 0])
            tubular(subrank, off, h, r, th);
    }
}

height = 30;
radius = 7;
thickness = 1;
separation_dist = radius * 2 + thickness;
tubular(4, separation_dist, height, radius, thickness);


