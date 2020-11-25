/* This file is part of the Pluviam Firmware */

/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <saulo.zz@gmail.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer (or a wine) in return.
 * Saulo Matte Madalozzo
 * ----------------------------------------------------------------------------
 */

// created by Saulo Matte Madalozzo (saulo.zz@gmail.com) Oct, 2011
// modified by Saulo Matte Madalozzo (saulo.zz@gmail.com) Oct, 2013

volatile unsigned int chuva = 0;
volatile unsigned long last_interrupt_timeChuva = 0;
volatile unsigned long interrupt_timeChuva = 0;

void interrupcaoChuva() {
	interrupt_timeChuva = millis();
	// If interrupts come faster than 100ms, assume it's a bounce and ignore
	if (interrupt_timeChuva - last_interrupt_timeChuva > 100) {
		chuva++;
		Serial.println(" C ");
	}
	last_interrupt_timeChuva = interrupt_timeChuva;
}

unsigned int getChuva() {
	unsigned int retorno = chuva;
	chuva = 0;
	return retorno;
}
