/*  Make an Icosahedron

    Copyright © 2018 Simon Forman

    This file is part of Eumirion

    Eumirion is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Eumirion is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Eumirion.  If not see <http://www.gnu.org/licenses/>.


The twelve verticies of an icosohedron form three Golden Rectangles.

 */


// The Golden Ratio of the long side to the short side is ~= 1.6180339...
phi = (1 + sqrt(5)) / 2;


R = 0.01;  // Very thin rods.


module golden_rectangle(n) {
    // Create a Golden Rectangle with short edge length of n.

    // In order to take the hull() of the rectangles they must actually
    // be very thin blocks.
    translate([0, n/2, 0]) {
        cube([n * R, n * R, n * phi], center=true);
    }
    translate([0, -n/2, 0]) {
        cube([n * R, n * R, n * phi], center=true);
    }
}

module rectangles(n) {
    // Create three Golden Rectangles and orient them into formation.
                        golden_rectangle(n);
    rotate([90, 90, 0]) golden_rectangle(n);
    rotate([90, 0, 90]) golden_rectangle(n);
}

module tri(n) {
    m = n * phi;
    polyhedron(
        points=[
        [n, m, 0],
        [m, 0, n],
        [0, n, m]],
        faces = [[0, 1, 2]]);
}
module foo(n) {tri(n); mirror()        tri(n);}
module bar(n) {foo(n); mirror([0,1,0]) foo(n);}
module baz(n) {bar(n); mirror([0,0,1]) bar(n);}

module icosa(n) {
    rectangles(n);
    %baz(n/2);
}

j = phi * 50;
icosa(100);
translate([j, j, j]) icosa(100);
k = 2 * j;
 translate([k, k, k]) icosa(100);

