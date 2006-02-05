/**
 * Copyright (c) 2005-2006 Arched Rock Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the Arched Rock Corporation nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * ARCHED ROCK OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE
 */

/**
 * HPL implementation of interrupts and captures for the ChipCon
 * CC2420 radio connected to a TI MSP430 processor.
 *
 * @author Jonathan Hui <jhui@archedrock.com>
 * @version $Revision: 1.1.2.5 $ $Date: 2006-01-29 17:59:27 $
 */

configuration HplCC2420InterruptsC {

  provides interface GpioCapture as CaptureSFD;
  provides interface GpioInterrupt as InterruptCCA;
  provides interface GpioInterrupt as InterruptFIFOP;

}

implementation {

  components Counter32khzC;
  components HplMsp430GeneralIOC as GeneralIOC;
  components Msp430TimerC;
  components new GpioCaptureC() as CaptureSFDC;
  CaptureSFDC.Msp430TimerControl -> Msp430TimerC.ControlB1;
  CaptureSFDC.Msp430Capture -> Msp430TimerC.CaptureB1;
  CaptureSFDC.GeneralIO -> GeneralIOC.Port41;

  components HplMsp430InterruptC;
  components new Msp430InterruptC() as InterruptCCAC;
  components new Msp430InterruptC() as InterruptFIFOPC;
  InterruptCCAC.HplInterrupt -> HplMsp430InterruptC.Port14;
  InterruptFIFOPC.HplInterrupt -> HplMsp430InterruptC.Port10;

  CaptureSFD = CaptureSFDC.Capture;
  InterruptCCA = InterruptCCAC.Interrupt;
  InterruptFIFOP = InterruptFIFOPC.Interrupt;

}
