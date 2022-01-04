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

(One disadvantage of this method is that the result will not have just
twelve verticies due to being formed from very thin blocks.  That can be
corrected in a different program.)

 */


// The Golden Ratio of the long side to the short side is ~= 1.6180339...
phi = (1 + sqrt(5)) / 2;


R = 0.00001;  // Very thin blocks.


module golden_rectangle(n) {
    // Create a Golden Rectangle with short edge length of n.

    // In order to take the hull() of the rectangles they must actually
    // be very thin blocks.
    cube([n, n * phi, n * R], center=true);
}

module rectangles(n) {
    // Create three Golden Rectangles and orient them into formation.
                        golden_rectangle(n);
    rotate([90, 90, 0]) golden_rectangle(n);
    rotate([90, 0, 90]) golden_rectangle(n);
}


// Take the hull() of the rectangles to get an icosahedron.  The short
// edge of the rectangles gives length of the icosohedron's edges.
hull() {
    rectangles(100);
}
// Comment out the hull() call to see just the rectangles.
