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


# include < SPI.h > # include < Ethernet.h > EthernetClient client;

byte mac[] = {
	0x90, 0xA2, 0xDA, 0x0D, 0x73, 0x31
}; //uri1
byte ip[] = {
	10, 0, 0, 221
};
# define CONNECT_DATA "GET http://localhost/pluvi.am/pluvi.am/s01/tcc.php?cd=j7x8q&pw=nMNe6pRt9aXX2fcU&tk=WtDQRGgZ" //uri1

//byte mac[] = {0x90, 0xA2, 0xDA, 0x0D, 0xD6, 0xF4 }; //uri2
//byte ip[] = { 10, 0, 0, 222 }; 
//#define CONNECT_DATA   "GET http://localhost/pluvi.am/pluvi.am/s01/tcc.php?cd=gi5ak&pw=E9gr8K6Ca3KJU6bc&tk=pdoARmeo" //uri2

# define SERVER_ADDR "10.0.0.105"

void startConnection() {
	// start the Ethernet connection:
	Ethernet.begin(mac, ip);
	/*if (Ethernet.begin(mac, ip) == 0) { //dhcp
    Serial.println("Failed to configure Ethernet using DHCP");
    // no point in carrying on, so do nothing forevermore:
    digitalWrite(LED_ERR2, HIGH);
    while(true);
  }*/
}

void printIpInfo() {
	Serial.print(Ethernet.localIP());
}



void pluviamRequest() {
	// if there's a successful connection:
	if (client.connect(SERVER_ADDR, 80)) {
		Serial.println("connected...");


		client.print(CONNECT_DATA);

		client.print("&st="); // millis  
		client.print(millis());

		client.print("&tp=");
		client.print(getTemperature());

		client.print("&um=");
		client.print(getHumidity());

		client.print("&pr="); //uri1
		client.print(getPressure());

		client.print("&ch=");
		client.print(getChuva());

		client.print("&vn=");
		client.print(getVento());

		client.print("&dv=");
		client.print(getWindDirection());




		client.println(" HTTP/1.1");
		client.println("Host: 10.0.0.105");
		client.println("User-Agent: arduino-ethernet");
		client.println("Connection: close");
		client.println();
		client.stop();
	} else {
		// if you couldn't make a connection:
		// Serial.println("connection failed");
		//Serial.println("disconnecting.");
		client.stop();
	}
}
