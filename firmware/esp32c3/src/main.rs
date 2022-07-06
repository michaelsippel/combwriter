/*
      Copyright 2022 Michael Sippel

<<<<>>>><<>><><<>><<<*>>><<>><><<>><<<<>>>>

 This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
 License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
 version.

 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 details.

 You should have received a copy of the GNU General Public License along with this program. If not, see
 <https://www.gnu.org/licenses/>.
*/

#![no_std]
#![no_main]

#[macro_use]
mod scan_key;

#[macro_use]
#[allow(unused_macros)]
mod rowscanner;

#[macro_use]
#[allow(unused_macros)]
mod colscanner;

use combwriter_protocol::{
    ScanCode, KeyState, KeyPosition, Part
};


use core::fmt::Write;

use esp32c3_hal::{pac::Peripherals, prelude::*, RtcCntl, Serial, Timer, IO, clock::ClockControl};
use nb::block;
use panic_halt as _;
use riscv_rt::entry;

#[entry]
fn main() -> ! {
    let peripherals = Peripherals::take().unwrap();
    let system = peripherals.SYSTEM.split();
    let clocks = ClockControl::boot_defaults(system.clock_control).freeze();

    let mut rtc_cntl = RtcCntl::new(peripherals.RTC_CNTL);
    let mut serial0 = Serial::new(peripherals.UART0).unwrap();
    let mut timer0 = Timer::new(peripherals.TIMG0, clocks.apb_clock);
    let mut timer1 = Timer::new(peripherals.TIMG1, clocks.apb_clock);

    // Disable watchdog timers
    rtc_cntl.set_super_wdt_enable(false);
    rtc_cntl.set_wdt_enable(false);
    timer0.disable();
    timer1.disable();

    timer0.start(50u64.micros());
    
    let io = IO::new(peripherals.GPIO, peripherals.IO_MUX);
    rowscanner!(io, timer0, serial0, combwriter_protocol::Part::Right);
}

