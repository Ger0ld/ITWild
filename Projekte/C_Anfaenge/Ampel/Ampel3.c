/*++++++++++++++++++++++++++++++++++++++++++
Dateiname: Ampel3
Autor:	G.Jaeger	                  
Datum:	09.10.2018
++++++++++++++++++++++++++++++++++++++++++*/
#include <at89c5131.h>

	//h = Hauptstrasse
	sbit h_gruen = P1^1; 
	sbit h_gelb = P1^3;
	sbit h_rot = P1^5;
	//n = Nebenstrasse
	sbit n_gruen = P1^4;
	sbit n_gelb = P1^2;
	sbit n_rot = P1^0;
	//Interrupt für zuruecksetzen der 'Flag'
	sbit i_ex0 = P3^2;
	sbit i_ex1 = P3^3;
	
	int ampel_status;
	int reload_time_h = 250;
	int reload_time_l = 250;

//Funktionsprototypen
void gruen(sbit, sbit, sbit);
void gelb(sbit,sbit, sbit);
void rot(sbit, sbit, sbit);
void gelb_rot(sbit, sbit, sbit);
void interrupt_timer();

void i_EX0 (void) interrupt 0 {
	
	TF0 = 1;
	//clear interrupt 
	i_ex0 = 1;
		
}

void i_EX1 (void) interrupt 2 {

	TF0 = 1;
	//clear interrupt 
	i_ex1 = 1;
}

void i_t1 (void) interrupt 1{
	
	interrupt_timer();
	
}

void interrupt_timer(){

	//Reload Timer
	if (ampel_status == 1){
		TL0 = reload_time_l + ((256 - reload_time_l) / 2) ;
		TH0 = reload_time_h + ((256 - reload_time_h) / 2) ;
	}else{
		TL0 = reload_time_l;
		TH0 = reload_time_h;
	}
	
	switch(ampel_status){
		case 0: 
		
			gruen(h_rot, h_gelb, h_gruen);
			rot(n_rot, n_gelb, n_gruen);
			
			TR0 =~ TR0;

			break;
		case 1:
			
			gelb(h_rot, h_gelb, h_gruen);
			gelb_rot(n_rot, n_gelb, n_gruen);
			break;
		
		case 2:
			
			rot(h_rot, h_gelb, h_gruen);
			gruen(n_rot, n_gelb, n_gruen);
			break;
		
		case 3:
			
			gelb_rot(h_rot, h_gelb, h_gruen);
			gelb(n_rot, n_gelb, n_gruen);
			break;
	}
	
	if(TR0 == 1){
		ampel_status += 1;
		if(ampel_status == 4){
			ampel_status = 0;
		}
	}

}

void main(){
	
	//init Interrupt 
	//Externer Interrupt 0 mit Taktflanke
	EX0 = 1;
	IT0 = 1;
	
	//Externer Interrupt 1 mit Taktflanke
	EX1 = 1;
	IT1 = 1;
	
	//Timer 0 Interrupt
	ET0 = 1;
	
	EA 	= 1;

	TMOD = 1;
	TR0 = 0;

	TH0 = reload_time_h;
	TL0 = reload_time_l;
	
	//Ampel setup
	P1 = 0;
	h_gruen = 1;
	n_rot = 1;
	
	while(1){
		
	}
	
}

void gruen(sbit rot, sbit gelb, sbit gruen){

	rot = 0;
	gelb = 0;
	gruen = 1;
	
}

void gelb(sbit rot, sbit gelb, sbit gruen){
	
	gruen = 0;
	gelb = 1;
	
}

void rot(sbit rot, sbit gelb, sbit gruen){

	gelb = 0;
	rot = 1;
	
}

void gelb_rot(sbit rot, sbit gelb, sbit gruen){
	
	gelb = 1;
	
}