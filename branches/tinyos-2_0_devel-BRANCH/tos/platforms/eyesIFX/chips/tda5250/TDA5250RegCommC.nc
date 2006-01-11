/*
 * Copyright (c) 2004, Technische Universitaet Berlin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 * - Neither the name of the Technische Universitaet Berlin nor the names
 *   of its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES {} LOSS OF USE, DATA,
 * OR PROFITS {} OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * - Description ---------------------------------------------------------
 * Controlling the TDA5250 at the HPL layer for use with the MSP430 on the 
 * eyesIFX platforms, Configuration.
 * - Revision -------------------------------------------------------------
 * $Revision: 1.1.2.5 $
 * $Date: 2006-01-11 20:43:52 $
 * @author: Kevin Klues (klues@tkn.tu-berlin.de)
 * ========================================================================
 */
 
#include "msp430BusResource.h"
enum {
  TDA5250_SPI_BUS_ID = unique(MSP430_SPIO_BUS)
};     
configuration TDA5250RegCommC {
  provides {
    interface Init;
    interface TDA5250RegComm;
    interface Resource;
  }
}
implementation {
  components HplMsp430Usart0C
           , TDA5250RegCommP
           , TDA5250RadioIO
           ;      
   
  Init = HplMsp430Usart0C;
  Init = TDA5250RegCommP;
  Resource = TDA5250RegCommP.Resource;
  
  TDA5250RegComm = TDA5250RegCommP; 
  
  TDA5250RegCommP.BusM -> TDA5250RadioIO.TDA5250RadioBUSM; 
  
  TDA5250RegCommP.Usart -> HplMsp430Usart0C;
  // FIXME: Hier ResourceController!?
  TDA5250RegCommP.SpiResource -> HplMsp430Usart0C.Resource[TDA5250_SPI_BUS_ID];
  TDA5250RegCommP.ArbiterInfo -> HplMsp430Usart0C.ArbiterInfo;      
  
  
  
}
