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

use combwriter_protocol::{
    ScanCode, KeyState, KeyPosition, Part
};

macro_rules! scan_row {
    (
        $part:expr, $y:expr,
        $count:ident, $state:ident,
        $r:ident, $c0:ident, $c1:ident, $c2:ident, $c3:ident, $c4:ident, $c5:ident, $c6:ident,
        $serial:ident, $timer:ident
    ) => {

        $r.set_high().unwrap();
        block!($timer.wait()).unwrap();

        scan_key!($c0, 0, $y, $part, $count, $state, $serial);
        scan_key!($c1, 1, $y, $part, $count, $state, $serial);
        scan_key!($c2, 2, $y, $part, $count, $state, $serial);
        scan_key!($c3, 3, $y, $part, $count, $state, $serial);
        scan_key!($c4, 4, $y, $part, $count, $state, $serial);
        scan_key!($c5, 5, $y, $part, $count, $state, $serial);
        scan_key!($c6, 6, $y, $part, $count, $state, $serial);

        $r.set_low().unwrap();
        block!($timer.wait()).unwrap();
    }
}

macro_rules! rowscanner {
    ($io:ident, $timer0: ident, $serial0: ident, $part: expr) =>
    {
        let mut count = [0; 4*7];
        let mut state = [false; 4*7];

        let col0 = $io.pins.gpio4.into_floating_input();
        let col1 = $io.pins.gpio5.into_floating_input();
        let col2 = $io.pins.gpio7.into_floating_input();
        let col3 = $io.pins.gpio2.into_floating_input();
        let col4 = $io.pins.gpio3.into_floating_input();
        let col5 = $io.pins.gpio0.into_floating_input();
        let col6 = $io.pins.gpio1.into_floating_input();

        let mut row0 = $io.pins.gpio10.into_push_pull_output();
        let mut row1 = $io.pins.gpio6.into_push_pull_output();
        let mut row2 = $io.pins.gpio8.into_push_pull_output();
        let mut row3 = $io.pins.gpio9.into_push_pull_output();

        block!($timer0.wait()).unwrap();

        loop {
            scan_row!(
                $part, 0,
                count, state,
                row0, col0, col1, col2, col3, col4, col5, col6,
                $serial0, $timer0
            );
            scan_row!(
                $part, 1,
                count, state,
                row1, col0, col1, col2, col3, col4, col5, col6,
                $serial0, $timer0
            );
            scan_row!(
                $part, 2,
                count, state,
                row2, col0, col1, col2, col3, col4, col5, col6,
                $serial0, $timer0
            );
            scan_row!(
                $part, 3,
                count, state,
                row3, col0, col1, col2, col3, col4, col5, col6,
                $serial0, $timer0
            );
        }
    }
}
