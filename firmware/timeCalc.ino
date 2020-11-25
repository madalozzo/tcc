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

// created by Saulo Matte Madalozzo (saulo.zz@gmail.com) Aug, 2013

//options


# define BLOCK_INTERVAL 60000 // - 1 minute
# define SEND_INTERVAL 300000 // - 5 minutes
# define INIT_DELAY 10000

unsigned long lastBlockTime = INIT_DELAY;
unsigned long lastSendTime = INIT_DELAY;

boolean blockInfo(unsigned long time) {
	if ((time - lastBlockTime) >= BLOCK_INTERVAL) {
		lastBlockTime += BLOCK_INTERVAL;
		return true;
	} else {
		return false;
	}
}

boolean sendInfo(unsigned long time) {
	if ((time - lastSendTime) >= SEND_INTERVAL) {
		lastSendTime += SEND_INTERVAL;
		return true;
	} else {
		return false;
	}
}

int getInitDelay() {
	return INIT_DELAY;
}

void timeDebug(unsigned long time) {
	Serial.print("stats: lastBlockTime ");
	Serial.print(lastBlockTime);
	Serial.print("         diffBlock ");
	Serial.print(time - lastBlockTime);
	Serial.print("         lastSendTime ");
	Serial.print(lastSendTime);
	Serial.print("   TIME ");
	Serial.println(time);
}
