void trigger(int id) {
    switch (id) {

    case 0: //home
        {
            if (movieDetected) {
                movieDetected = false;
                movieChoice = id;
            }
        }
        break;

    case 1: //A text wireframe
        {
            if (!movieDetected) {
                movieDetected = true;
                movieChoice = id;
            }
            nya.beginTransform(id);
            {
                pushMatrix();
                {
                    //lights();
                    rotateX(radians(90));
                    shape(wireframe);
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 2: //B text solid
        {
            if (!movieDetected) {
                movieDetected = true;
                movieChoice = id;
            }
            nya.beginTransform(id);
            {
                fill(0);
                noStroke();
                rect(-75, -75, 150, 150);
                pushMatrix();
                {
                    //lights();
                    rotateX(radians(90));
                    wireframe.setStrokeWeight(2);

                    shape(wireframe);
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 3: //C text fancy
        {
            if (!movieDetected) {
                movieDetected = true;
                movieChoice = id;
            }
            nya.beginTransform(id);
            {
                pushMatrix();
                {
                    //lights();
                    rotateX(radians(90));
                    shape(wireframe);
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 4: //AB arrow1 
        {
            nya.beginTransform(id);
            {
                pushMatrix();
                {

                    a.display();

                    for (int i = 0; i < movers.length; i++) {
                        PVector force = a.attract(movers[i]);
                        movers[i].applyForce(force);

                        movers[i].update();
                        movers[i].display(id);
                    }
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 5: //BC arrow2
        {
            nya.beginTransform(id);
            {
                pushMatrix();
                {

                    a.display();

                    for (int i = 0; i < movers.length; i++) {
                        PVector force = a.attract(movers[i]);
                        movers[i].applyForce(force);

                        movers[i].update();
                        movers[i].display(id);
                    }
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 6: //CA arrow3
        {
            nya.beginTransform(id);
            {
                pushMatrix();
                {

                    a.display();

                    for (int i = 0; i < movers.length; i++) {
                        PVector force = a.attract(movers[i]);
                        movers[i].applyForce(force);

                        movers[i].update();
                        movers[i].display(id);
                    }
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 7: //ABC Ikea
        {
            nya.beginTransform(id);
            {    
                pushMatrix();
                {
                    imageMode(CENTER);
                    switch(movieChoice%3) {
                    case 0:
                        marilyn.read();
                        marilyn.play();
                        marilynPlayed = true;
                        marilyn.loop();
                        image(marilyn, 0, 0, width/3, -height/3);
                        if (marilyn.time()>=17) {
                            movieChoice++;
                            marilyn.stop();
                        }
                        break;
                    case 1:
                        ikea.read();
                        ikea.play();
                        ikeaPlayed = true;
                        ikea.loop();
                        image(ikea, 0, 0, width/3, -height/3);
                        if (ikea.time()>=82) {
                            movieChoice++;
                            ikea.stop();
                        }
                        break;
                    case 2:
                        stamp.read();
                        stamp.play();
                        stampPlayed = true;
                        stamp.loop();
                        image(stamp, 0, 0, width/3, -height/3);
                        if (stamp.time()>=22) {
                            movieChoice++;
                            stamp.stop();
                        }
                        break;
                    default:
                        movieChoice = 1;
                        break;
                    }
                }
                popMatrix();
            }
            nya.endTransform();
            imageMode(CORNER);
        }
        break;

    case 8: //D or E or F sensorama
        {
            nya.beginTransform(id);
            {    
                pushMatrix();
                {
                    imageMode(CENTER);
                    sensorama.read();
                    sensorama.play();
                    sensoramaPlayed = true;
                    sensorama.loop();
                    image(sensorama, 0, 0, width/3, -height/3);
                }
                popMatrix();
            }
            nya.endTransform();
            imageMode(CORNER);
        }
        break;

    case 9: //D or E or F sensorama
        {
            nya.beginTransform(id);
            {    
                pushMatrix();
                {
                    imageMode(CENTER);
                    sensorama.read();
                    sensorama.play();
                    sensoramaPlayed = true;
                    sensorama.loop();
                    image(sensorama, 0, 0, width/3, -height/3);
                }
                popMatrix();
            }
            nya.endTransform();
            imageMode(CORNER);
        }
        break;

    case 10: //D or E or F sensorama
        {
            nya.beginTransform(id);
            {    
                pushMatrix();
                {
                    imageMode(CENTER);
                    sensorama.read();
                    sensorama.play();
                    sensoramaPlayed = true;
                    sensorama.loop();
                    image(sensorama, 0, 0, width/3, -height/3);
                }
                popMatrix();
            }
            nya.endTransform();
            imageMode(CORNER);
        }
        break;

    case 11: //DE or EF or FD sutherland
        {
            imageMode(CORNERS);
            sutherlandHMD.read();
            sutherlandHMD.play();
            sutherlandPlayed = true;
            sutherlandHMD.loop();
            pushMatrix();
            translate(0, 0, 2);

            image(sutherlandHMD, 0.78*width, 0.65*height, 0.961*width, 0.885*height);
            popMatrix();
            nya.beginTransform(id);
            {    
                pushMatrix();
                {
                    drawRoom();
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 12: //DE or EF or FD sutherland
        {
            imageMode(CORNERS);
            sutherlandHMD.read();
            sutherlandHMD.play();
            sutherlandPlayed = true;
            sutherlandHMD.loop();
            image(sutherlandHMD, 2022, 944, 2460, 1274);
            nya.beginTransform(id);
            {    
                pushMatrix();
                {
                    drawRoom();
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 13: //DE or EF or FD sutherland
        {
            imageMode(CORNERS);
            sutherlandHMD.read();
            sutherlandHMD.play();
            sutherlandPlayed = true;
            sutherlandHMD.loop();
            image(sutherlandHMD, 2022, 944, 2460, 1274);
            nya.beginTransform(id);
            {    
                pushMatrix();
                {
                    drawRoom();
                }
                popMatrix();
            }
            nya.endTransform();
        }
        break;

    case 14: //credits
        {
            pushMatrix();
            {      
                shininess(0.2);
                translate(0.8*width, 0.5*height, 80);
                pointLight(220, 220, 220, 0, 20, 50);
                ambientLight(255, 255, 255); 
                directionalLight(150, 140, 145, 0, 0, -1);

                rotateY(radians(10*frameCount));
                pointLight(0, 0, 200, -20, 0.05*height, 15);
                pointLight(200, 0, 0, 0, 0.05*height, -20);
                pointLight(0, 200, 0, 20, 0.05*height, 15);                
                rotateY(-radians(10*frameCount));
                scale(10);

                rotateX(radians(90));
                rotateZ(radians(1*frameCount));
                shape(panda);

                translate(0, 0, -0.03*height);
                rotateZ(-radians(2*frameCount));
                shape(scott);

                scale(0.05);
            }
            popMatrix();
            nya.beginTransform(id);
            {
            }
            nya.endTransform();
        }
        break;
    }
}


void drawRoom() {

    fill(0, 0, 0, 80);
    noStroke();
    rect(5000, -5000, width, height);
    pushMatrix();
    {
        strokeWeight(2);
        scale(0.1);
        fill(0, 80);
        rect(-750, -750, 1500, 1500);
        translate(0, 0, 750);
        rotateY(radians(180));
        shapeMode(CENTER);

        pushMatrix();
        {
            translate(500, 500, 0);
            shape(box);
        }
        popMatrix();

        pushMatrix();
        {
            translate(0, -500, 0);
            rotateX(radians(90));
            shape(wall, 0, 0);
            translate(0, 0, -50);
            rotateY(radians(180));
            shape(north, 0, 0);
        }
        popMatrix();

        pushMatrix();
        {
            translate(-500, 0, 0);
            rotateY(radians(90));
            rotateZ(radians(-90));
            shape(wall, 0, 0);
            translate(0, 0, 50);
            rotateY(radians(180));
            shape(east, 0, 0);
        }
        popMatrix();

        pushMatrix();
        {
            translate(500, 0, 0);
            rotateY(radians(-90));
            rotateZ(radians(90));
            translate(0, -160, 0);
            scale(1, 1.4, 1);
            rotateZ(radians(180));
            shape(wall, 0, 0);
            scale(1, 0.71428571428571428571428571428571, 1);
            translate(0, -160, 50);
            rotateY(radians(180));
            //rotateZ(radians(180));
            shape(west, 0, 0);
        }
        popMatrix();

        pushMatrix();
        {
            translate(0, 500, 0);
            rotateX(radians(-90));
            shape(wall, 0, 0);
            translate(0, 0, -50);
            rotateY(radians(180));
            shape(south, 0, 0);
        }
        popMatrix();

        pushMatrix();
        {
            translate(0, -300, 500);
            //rotateY(radians(180));
            rotateY(radians(180));
            shape(floor, 0, 0);
        }
        popMatrix();

        pushMatrix();
        {
            translate(0, -300, -500);
            rotateY(radians(180));
            rotateY(radians(180));
            shape(ceiling, 0, 0);
        }
        popMatrix();

        shapeMode(CORNER);
    }
    popMatrix();
}

