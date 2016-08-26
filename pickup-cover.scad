// this project is a printable cover for guitar pickups

coverLength = 60;
coverWidth = 30;
coverHeight = 20;
coverThickness = 1; // this is the thickness of each side
roundness = 2; // this is degree of roundness the corners get

faces = 20;

edge = roundness*coverThickness;

module coverBase(){

  // draw the shape out, cut the corners, cut screw holes
  difference(){
      cube([coverLength, coverWidth, coverHeight]);

      // this cuts the corner edges around the sides
      cube([edge, edge, coverHeight]);
      translate([coverLength - edge, 0, 0])
        cube([edge, edge, coverHeight]);
      translate([coverLength - edge, coverWidth - edge, 0])
        cube([edge, edge, coverHeight]);
      translate([0, coverWidth - edge, 0])
        cube([edge, edge,coverHeight]);
      /*screwTapping(); // screws are cut before the corners are filled back in*/

      // this cuts the corner edges around the top
      translate([0, 0, coverHeight - edge])
        cube([coverLength, edge, edge]);
      translate([0, coverWidth - edge, coverHeight - edge])
        cube([coverLength, edge, edge]);
      translate([0, 0, coverHeight - edge])
        cube([edge, coverWidth, edge]);
      translate([coverLength - edge, 0, coverHeight - edge])
        cube([edge, coverWidth, edge]);
    }

    // replace the cut side corners with rounded edges
    translate([edge, edge, 0])
      cylinder(r = edge, coverHeight - edge, $fn = faces);
    translate([coverLength - edge, edge, 0])
      cylinder(r = edge, coverHeight - edge, $fn = faces);
    translate([edge, coverWidth-edge, 0])
      cylinder(r = edge, coverHeight - edge, $fn = faces);
    translate([coverLength - edge, coverWidth - edge, 0])
      cylinder(r = edge, coverHeight - edge, $fn = faces);

    // replace the cut top corners with rounded edges
    translate([edge, edge, coverHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([coverLength - edge, edge, coverHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([edge, coverWidth-edge, coverHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([coverLength - edge, coverWidth - edge, coverHeight - edge])
      sphere(r = edge, $fn = faces);

    // this lays the long curved edges, starts with origin going CCW
    translate([edge, edge, coverHeight - edge])
    rotate([0,90,0])
      cylinder(r = edge, coverLength - 2*edge, $fn = faces);
    translate([coverLength - edge, edge, coverHeight - edge])
    rotate([270,0,0])
      cylinder(r = edge, coverWidth - 2*edge, $fn = faces);
    translate([coverLength - edge, coverWidth - edge, coverHeight - edge])
    rotate([0,270,0])
      cylinder(r = edge, coverLength - 2*edge, $fn = faces);
    translate([edge, coverWidth-edge, coverHeight - edge])
    rotate([90,0,0])
      cylinder(r = edge, coverWidth - 2*edge, $fn = faces);

}

module mainBodyCut(){

  // cuts the interior open
  translate([coverThickness, coverThickness, 0])
    cube([coverLength - 2*coverThickness, coverWidth - 2*coverThickness, coverHeight - 2*coverThickness]);
}

difference(){
  coverBase();
  mainBodyCut();
}
