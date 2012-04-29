/*
 * Copyright (C) 2011-2012 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cutils/properties.h>

extern void nv_cmd_remote(int,int,void*);
extern void oncrpc_init();
extern void oncrpc_task_start();


/* Read properties and set MAC addresses accordingly */
/* Get the wlan MAC from nv. This attempts to replicate the
   wifi_read_mac_address function from the stock software */

int main() {
	int fd1; FILE *fd;
	int macbyte;
	int i;
	char mMacAddr[PROPERTY_VALUE_MAX];
	int mac[2] = { 0, };

	property_get("service.brcm.bt.mac",mMacAddr,"010203040506");
	fd = fopen("/data/misc/bd_addr","w");
	fprintf(fd,"%c%c:%c%c:%c%c:%c%c:%c%c:%c%c\n",mMacAddr[0], mMacAddr[1], mMacAddr[2], mMacAddr[3], mMacAddr[4], mMacAddr[5], mMacAddr[6], mMacAddr[7], mMacAddr[8], mMacAddr[9], mMacAddr[10], mMacAddr[11]);
	fclose(fd);


	oncrpc_init(); oncrpc_task_start();
	nv_cmd_remote(0,0x1246,&mac);

	if (mac[0] == 0)
		return 0;

	fd = fopen("/data/misc/wifi/config","w");
	fprintf(fd,"cur_etheraddr=%.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
			mac[0]&0xFF,
			(mac[0]&0xFF00) >> 8,
			(mac[0]&0xFF0000) >> 16,
			(mac[0]&0xFF000000) >> 24,
			mac[1]&0xFF,
			(mac[1]&0xFF00) >> 8);
	fclose(fd);
	return 0;
}
