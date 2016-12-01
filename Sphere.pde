
class Sphere {
    PVector loc;
    float radius, growRate, rad;
    boolean isOverlap, addedToPShape;
    color c;

    Sphere() {
        loc = getPosition();
        growRate = random(0.2, 2);
        //c = getColor(loc);
        if (isInMesh(loc)) {
            c = color(255, 0, 0);
        } else {
            c = color(255);
        }
        rad = random(0.1, 8);
    }

    // keep trying until we get a position within the text mesh
    PVector getPosition() {
        PVector p = getRandomVector();
        while (p.y>max.y) p = getRandomVector();
        return p;
    }

    PVector getRandomVector() {
        /*float x = random(min.x, max.x);
         float y = random(min.y, max.y);
         float z = random(min.z, max.z);*/
        float x = map(noise(noiseX), 0, 1, min.x-1*max.x, 2*max.x);
        float y = map(noise(noiseY), 0, 1, min.y-2*max.y+(max.y+min.y)/2, 3*max.y)+(max.y+min.y)/2;
        float z = map(noise(noiseZ), 0, 1, min.z-4*max.z, 5*max.z);
        noiseX += 0.3;
        noiseY += 0.2;
        noiseZ += 0.5;
        return new PVector(x, y, z);
    }

    boolean isInMesh(PVector p) {
        return mesh.contains(new WB_Point(p.x, p.y, p.z), false);
    }

    // get color where the hue is based on the relative xy-position and the brightness on the relative z-position
    color getColor(PVector p) {
        colorMode(HSB, 1);
        float rPos = map(loc.x, min.x, max.x, 0, 1) + map(loc.y, min.y, max.y, 0, 1);
        color col = color(rPos%1, 1, map(loc.z, min.z, max.z, 0.15, 1));
        colorMode(RGB, 255);
        if (isInMesh(p)) return color(255, 0, 0);
        else return color(255, 100);
    }

    void update() {
        // if not yet addded to PShape
        if (!addedToPShape) {
            // if not overlapping with other spheres
            if (!isOverlap) {
                radius += growRate; // grow
                isOverlap = overlap(); // check if overlapping with other Spheres
            } else {
                // once it's overlapping, add to PShape and set boolean accordingly
                addToPShape();
                addedToPShape = true;
            }
        }
    }

    // check (future) overlap with other spheres based on locations, radii and growth rate
    boolean overlap() {
        for (Sphere s : spheres) {
            if (s != this) {
                if ((loc.dist(s.loc) <= s.radius + radius + growRate) || (radius>rad)) {
                    return true;
                }
            }
        }
        return false;
    }

    // display in immediate mode until it's added to PShape
    void display() {
        if (!addedToPShape) {
            pushMatrix();
            translate(loc.x, loc.y, loc.z);
            if (!isInMesh(loc)) {
                noFill();
                stroke(c);
            } else {
                noStroke();
                fill(c);
            }
            sphere(radius);
            popMatrix();
        }
    }

    // add (visually identical) sphere to the container PShape for quick display on the GPU
    void addToPShape() {
        PShape sphere = createShape(SPHERE, radius);
        sphere.translate(loc.x, loc.y, loc.z);
        if (!isInMesh(loc)) {
            sphere.setStroke(c);
            sphere.setFill(false);
        } else {
            sphere.setFill(c);
            sphere.setStroke(false);
        }
        /*sphere.setFill(c);
         sphere.setStroke(false);*/
        grownSpheres.addChild(sphere);
    }
}

