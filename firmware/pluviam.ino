/*
 * Pluviam Firmware v 1.1
 *
 * Weather Station using Arduino Ethernet with HIH6130, BMP085 and Argent 80422 sensors.
 *
 * HIH6130 code originaly created by Peter H Anderson
 * BMP085 code originaly created by Jim Lindblom
 *
 * created by Saulo Matte Madalozzo (saulo.zz@gmail.com) Oct, 2011
 * modified by Saulo Matte Madalozzo (saulo.zz@gmail.com) Oct, 2013
 *
 */

/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <saulo.zz@gmail.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer (or a wine) in return.
 * Saulo Matte Madalozzo
 * ----------------------------------------------------------------------------
 */

//libs
# include < Wire.h >

//led pins
# define LED_PWR 9 # define LED_ETH 8 # define LED_CPU 7 # define LED_ERR1 6 # define LED_ERR2 5


void setup() {

	pinMode(LED_PWR, OUTPUT);
	pinMode(LED_ETH, OUTPUT);
	pinMode(LED_CPU, OUTPUT);
	pinMode(LED_ERR1, OUTPUT);
	pinMode(LED_ERR2, OUTPUT);

	digitalWrite(LED_PWR, HIGH);
	digitalWrite(LED_ETH, HIGH);
	digitalWrite(LED_CPU, HIGH);
	digitalWrite(LED_ERR1, HIGH);
	digitalWrite(LED_ERR2, HIGH);
	delay(400);
	digitalWrite(LED_ERR2, LOW);
	delay(200);
	digitalWrite(LED_ERR1, LOW);
	delay(200);
	digitalWrite(LED_CPU, LOW);
	delay(200);
	digitalWrite(LED_ETH, LOW);
	delay(200);
	digitalWrite(LED_PWR, LOW);
	delay(500);
	//digitalWrite(LED_ERR2, HIGH);

	Serial.begin(57600);
	Serial.println("Serial [OK]");

	Serial.print("Starting Wire... ");
	digitalWrite(LED_ERR1, HIGH);
	Wire.begin();
	delay(50);
	digitalWrite(LED_ERR1, LOW);
	Serial.println("[OK]");
	delay(200);
	Serial.print("Calibrating BMP085... ");
	digitalWrite(LED_ERR1, HIGH);
	bmp085Calibration(); //uri1
	digitalWrite(LED_ERR1, LOW);
	Serial.println("[OK]");
	delay(200);
	Serial.print("Initializing ethernet... ");
	digitalWrite(LED_ETH, HIGH);

	startConnection();

	digitalWrite(LED_ETH, LOW);
	Serial.println("[OK]");
	Serial.print("   IP Address: ");
	printIpInfo();
	Serial.println();

	Serial.print("Waiting sensors... ");
	boolean initialized = false;
	int initialDelay = getInitDelay();
	unsigned long initTime = millis();
	boolean powerOn = false;
	while (!initialized) { //delay to initialize all sensors and ethernet
		initTime = millis();
		if (initTime >= initialDelay) {
			initialized = true;
		}
		if ((initTime % 300) == 0) {
			if (powerOn) digitalWrite(LED_PWR, LOW);
			else digitalWrite(LED_PWR, HIGH);
			powerOn = !powerOn;
			delay(1);
		}
	}
	digitalWrite(LED_PWR, LOW);
	Serial.println("[OK]");


	Serial.print("Attaching interrupts ");
	//funcoes de interrupcao
	attachInterrupt(0, interrupcaoVento, FALLING); //pino 2
	attachInterrupt(1, interrupcaoChuva, FALLING); //pino 3
	Serial.println("[OK]");


	Serial.println("-------");
	Serial.print("time: ");
	Serial.println(millis());
	digitalWrite(LED_PWR, HIGH);
}



void loop() {
	unsigned long time = 0; //time var will reset at 4294967295;
	time = millis();
	//Serial.println(funcaoDirVentoDebug());
	//delay(100);

	if (blockInfo(time)) { //compute sensors data
		digitalWrite(LED_CPU, HIGH);
		Serial.print("time: ");
		Serial.println(time);

		getHIH6130Data();

		pluviamRequest();

		digitalWrite(LED_CPU, LOW);
	}
	/*if (sendInfo(time)){ //compute sensors data and send
      digitalWrite(LED_ETH, HIGH);

  
    Serial.print(time);
    Serial.println(" SEND  ----------");
    digitalWrite(LED_ETH, LOW);
  }*/
}
