
module tube(height, radius, thickness) {
    half_thickness = thickness / 2;
    
    // Main hollow tube column.
    difference() {
        cylinder(h=height, r=radius + half_thickness, $fn=60);
        translate([0, 0, -1])
        cylinder(h=height+2, r=radius - half_thickness, $fn=60);
    }

}

module t0() tube(30, 7, 1);

X0 = 15;

module t1() {
    t0();
    translate([X0, 0, 0]) t0();
    translate([X0 * cos(60), X0*sin(60), 0]) t0();
}

X1 = X0 + X0;
module t2() {
    t1();
    translate([X1, 0, 0]) t1();
    translate([X1 * cos(60), X1*sin(60), 0]) t1();
}

X2 = X1 + X1;
module t3() {
    t2();
//    translate([X2, 0, 0]) t2();
    translate([X2 * cos(60), X2*sin(60), 0]) t2();
}

t3();
translate([X2, 0, 0]) t3();