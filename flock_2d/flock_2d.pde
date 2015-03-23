//---------------------------------------//
// Martin Zumaya Hernandez

// Inicio: Agosto - Septiembre 2015

// Simulacion de Flocking en 2D
// con interacciones topologicas de largo alcance
// y geometricas de corto alcance

// Sep·4·2015 --> Red aleatoria todos contra todos
//---------------------------------------//

import java.awt.Frame;
import java.awt.BorderLayout;
import java.lang.Math;
import java.util.Scanner;
import controlP5.*;

private ControlP5 cp5;
ControlFrame cf;

Agent2D pred;
Flock flock;

float l = 50, vo = 1, h, r, dt, w ;
int k = 2, n = 350, go, topo, geom, bac;
float s = 1;

void setup() {
	size(800, 800);
	//size(1024, 740, OPENGL);
	smooth();
	background(0);

	//colorMode(HSB);

	cp5 = new ControlP5(this);
	cf = addControlFrame("parameters", 600,200);

	pred = new Agent2D(l,vo,0,r);
	flock = new Flock(n,l,vo,k,r);
	// flock = new Flock(n,l,vo,r);
}

void draw() {
	// background(120);
	
	noStroke();
	fill(0,bac);
	rect(0,0,width,height);

	translate(width/2, height/2);

	scale(s);

	// noFill();
	// stroke(255);
	// // ellipse(0, 0, 100, 100);

	// pg = abs(1-pt);

	// println("pt: "+ pt + "\t pg: " + pg);

	// flock.Update(dt,go);
	flock.Update(dt,go, pred);
	pred_update(go);

	for(int i = 0; i < n; i ++){
		Example(i);}
	
}

void keyPressed() {
	// if (key == 's'){
	// 	background(0);
	// 	s += 0.05;
	// 	// println("s: "+s);
	// }
	// if (key == 'a'){
	// 	background(0);
	// 	s -= 0.05;
	// 	// println("s: "+s);
	// }
	if (key == 'c'){
		background(0);
	}
}

void Example(int i){
	if(topo == 1) flock.elements[i].ShowTopoLinks(flock.elements);
	if(geom == 1) flock.elements[i].ShowGeomLinks(flock.elements);
	// flock.elements[i].ShowRadius();
}

void radio(float rr){
	for(Agent2D o : flock.elements){
		o.r = rr;
	}
}

void reset(){
	for(Agent2D o : flock.elements){
		o.pos.set(random(-l, l), random(-l, l));
		o.vel = PVector.random2D();
		o.vel.mult(vo);
	}

	// pred.pos.set(random(-l, l), random(-l, l));
	// pred.vel = PVector.random2D();
	// pred.vel.mult(vo);

}

void clear_back(){
	bac = 255;
}

float calc_ang(PVector v1, PVector v2){

	float a1 = atan2(v1.y,v1.x);
	float a2 = atan2(v2.y,v2.x);

	return a2-a1;
}


void pred_update(int p){
	pred.Show_Pred();
	// pred.Show_Pred();
	// if (p ==1) pred.Move(dt);
	pred.pos.x = mouseX - width/2;
	pred.pos.y = mouseY - height/2;

	pred.vel.x = mouseX - pmouseX;
	pred.vel.y = mouseY - pmouseY;
}

