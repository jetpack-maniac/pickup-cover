// this project is a printable cover for guitar pickups
// this comes with default options set to a typical 6 string humbucker

coverLength = 70; // pickups are about 68.4mm long, this is a tad wider to fit
coverWidth = 38; // pickups are 36.5 wide
coverHeight = 20; // pickups are about 27.3 tall from the lowest point, they don't need to be that tall to cover them
coverThickness = 1; // this is the thickness of each side
roundness = 2; // this is degree of roundness the corners get

tabLength = 84.2; // total distance from edge to edge of mounting tabs, this is the widest point of the cover
tabWidth = 12.7;

faces = 20; // the number of faces increases the detail on rounded portions

polePieceTopHoles = 6; // if you want holes for your pole pieces set this to your string count
polePieceTopSize = 5; // hole in mm
polePieceTopAlignment = 9.25; // distance from the TOP of the cover to the top edge of the top pole pieces
polePieceTopSpacing = 58.674; // total distance between ALL pieces

polePieceBottomHoles = 6;
polePieceBottomSize = 5;
polePieceBottomAlignment = 9.25; // distance from BOTTOM of the cover to the bottom edge of the bottom pole pieces
polePieceBottomSpacing = 58.674;

// Mounting tab 'types'
// cut creates a cutaway on the side for existing tabs
// tab creates the side structure
// block extends the sides of the cover with screw holes, most similar to some 7 string covers
mountingTab = "cut";

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

module mountingTabConstructor(type){


}

module polePiecePunch(){
  // this cuts the holes where the pole pieces belong
  if(polePieceTopHoles > 0){
    for(hole = [1:polePieceTopHoles]){
      translate([polePieceTopSpacing*(hole/polePieceTopHoles), coverWidth - (polePieceTopAlignment + edge), coverHeight - coverThickness - edge])
        cylinder(d = polePieceTopSize, h = coverThickness + edge, $fn = faces);
    }
  }

  if(polePieceBottomHoles > 0){
    for(hole = [1:polePieceBottomHoles]){
      translate([polePieceBottomSpacing*(hole/polePieceBottomHoles), edge + polePieceBottomAlignment, coverHeight - coverThickness - edge])
        cylinder(d = polePieceBottomSize, h = coverThickness + edge, $fn = faces);
    }
  }
}

difference(){
  coverBase();
  mainBodyCut();
  polePiecePunch();
  if(mountingTab == "cut"){mountingTabConstructor(mountingTab);}
}
