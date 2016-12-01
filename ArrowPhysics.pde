
class Attractor {
    float mass;    // Mass, tied to size
    float G;       // Gravitational Constant
    PVector location;   // Location

        Attractor() {
        location = new PVector(0, 0, 0);
        mass = 20;
        G = 1;
    }

    PVector attract(Mover m) {
        PVector force = PVector.sub(location, m.location);   // direction
        float d = force.mag();                              // distance
        d = constrain(d, 5.0, 13.0);                        // limit
        force.normalize();                                  
        float strength = (G * mass * m.mass) / (d * d);      
        force.mult(strength);                                  
        return force;
    }

    void display() {
        strokeWeight(4);
        noStroke();
        colorMode(RGB);
        fill(255, 100);
        rect(-75, -75, 150, 150);
    }
}


class Mover {

    float G = 1, sizeStart = random(0.8,1.2), hueStart = random(0,360);
    PVector location;
    PVector velocity;
    PVector acceleration;
    float mass;
    PShape movingArrow;

    Mover(float m, float x, float y, float z) {
        mass = m;
        location = new PVector(x, y, z);
        velocity = new PVector(random(-2, 2), random(-2, 2), random(-2, 2));
        acceleration = new PVector(0, 0, 0);
        movingArrow = createShape(GROUP);
        movingArrow.addChild(arrowShape(2, 20));
    }

    void applyForce(PVector force) {
        PVector f = PVector.div(force, mass);
        acceleration.add(f);
    }

    void update() {
        velocity.add(acceleration);
        location.add(velocity);
        acceleration.mult(0);
    }

    void getRotation() {
        PVector new_dir = new PVector(velocity.x, velocity.y, velocity.z);
        new_dir.normalize();
        PVector new_up = new PVector(0.0, 0.0, 1.0);
        new_up.normalize();
        PVector crossP = velocity.cross(new_up);
        crossP.normalize();

        float dotP = new_dir.dot(new_up);
        float angle = PVector.angleBetween(new_up, new_dir); 
        rotate(-angle, crossP.x, crossP.y, crossP.z); 

        //Quaternion Q  = new Quaternion(cos(angle / 2.0), crossP.scale(sin(angle / 2.0)));
    }

    void display(int id) {
        stroke(0);
        strokeWeight(2);
        fill(0, 100);
        pushMatrix();
        {
            translate(location.x, location.y, location.z);
            movingArrow.setFill(color(160, 160, 160));
            switch(id) {
            case 4:
                hueShift = map(location.z, 0, 300, 0, 360);
                break;

            case 5:
                sizeScale = map(location.z, 0, 300, 0.5, 5);
                break;

            case 6:
                mass = map(location.z, 0, 300, 20, 0.1);
                break;
            }
            colorMode(HSB, 360, 100, 100);
            movingArrow.setFill(color((hueStart+hueShift)%360, 100, 100));
            if (location.z<0) {
                ellipseMode(CENTER);
                stroke(0);
                noFill();
                strokeWeight(5);
                pushMatrix();
                translate(0, 0, -location.z);
                ellipse(0, 0, 7, 7);
                popMatrix();
                location.x = random(-boundingRadius, boundingRadius);
                location.y = random(-boundingRadius, boundingRadius);
                location.z = 300;
                velocity.x = random(-2, 2);
                velocity.y = random(-2, 2);
                velocity.z = random(-2, 2);
            }

            getRotation();
            scale(sizeScale * sizeStart);
            shape(movingArrow);
        }
        popMatrix();
    }
}


class Arrow {
    PVector loc, velocity, acceleration;
    /*
    void Sphere() {
     loc = getPosition();
     }
     
     PVector getPosition() {
     PVector p = getRandom();
     PVector origin = new PVector(0, 0, 0);
     while (p.y < 200) p = getRandom();
     return p;
     }*/
}


PShape arrowShape(float r, float h) {
    PShape s, s0, s1, s2, s3;
    s = createShape(GROUP);

    s0 = createShape();
    s0.beginShape(QUAD_STRIP);
    s0.vertex(r, 0, 0);
    s0.vertex(r, 0, 0.5*h);
    s0.vertex(0, r, 0);
    s0.vertex(0, r, 0.5*h);
    s0.vertex(-r, 0, 0);
    s0.vertex(-r, 0, 0.5*h);
    s0.vertex(0, -r, 0);
    s0.vertex(0, -r, 0.5*h);
    s0.vertex(r, 0, 0);
    s0.vertex(r, 0, 0.5*h);
    s0.endShape(CLOSE);

    s1 = createShape();
    s1.beginShape(TRIANGLE_FAN);
    s1.vertex(0, 0, 0.5*h);
    s1.vertex(2*r, 0, 0.5*h);
    s1.vertex(0, 2*r, 0.5*h);
    s1.vertex(-2*r, 0, 0.5*h);
    s1.vertex(0, -2*r, 0.5*h);
    s1.vertex(2*r, 0, 0.5*h);
    s1.endShape(CLOSE);

    s2 = createShape();
    s2.beginShape(TRIANGLE_FAN);
    s2.vertex(0, 0, h);
    s2.vertex(2*r, 0, 0.5*h);
    s2.vertex(0, 2*r, 0.5*h);
    s2.vertex(-2*r, 0, 0.5*h);
    s2.vertex(0, -2*r, 0.5*h);
    s2.vertex(2*r, 0, 0.5*h);
    s2.endShape(CLOSE);

    s3 = createShape();
    s3.beginShape();
    s3.vertex(r, 0, 0);
    s3.vertex(0, r, 0);
    s3.vertex(-r, 0, 0);
    s3.vertex(0, -r, 0);
    s3.endShape(CLOSE);

    s.addChild(s0);
    s.addChild(s1);
    s.addChild(s2);
    s.addChild(s3);

    s.setStroke(false);
    return s;
}

