#![no_std]
#![no_main]

use core::fmt::Write;

use esp32c3_hal::{pac::Peripherals, prelude::*, RtcCntl, Serial, Timer, IO};
use nb::block;
use panic_halt as _;
use riscv_rt::entry;

macro_rules! scan_key {
    ( $i:expr, $k2:ident, $count:expr, $state:expr, $s:ident ) => {
        if let Ok(inp) = $k2.is_high() {
            if $state != inp {
                if $count == 0 {
                    // was stable long enough, take the change
                    $state = inp;

                    if $state {
                        writeln!($s, "press {}", $i);
                    } else {
                        writeln!($s, "release {}", $i);
                    }
                }

                // reset timer
                $count = 10;
            } else if $count > 0 {
                $count -= 1;
            }
        }
    }
}

macro_rules! scan_col {
    ( $x:expr, $values:expr, $row0:ident, $row1:ident, $row2:ident, $row3:ident, $count:ident, $state:ident, $serial:ident ) => {
        scan_key!($values[0], $row0, $count[0*7+$x], $state[0*7+$x], $serial);
        scan_key!($values[1], $row1, $count[1*7+$x], $state[1*7+$x], $serial);
        scan_key!($values[2], $row2, $count[2*7+$x], $state[2*7+$x], $serial);
        scan_key!($values[3], $row3, $count[3*7+$x], $state[3*7+$x], $serial);
    }
}

#[entry]
fn main() -> ! {
    let peripherals = Peripherals::take().unwrap();
    
    let mut rtc_cntl = RtcCntl::new(peripherals.RTC_CNTL);
    let mut serial0 = Serial::new(peripherals.UART0).unwrap();
    let mut timer0 = Timer::new(peripherals.TIMG0);
    let mut timer1 = Timer::new(peripherals.TIMG1);

    // Disable watchdog timers
    rtc_cntl.set_super_wdt_enable(false);
    rtc_cntl.set_wdt_enable(false);
    timer0.disable();
    timer1.disable();

    timer0.start(5000_u64);

    let io = IO::new(peripherals.GPIO, peripherals.IO_MUX);

    let mut count = [0; 4*7];
    let mut state = [false; 4*7];

    let mut c1 = io.pins.gpio8.into_push_pull_output();
    let mut c2 = io.pins.gpio7.into_push_pull_output();
    let mut c3 = io.pins.gpio6.into_push_pull_output();
    let mut c4 = io.pins.gpio5.into_push_pull_output();
    let mut c5 = io.pins.gpio4.into_push_pull_output();
    let mut c6 = io.pins.gpio9.into_push_pull_output();
    let mut c7 = io.pins.gpio20.into_push_pull_output();

    let row0 = io.pins.gpio0.into_floating_input();
    let row1 = io.pins.gpio1.into_floating_input();
    let row2 = io.pins.gpio2.into_floating_input();
    let row3 = io.pins.gpio3.into_floating_input();

    loop {
        c1.set_high();
        block!(timer0.wait()).unwrap();
        scan_col!(0, &["mod3", "mod2", "mod1", ""], row0, row1, row2, row3, count, state, serial0);
        c1.set_low();

        c2.set_high();
        block!(timer0.wait()).unwrap();
        scan_col!(1, &["x", "u", "ü", ""], row0, row1, row2, row3, count, state, serial0);
        c2.set_low();

        c3.set_high();
        block!(timer0.wait()).unwrap();
        scan_col!(2, &["v", "i", "ö", "t4"], row0, row1, row2, row3, count, state, serial0);
        c3.set_low();

        c4.set_high();
        block!(timer0.wait()).unwrap();
        scan_col!(3, &["l", "a", "ä", "t1"], row0, row1, row2, row3, count, state, serial0);
        c4.set_low();

        c5.set_high();
        block!(timer0.wait()).unwrap();
        scan_col!(4, &["c", "e", "p", "t2"], row0, row1, row2, row3, count, state, serial0);
        c5.set_low();

        c6.set_high();
        block!(timer0.wait()).unwrap();
        scan_col!(5, &["w", "o", "z", "t3"], row0, row1, row2, row3, count, state, serial0);
        c6.set_low();

        c7.set_high();
        block!(timer0.wait()).unwrap();
        scan_col!(6, &["i1", "i2", "", "t5"], row0, row1, row2, row3, count, state, serial0);
        c7.set_low();
    }
}

