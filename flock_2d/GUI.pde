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
  f.setLocation(100, 100);
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
      .setRange(0.0,0.6)
      .setValue(0.05)
      .setPosition(110,115)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addToggle("pert")
      .plugTo(parent,"pert")
      .setValue(0)
      .setPosition(20,160)
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

    // cp5.addSlider("dt")
    //   .plugTo(parent,"dt")
    //   .setRange(0.25,2.5)
    //   .setValue(0.5)
    //   .setPosition(70,10)
    //   .setSize(120,20)
    //   .updateSize()
    // ;

    // cp5.addSlider("radio")
    //   .plugTo(parent,"radio")
    //   .setRange(1,30)
    //   .setValue(5.0)
    //   .setPosition(180,100)
    //   .setSize(120,20)
    //   .updateSize()
    // ;

  }

  public void draw() {
      background(80);
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
