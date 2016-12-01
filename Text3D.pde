

HE_Mesh createHemesh(String s) {

    RMesh rmesh = font.toGroup(s).toMesh();
    rmesh.translate(-rmesh.getWidth()/2, rmesh.getHeight()/2); 


    ArrayList <WB_Triangle> triangles = new ArrayList <WB_Triangle> (); 
    ArrayList <WB_Triangle> trianglesFlipped = new ArrayList <WB_Triangle> ();
    RPoint[] pnts;
    WB_Triangle t, tFlipped;
    WB_Point a, b, c;
    // extract the triangles from geomerative's 2D text mesh, then place them
    // as hemesh's 3D WB_Triangle's in their respective lists (normal & flipped)
    for (int i=0; i<rmesh.strips.length; i++) {
        pnts = rmesh.strips[i].getPoints();
        for (int j=2; j<pnts.length; j++) {
            a = new WB_Point(pnts[j-2].x, pnts[j-2].y, 0);
            b = new WB_Point(pnts[j-1].x, pnts[j-1].y, 0);
            c = new WB_Point(pnts[j].x, pnts[j].y, 0);
            if (j % 2 == 0) {
                t = new WB_Triangle(a, b, c);
                tFlipped = new WB_Triangle(c, b, a);
            } else {
                t = new WB_Triangle(c, b, a);
                tFlipped = new WB_Triangle(a, b, c);
            }
            // add the original and the flipped triangle (to close the 3D shape later on) to their respective lists
            triangles.add(t);
            trianglesFlipped.add(tFlipped);
        }
    }

    // create the base 3D HE_Mesh from the triangles of the 2D text shape
    HE_Mesh tmesh = new HE_Mesh(new HEC_FromTriangles().setTriangles(triangles));

    // extrude the base mesh by a certain distance
    tmesh.modify(new HEM_Extrude().setDistance(40));

    tmesh.add(new HE_Mesh(new HEC_FromTriangles().setTriangles(trianglesFlipped)));  
    tmesh.clean();

    return tmesh;
}


PShape createPShape(HE_Mesh mesh, boolean perVertexNormals, int id) {
    mesh.triangulate(); 

    int[][] facesHemesh = mesh.getFacesAsInt();
    float[][] verticesHemesh = mesh.getVerticesAsFloat();
    HE_Face[] faceArray = mesh.getFacesAsArray();
    WB_Vector normal = null;
    WB_Vector[] vertexNormals = null;
    if (perVertexNormals) { 
        vertexNormals = mesh.getVertexNormals();
    }

    PShape shape = createShape();
    shape.beginShape(TRIANGLES);

    for (int i=0; i<facesHemesh.length; i++) {
        if (!perVertexNormals) { 
            normal = faceArray[i].getFaceNormal();
        }
        
        
        switch(id) {
        case 1:
            shape.stroke(0, 255, 0);
            shape.strokeWeight(1);
            shape.noFill();
            break;
        case 2:
            shape.fill(faceArray[i].getLabel());
            shape.noStroke();
            break;
        case 3:
            break;
        }
        for (int j = 0; j < 3; j++) {
            int index = facesHemesh[i][j];
            float[] vertexHemesh = verticesHemesh[index];
            if (perVertexNormals) { 
                normal = vertexNormals[index];
            }
            shape.normal(normal.xf(), normal.yf(), normal.zf());
            shape.vertex(vertexHemesh[0], vertexHemesh[1], vertexHemesh[2]);
        }
    }
    shape.endShape();
    shape.rotateX(radians(-90));

    return shape;
}

