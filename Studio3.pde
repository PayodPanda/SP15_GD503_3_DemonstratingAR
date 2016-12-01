

// for AR recog
import processing.video.*;           
import jp.nyatla.nyar4psg.*;

MultiMarker nya;                        // multi marker object
int arWidth = 1920, // basic settings - width and height (of video capture)
arHeight = 1080;
float cameraZ; //for perspective


// to make videos work - capture + play video
import processing.video.*;
Capture cam;                            // capture object to fetch video feed
PImage camAR;                         // to save captured video to off screen buffer for image manipulation to improve recognition by AR library


// for text:
import geomerative.*;              // to convert text to 2D shape
import wblut.hemesh.*;             // to extrude above mesh to 3D
import wblut.geom.*;               // see above

int c=0;                                // what the hell is this?
PShape wireframe, solid, fancy;                // PShapes to hold wireframe / solid text meshes
RFont font;                        
PShape textShape;                      //text bounding shape  ************************************************************************************* find a better name for this please
HE_Mesh mesh;                

WB_AABB boundingBox;               // bounding box of text
PVector min, max;                  // bounding box vectors
ArrayList <Sphere> spheres;        
PShape grownSpheres;                      // PShape to hold the grown Spheres
String input = "AR";             
int numSpheres = 3500;             // max Spheres
int addSpeed = 5;                  // number of Spheres that is added per frame
float noiseX, noiseY, noiseZ;      // noise update parameters


// for arrows
float sizeScale = 1, hueShift = 0;

float boundingRadius = 200;

Mover[] movers = new Mover[10];

Attractor a;

// Current AR
Movie ikea, stamp, marilyn;   
int movieChoice;
boolean movieDetected = false;


// Before AR
Movie sensorama;
PImage masterKey, sensoramaDiagram;


// Sutherland
PShape wall, ceiling, floor, north, east, west, south, box;                                // PShapes for Sutherland's room
Movie sutherlandHMD;
PImage sutherlandMagazine;


boolean sensoramaPlayed = false;
boolean sutherlandPlayed = false;
boolean ikeaPlayed = false;
boolean stampPlayed = false;
boolean marilynPlayed = false;

// credits
PShape panda, scott;                                // PShapes for our busts
PImage layar, blippar, aurasma;


// body copy
PImage[] bodyText = new PImage[15];

void setup() {
    size(1280, 720, P3D);
    frameRate(30);
    smooth(16);
    cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
    //perspective(PI/3.0, width/height, cameraZ/1.0, cameraZ*100.0); 

    String[] cameras = Capture.list();                                        // just to see which camera settings available
    for (int i=0; i<cameras.length; i++) {                                    // check in the console window
        println(cameras[i]);
    }

    cam = new Capture(this, arWidth, arHeight, "Logitech HD Pro Webcam C920", 30);
    camAR = createImage(cam.width, cam.height, RGB);                          // basically to copy cam pixels to to manipulate them for better image feature detection

    //frame.setResizable(true);                                                 // so for some reason the video capture can only be initiated at the canvas window 
    //frame.setSize(2560, 1440);                               // dimensions. Workaround to capture low res video and scale it up to fill screen.  /self pat on back                 


    nya = new MultiMarker(this, arWidth, arHeight, "camera_para.dat", new NyAR4PsgConfig(NyAR4PsgConfig.CS_LEFT_HAND, NyAR4PsgConfig.TM_NYARTK));                        // create new MultiMarker object
    //nya.setARClipping(10, 100);        

    // PNGs
    nya.addARMarker(loadImage("Patterns/Nothing.png"), 64, 10, 150); //0
    nya.addARMarker(loadImage("Patterns/A.png"), 64, 10, 150); //1
    nya.addARMarker(loadImage("Patterns/B.png"), 64, 10, 150); //2
    nya.addARMarker(loadImage("Patterns/C.png"), 64, 10, 150); //3
    nya.addARMarker(loadImage("Patterns/AB.png"), 64, 10, 150); //4
    nya.addARMarker(loadImage("Patterns/BC.png"), 64, 10, 150); //5
    nya.addARMarker(loadImage("Patterns/CA.png"), 64, 10, 150); //6
    nya.addARMarker(loadImage("Patterns/ABC.png"), 64, 10, 150); //7
    nya.addARMarker(loadImage("Patterns/D.png"), 64, 10, 150); //8
    nya.addARMarker(loadImage("Patterns/E.png"), 64, 10, 150); //9
    nya.addARMarker(loadImage("Patterns/F.png"), 64, 10, 150); //10
    nya.addARMarker(loadImage("Patterns/DE.png"), 64, 10, 150); //11
    nya.addARMarker(loadImage("Patterns/EF.png"), 64, 10, 150); //12
    nya.addARMarker(loadImage("Patterns/FD.png"), 64, 10, 150); //13
    nya.addARMarker(loadImage("Patterns/DEF.png"), 64, 10, 150); //14

    nya.setConfidenceThreshold(0.5); // easier to recognize, at the expense of jittery triggering - keep testing, find optimum. Test in Tech Showcase.


    // text; 2D (geomerative):
    RG.init(this);
    RCommand.setSegmentator(RCommand.UNIFORMSTEP); 
    RCommand.setSegmentStep(1);
    font = new RFont("InputSans-Black.ttf", 100);

    // text; 3D (HE_MESH):
    mesh = createHemesh(input);
    wireframe = createPShape(mesh, false, 1);
    solid = createPShape(mesh, false, 2);
    getBoundaries(); 
    spheres = new ArrayList <Sphere> (); 
    grownSpheres = createShape(GROUP); 

    // body copy
    for (int x = 0; x < 15; x++) {
        bodyText[x] = loadImage("Text/AR_Demo_Content_0429"+ x +".png");
    }


    panda = loadShape("3D/PandaEdited.obj");
    scott = loadShape("3D/ScottEdited.obj");

    ikea = new Movie(this, "Videos/Ikea.mp4");
    marilyn = new Movie(this, "Videos/Marilyn.mp4");
    stamp = new Movie(this, "Videos/StampAR.mp4");
    sensorama = new Movie(this, "Videos/Sensorama.mov");
    sutherlandHMD = new Movie(this, "Videos/SutherlandHMD.mov");
    defineRoom();

    //for arrows

    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover(random(0.1, 2), random(-boundingRadius, boundingRadius), random(-boundingRadius, boundingRadius), random(300));
    }
    a = new Attractor();


    cam.start();
}

void draw() {
    c++;
    if (cam.available() !=true) {
        return;
    }
    background(255);
    cam.read();
    //nya.drawBackground(cam);
    image(cam, 0, 0, width, height);
    nya.detect(cam);

    boolean detect = false;
    for (int x=0; x<=14; x++) {
        if (nya.isExistMarker(x)) {
            fill(0, 100);
            rect(0, 0, width, height);
            println(x);
            println(nya.getConfidence(x));
            detect = true;
            image(bodyText[x], 0, 0, width, height);
            trigger(x);
            if (x!=7) {
                if (ikeaPlayed) ikea.pause();
                if (stampPlayed) stamp.pause();
                if (marilynPlayed) marilyn.pause();
            }
            if ((x!=8)&&(x!=9)&&(x!=10)) {
                if (sensoramaPlayed) sensorama.pause();
            }
            if ((x!=11)&&(x!=12)&&(x!=13)) {
                if (sutherlandPlayed) sutherlandHMD.pause();
            }
        }
    }
    if (!detect) println("nothing");

    println(frameRate);
}



void getBoundaries() {
    boundingBox = mesh.getAABB();
    min = new PVector((float)boundingBox.getMinX(), (float)boundingBox.getMinY(), (float)boundingBox.getMinZ());
    max = new PVector((float)boundingBox.getMaxX(), (float)boundingBox.getMaxY(), (float)boundingBox.getMaxZ());
}

