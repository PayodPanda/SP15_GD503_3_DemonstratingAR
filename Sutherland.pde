void defineRoom() {
    
    box = createShape();
    box.beginShape();
    box.noFill();
    box.stroke(0, 255, 0);
    box.strokeWeight(2);
    box.vertex(500,500,500);
    box.vertex(500,-500,500);
    box.vertex(-500,-500,500);
    box.vertex(-500,500,500);
    
    box.vertex(-500,500,-500);
    box.vertex(-500,-500,-500);
    box.vertex(-500,-500,500);
    
    box.vertex(-500,-500,-500);
    box.vertex(500,-500,-500);
    box.vertex(500,-500,500);
    
    box.vertex(500,500,500);
    box.vertex(500,500,-500);
    box.vertex(500,-500,-500);
    
    box.vertex(500,500,-500);
    box.vertex(-500,500,-500);
    
    box.vertex(-500,500,500);
    box.vertex(500,500,500);
    box.endShape();
    
    wall = createShape();
    wall.beginShape();
    wall.noFill();
    wall.stroke(0, 255, 0);
    wall.strokeWeight(2);
    wall.vertex(0,0);
    wall.vertex(360,0);
    wall.vertex(360,488);
    wall.vertex(0,488);
    wall.vertex(0,0);
    wall.endShape();

    north = createShape();
    north.beginShape();
    north.noFill();
    north.stroke(0, 255, 0);
    north.strokeWeight(2);
    north.vertex(0, 260);
    north.vertex(0, 0);
    north.vertex(130, 260);
    north.vertex(130, 0);
    north.endShape();

    east = createShape();
    east.beginShape();
    east.noFill();
    east.stroke(0, 255, 0);
    east.strokeWeight(2);
    east.vertex(130, 0);
    east.vertex(0, 0);
    east.vertex(0, 130);
    east.vertex(130, 130);
    east.vertex(0, 130);
    east.vertex(0, 260);
    east.vertex(130, 260);
    east.endShape();

    west = createShape();
    west.beginShape();
    west.noFill();
    west.stroke(0, 255, 0);
    west.strokeWeight(2);
    west.vertex(0, 0);
    west.vertex(44, 260);
    west.vertex(90, 60);
    west.vertex(136, 260);
    west.vertex(180, 0);
    west.endShape();

    south = createShape();
    south.beginShape();
    south.noFill();
    south.stroke(0, 255, 0);
    south.strokeWeight(2);
    south.vertex(130, 0);
    south.vertex(0, 0);
    south.vertex(0, 130);
    south.vertex(130, 130);
    south.vertex(130, 260);
    south.vertex(0, 260);
    south.endShape();

    ceiling = createShape();
    ceiling.beginShape();
    ceiling.noFill();
    ceiling.stroke(0, 255, 0);
    ceiling.strokeWeight(2);
    ceiling.vertex(108, 0);
    ceiling.vertex(0, 0);
    ceiling.vertex(0, 184);
    ceiling.vertex(108, 184);
    ceiling.endShape();

    floor = createShape();
    floor.beginShape();
    floor.noFill();
    floor.stroke(0, 255, 0);
    floor.strokeWeight(2);
    floor.vertex(108, 0);
    floor.vertex(0, 0);
    floor.vertex(0, 92);
    floor.vertex(92, 92);
    floor.vertex(0, 92);
    floor.vertex(0, 184);
    floor.endShape();
}

