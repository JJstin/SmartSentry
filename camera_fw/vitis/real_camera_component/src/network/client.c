/*
 * Copyright (C) 2009 - 2019 Xilinx, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 */

#include <stdio.h>
#include <string.h>

#include "lwip/err.h"
#include "lwip/tcp.h"
#if defined (__arm__) || defined (__aarch64__)
#include "xil_printf.h"
#endif


#include "xparameters.h"
#include "xiic.h"
#include <stdio.h>
#include <xiic_l.h>
#ifdef XPAR_INTC_0_DEVICE_ID
#include "xintc.h"
#else
#include "xscugic.h"
#endif
#include "xil_exception.h"
#include "xil_printf.h"

#include "test_images/test_images.h"

#include "netif/xadapter.h"

#define	XIIC_BASEADDRESS	XPAR_XIIC_0_BASEADDR

/*
 * The following constant defines the address of the IIC
 * temperature sensor device on the IIC bus. Note that since
 * the address is only 7 bits, this  constant is the address divided by 2.
 */
#define TEMP_SENSOR_ADDRESS	0x3C /* The actual address is 0x30 */

#define CONNECTED_MASK 0x01
#define ACK_MASK 0x02

static struct tcp_pcb *pcb;

static u8 connection_status = 0x02;

static int bytes_to_send = 0;
static int bytes_to_ack = 0;

void tcp_fasttmr(void);
void tcp_slowtmr(void);

extern volatile int TcpFastTmrFlag;
extern volatile int TcpSlowTmrFlag;

struct netif * get_netif();

u8 is_connected() {
    return connection_status & CONNECTED_MASK;
}

void transfer_data(u8 * ImgBuffer, int bytes) {
    bytes_to_send = bytes + 4;
    bytes_to_ack = bytes + 4;
    u8 length_sent = 0;
    int image_length = bytes;

    err_t err;
    u8_t apiflags = TCP_WRITE_FLAG_COPY | TCP_WRITE_FLAG_MORE;
    while(bytes_to_ack > 0) {
        if (TcpFastTmrFlag) {
			tcp_fasttmr();
			TcpFastTmrFlag = 0;
            }
            if (TcpSlowTmrFlag) {
                tcp_slowtmr();
                TcpSlowTmrFlag = 0;
            }
        xemacif_input(get_netif());

        if (pcb == NULL) {
            xil_printf("pcb NULL\n\r");
	    }

        if (!is_connected()) {
            // xil_printf("Is not connected\n\r");
            return;
	    }

        if(!length_sent) {
            if (tcp_sndbuf(pcb) > 4) {
                // xil_printf("Sending image length...                length: %d\n\r", image_length);
                err = tcp_write(pcb, &image_length, 4, apiflags);
                if (err != ERR_OK) {
                    xil_printf("TCP client: Error on tcp_write: %d\r\n", err);
                }
                err = tcp_output(pcb);
                if (err != ERR_OK) {
                    xil_printf("TCP client: Error on tcp_output: %d\r\n", err);
                }
                bytes_to_send -= 4;
                length_sent = 1;
            }
        }
        else {
            if(bytes_to_send > 0) {
                int sendbuf_size = tcp_sndbuf(pcb);
                if (sendbuf_size > bytes_to_send) {
                    // xil_printf("Sending rest of image...                size: %d\n\r", bytes_to_send);
                    tcp_write(pcb, ImgBuffer, bytes_to_send, apiflags);
                    if (err != ERR_OK) {
                        xil_printf("TCP client: Error on tcp_write: %d\r\n", err);
                    }
                    err = tcp_output(pcb);
                    if (err != ERR_OK) {
                        xil_printf("TCP client: Error on tcp_output: %d\r\n", err);
                    }
                    bytes_to_send = 0;
                }
                else if(sendbuf_size > 0) {
                    // xil_printf("Sending partial image...                size: %d\n\r", sendbuf_size);
                    tcp_write(pcb, ImgBuffer, sendbuf_size, apiflags);
                    if (err != ERR_OK) {
                        xil_printf("TCP client: Error on tcp_write: %d\r\n", err);
                    }
                    err = tcp_output(pcb);
                    if (err != ERR_OK) {
                        xil_printf("TCP client: Error on tcp_output: %d\r\n", err);
                    }
                    bytes_to_send -= sendbuf_size;
                    ImgBuffer += sendbuf_size;
                }
            }
        }
    }
    
    // if(((connection_status & (CONNECTED_MASK | ACK_MASK)) == (CONNECTED_MASK | ACK_MASK)) && ! is_image_sent()) {
        

    //     // struct test_image img;
    //     // get_next_image(&img);
    //     // int image_length = img.size;
    //     // u8 * image = img.buf;

    //     int image_length = bytes;
        
    //     xil_printf("byte length %d\r\n", bytes);

    //     if (tcp_sndbuf(pcb) > image_length + 4) {
    //         xil_printf("Sending image length...\n\r");
    //         tcp_write(pcb, &image_length, 4, apiflags);  
    //         err = tcp_write(pcb, ImgBuffer, image_length, apiflags);
    //         if (err != ERR_OK) {
    //             xil_printf("TCP client: Error on tcp_write: %d\r\n",
    //                     err);
    //             // return err;
    //         }

    //         err = tcp_output(pcb);
    //         if (err != ERR_OK) {
    //             xil_printf("TCP client: Error on tcp_output: %d\r\n",
    //                     err);
    //             // return err;
    //         }

    //         bytes_to_send = image_length + 4;
    //         connection_status = connection_status & ~ACK_MASK;

    //     }
        
    //     // tcp_output(pcb);
    // }
}

void print_app_header()
{
#if (LWIP_IPV6==0)
	xil_printf("\n\r\n\r-----lwIP TCP echo server ------\n\r");
#else
	xil_printf("\n\r\n\r-----lwIPv6 TCP echo server ------\n\r");
#endif
	xil_printf("TCP packets sent to port 6001 will be echoed back\n\r");
}

err_t recv_callback(void *arg, struct tcp_pcb *tpcb,
                               struct pbuf *p, err_t err)
{
	/* do not read the packet if we are not in ESTABLISHED state */
	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		return ERR_OK;
	}

	/* indicate that the packet has been received */
	tcp_recved(tpcb, p->len);

	/* echo back the payload */
	/* in this case, we assume that the payload is < TCP_SND_BUF */
    xil_printf("received packet \n\r");
	// if (tcp_sndbuf(tpcb) > p->len) {
	// 	err = tcp_write(tpcb, p->payload, p->len, 1);
	// } else
	// 	xil_printf("no space in tcp_sndbuf\n\r");

	/* free the received pbuf */
	pbuf_free(p);

	return ERR_OK;
}

err_t accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	static int connection = 1;

	/* set the receive callback for this connection */
	tcp_recv(newpcb, recv_callback);

	/* just use an integer number indicating the connection id as the
	   callback argument */
	tcp_arg(newpcb, (void*)(UINTPTR)connection);

	/* increment for subsequent accepted connections */
	connection++;

	return ERR_OK;
}

static err_t tcp_client_sent(void *arg, struct tcp_pcb *tpcb, u16_t len)
{
    // xil_printf("server acked %d\n\r", len);
    bytes_to_ack -= len;
	return ERR_OK;
}

void error_callback(void *arg,  err_t err)
{
    xil_printf("tcp error!\n\r");
    connection_status &= ~(CONNECTED_MASK);
    xil_printf("error code: \n\r", err);
}

err_t connected_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
    if (err != ERR_OK) {
		// tcp_client_close(tpcb);
		xil_printf("Connection error\n\r");
		return err;
	}
	/* store state */
	pcb = newpcb;

    tcp_arg(pcb, NULL);
	tcp_sent(pcb, tcp_client_sent);
	tcp_err(pcb, error_callback);
    xil_printf("connected to server!\n\r");
    connection_status = connection_status | CONNECTED_MASK;
    // tcp_write(pcb, image, image_length, 1);
    return ERR_OK;
}

int start_application()
{
	err_t err;

	/* create new TCP PCB structure */
	pcb = tcp_new_ip_type(IPADDR_TYPE_ANY);
	if (!pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}
    ip_addr_t ipaddr;
    IP4_ADDR(&ipaddr,  192, 168,   1, 100);
    
    xil_printf("Preparing to connect to 192.169.1.100:12345\n\r");
    err = tcp_connect(pcb, &ipaddr, 12345, connected_callback);
    if (err != ERR_OK) {
		xil_printf("Connect failed, err = %d\n\r", err);
	}

    // wait until connected
    while(!is_connected()) {
        if (TcpFastTmrFlag) {
			tcp_fasttmr();
			TcpFastTmrFlag = 0;
            }
        if (TcpSlowTmrFlag) {
            tcp_slowtmr();
            TcpSlowTmrFlag = 0;
        }
        xemacif_input(get_netif());
    }
	/* bind to specified @port */
	// err = tcp_bind(pcb, IP_ANY_TYPE, port);
	// if (err != ERR_OK) {
	// 	xil_printf("Unable to bind to port %d: err = %d\n\r", port, err);
	// 	return -2;
	// }

	// /* we do not need any arguments to callback functions */
	// tcp_arg(pcb, NULL);

	// /* listen for connections */
	// pcb = tcp_listen(pcb);
	// if (!pcb) {
	// 	xil_printf("Out of memory while tcp_listen\n\r");
	// 	return -3;
	// }

	// /* specify callback to use for incoming connections */
	// tcp_accept(pcb, accept_callback);

	// xil_printf("TCP echo server started @ port %d\n\r", port);
    xil_printf("end\n\r");
	return 0;
}
