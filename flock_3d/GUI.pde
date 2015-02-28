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
      .setPosition(320,10)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("topo")
      .plugTo(parent,"topo")
      .setValue(0)
      .setPosition(220,10)
      .setSize(30,30)
      .updateSize()
    ;

    cp5.addToggle("geom")
      .plugTo(parent,"geom")
      .setValue(0)
      .setPosition(270,10)
      .setSize(30,30)
      .updateSize()
    ;
    
    cp5.addSlider("dt")
      .plugTo(parent,"dt")
      .setRange(0,1)
      .setValue(0.1)
      .setPosition(70,10)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addSlider("hg")
      .plugTo(parent,"hg")
      .setRange(0,1)
      .setValue(0.50)
      .setPosition(20,100)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addSlider("ht")
      .plugTo(parent,"ht")
      .setRange(0,1)
      .setValue(0.50)
      .setPosition(20,65)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addSlider("pt")
      .plugTo(parent,"pt")
      .setRange(0,1)
      .setValue(0.50)
      .setPosition(180,65)
      .setSize(120,20)
      .updateSize()
    ;

    cp5.addSlider("radius")
      .plugTo(parent,"radius")
      .setRange(1,100)
      .setValue(30)
      .setPosition(180,100)
      .setSize(120,20)
      .updateSize()
    ;

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