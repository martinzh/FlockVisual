//---------------------------------------//
// Martin Zumaya Hernandez

// Inicio: Agosto - Septiembre 2015

// Simulacion de Flocking en 3D
// con interacciones topologicas de largo alcance
// y geometricas de corto alcance

// Sep·4·2015 --> Red aleatoria todos contra todos
//---------------------------------------//


import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

Scene scene;

private ControlP5 cp5;

ControlFrame cf;

Flock flock;

float l = 150, vo = 5, hg, ht, r = 30, dt, pt, pg;
int k = 3, n = 750, go = 1, topo, geom;
float s = 1;

void setup() {
	// size(800, 800, P3D);
	size(1024, 740, P3D);

	SetScene();

	cp5 = new ControlP5(this);
	cf = addControlFrame("parameters", 400,200);

	flock = new Flock(n,l,vo,k, r);
}

void draw() {
	lights();
	background(0);
	noStroke();

	pg = abs(1-pt);

	// println("pt: "+ pt + "\t pg: " + pg);

	flock.Update(dt,go);

	for(int i = 0; i < n; i ++){
		Example(i);
	}
	
}

void Example(int i){
	if(topo == 1) flock.elements[i].ShowTopoLinks(flock.elements);
	if(geom == 1) flock.elements[i].ShowGeomLinks(flock.elements);
	// flock.elements[i].ShowRadius();
}

void SetScene(){
	scene = new Scene(this);
	scene.showAll();
	// scene.setRadius(500);
	scene.setGridVisualHint(false);
	scene.setAxesVisualHint(false);
	// scene.disableKeyboardHandling();
}

void radius(float rr){
	for(Agent3D o : flock.elements){
		o.r = rr;
	}
}

void reset(){
	for(Agent3D o : flock.elements){
		o.pos.set(random(-l, l), random(-l, l), random(-l, l));
		o.vel = PVector.random3D();
		o.vel.mult(vo);
	}
}