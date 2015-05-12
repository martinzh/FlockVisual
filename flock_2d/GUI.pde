//---------------------------------------//
// Genera ventana de control de parametros
//---------------------------------------//

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(0, 0);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    
    cp5.addToggle("go")
      .plugTo(parent,"go")
      .setValue(0)
      .setPosition(20,10)
      .setSize(30,30)
      .updateSize()
    ;
    
    cp5.addButton("reset")
      .plugTo(parent,"reset")
      // .setValue(0)
      .setPosition(60,10)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addSlider("background")
      .plugTo(parent,"bac")
      .setRange(5,255)
      .setValue(100)
      .setPosition(110,10)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addToggle("fluct")
      .plugTo(parent,"fluct")
      .setValue(0)
      .setPosition(20,60)
      .setSize(30,30)
      .updateSize()
    ;
    
    cp5.addToggle("full")
      .plugTo(parent,"full")
      .setValue(1)
      .setPosition(60,60)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("topo")
      .plugTo(parent,"topo")
      .setValue(0)
      .setPosition(20,110)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("geom")
      .plugTo(parent,"geom")
      .setValue(0)
      .setPosition(60,110)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addButton("clear_back")
      .plugTo(parent,"clear_back")
      // .setValue(0)
      .setPosition(20,210)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addSlider("scale")
      .plugTo(parent,"s")
      .setRange(0.1,5)
      .setValue(2)
      .setPosition(110,45)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addSlider("omega")
      .plugTo(parent,"omega")
      .setRange(0.0,1.0)
      .setValue(0.05)
      .setPosition(110,80)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addSlider("eta")
      .plugTo(parent,"eta")
      .setRange(0.0,1.0)
      .setValue(0.05)
      .setPosition(110,115)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addToggle("shCM")
      .plugTo(parent,"shCM")
      .setValue(0)
      .setPosition(20,160)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("pert")
      .plugTo(parent,"pert")
      .setValue(0)
      .setPosition(60,160)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addSlider("pertMag")
      .plugTo(parent,"pertMag")
      .setRange(-1.0,1.0)
      .setValue(0.5)
      .setPosition(110,150)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addSlider("numPerts")
      .plugTo(parent,"numPerts")
      .setRange(0,50)
      .setValue(1)
      .setPosition(110,180)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addButton("applyPert")
      .plugTo(parent,"applyPert")
      // .setValue(0)
      .setPosition(110,210)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("movePert")
      .plugTo(parent,"movePert")
      .setValue(0)
      .setPosition(170,210)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addButton("rampPert")
      .plugTo(parent,"rampPert")
      // .setValue(0)
      .setPosition(230,210)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addButton("setPred")
      .plugTo(parent,"setPred")
      // .setValue(0)
      .setPosition(110,260)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("movePred")
      .plugTo(parent,"movePred")
      .setValue(0)
      .setPosition(170,260)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("turnPred")
      .plugTo(parent,"turnPred")
      .setValue(0)
      .setPosition(230,260)
      .setSize(30,30)
      .updateSize()
    ;
    
    cp5.addToggle("dirRot")
      .plugTo(parent,"dirRot")
      .setValue(0)
      .setPosition(60,260)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addButton("slctP")
      .plugTo(parent,"slctP")
      // .setValue(0)
      .setPosition(20,260)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addSlider("speed")
      .plugTo(parent,"speed")
      .setRange(0.0,10.0)
      .setValue(0.0)
      .setPosition(20,320)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addToggle("drwCPY")
      .plugTo(parent,"drwCPY")
      .setValue(1)
      .setPosition(180,320)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("drwDIF")
      .plugTo(parent,"drwDIF")
      .setValue(0)
      .setPosition(230,320)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("fullCPY")
      .plugTo(parent,"fullCPY")
      .setValue(1)
      .setPosition(270,320)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("fluctCPY")
      .plugTo(parent,"fluctCPY")
      .setValue(0)
      .setPosition(310,320)
      .setSize(30,30)
      .updateSize()
    ;


  }

  public void draw() {
      background(80);
      stroke(255);
      line(300, 10, 300, 300);

      fill(255);
      text("Psi =" + psi, 320,30);

      pushMatrix();
      
      translate(320, 50);
      
      line(0,50,100,50);

      float y = map(psi,0.0,1.0,0.0,50.0);
      float x = t%100;

      fill(255,0,0,50);
      stroke(255,0,0);

      beginShape();

      vertex(0,0);
      vertex(0,50);
      vertex(x,50);
      vertex(x,50-y);

      endShape(CLOSE);

      stroke(255,0,0);
      line(x,50,x,50-y);

      popMatrix();

      pushMatrix();
      translate(300+(450-300)*0.5, 180);
      stroke(255);
      line(-50,0,50,0);
      line(0,-50,0,50);

      float vX = map(flock.velCM.x, 0.0, 1.0, 5, 50 );
      float vY = map(flock.velCM.y, 0.0, 1.0, 5, 50 );
      
      float vXcpy = map(flockCPY.velCM.x, 0.0, 1.0, 5, 50 );
      float vYcpy = map(flockCPY.velCM.y, 0.0, 1.0, 5, 50 );

      stroke(255,0,0);
      
      strokeWeight(2.5);

      line(0,0,vX,vY);

      stroke(0,255,0);
      
      strokeWeight(2.5);

      line(0,0,vXcpy,vYcpy);

      popMatrix();

      strokeWeight(1);

  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public ControlP5 control() {
    return cp5;
  }
  
  ControlP5 cp5;

  Object parent;
}
