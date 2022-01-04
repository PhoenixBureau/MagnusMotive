L = 200;
a = 360 / 72; // Radial angle.
b = 360 / 120; // Radial angle.
r = 3;


module bubble_ring(a, r, l) {
    k = 20;
    for(t = [0:a:359]) {
      hull() {
        translate([l * cos(t), 0, l * sin(t)])
        rotate([0, 90-t, 0])
        sphere(r);
        translate([(k + l) * cos(t), 0, (k + l) * sin(t)])
        rotate([0, 90-t, 0])
        sphere(r * 2);
      }
    }
}


angle = 360 * r / L * 2 * 3.1415927;



for (n=[0:35]) {
    translate([0, n * sin(60) * 2 * a, 0])
    rotate([0, n * a / 2, 0])
    bubble_ring(a, r, L);
}
bubble_ring(a, r, L);