
offset = 78;
y_fudge = 10;
N = 5;

//for(
//    x = [-offset*N : offset             : offset*N],
//    y = [-offset*N : 2*(offset-y_fudge) : offset*N]
//){
//    translate([x, y, 0]) cell();
//    translate([x-40, y + offset-y_fudge, 0]) cell();
//}


module strut(r, a, n){
    translate([r,0,0])
    rotate([a,0,0])
    cylinder(h = n, r = n/100, center = true, $fn=4);
}

module struts(r, a, n){
    strut(r, a, n);
    rotate(120, [0, 0, 1]) strut(r, a, n);
    rotate(240, [0, 0, 1]) strut(r, a, n);
}

module sail(r, a, n, z, t){
    rotate(r, [0, 0, 1])
    translate([
        -t / 2, -t * sqrt(3) / 6, // Centered.
        z * n / 2 * cos(a) // Raised/lowered.
    ])
    linear_extrude(height=1, center=true)
    // Equilateral triangle of side length t.
    polygon([[0,0], [t, 0], [t * cos(60), t * sin(60)]]);
}

module sails(r, a, n){
    // These are sail values, should be done by math
    rot_upper = 77;
    rot_lower = 103;
    t = n * sin(a) * .9; // length of side of triangle
    sail(rot_upper, a, n, 1, t);
    sail(rot_lower, a, n, -1, t);
}

module cell(r, a, n){
    color("DarkGreen") struts(r, a, n);
    color("Linen", 0.70) sails(r, a, n);
}


n = 100; // unit strut length
r = 15; // strut distance from center
a = 60; // strut rotation angle
cell(r, a, n);