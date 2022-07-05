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

macro_rules! scan_col {
    ( $x:expr, $values:expr, $row0:ident, $row1:ident, $row2:ident, $row3:ident, $count:ident, $state:ident, $serial:ident ) => {
        scan_key!($values[0], $row0, $count[0*7+$x], $state[0*7+$x], $serial);
        scan_key!($values[1], $row1, $count[1*7+$x], $state[1*7+$x], $serial);
        scan_key!($values[2], $row2, $count[2*7+$x], $state[2*7+$x], $serial);
        scan_key!($values[3], $row3, $count[3*7+$x], $state[3*7+$x], $serial);
    }
}

macro_rules! colscanner {
    ($io:ident, $timer0: ident, $serial0: ident) =>
    {
        let mut count = [0; 4*7];
        let mut state = [false; 4*7];

        let mut c1 = $io.pins.gpio8.into_push_pull_output();
        let mut c2 = $io.pins.gpio7.into_push_pull_output();
        let mut c3 = $io.pins.gpio6.into_push_pull_output();
        let mut c4 = $io.pins.gpio5.into_push_pull_output();
        let mut c5 = $io.pins.gpio4.into_push_pull_output();
        let mut c6 = $io.pins.gpio9.into_push_pull_output();
        let mut c7 = $io.pins.gpio20.into_push_pull_output();

        let row0 = $io.pins.gpio0.into_floating_input();
        let row1 = $io.pins.gpio1.into_floating_input();
        let row2 = $io.pins.gpio2.into_floating_input();
        let row3 = $io.pins.gpio3.into_floating_input();

        loop {
            c1.set_high();
            block!($timer0.wait()).unwrap();
            scan_col!(0, &["mod3", "mod2", "mod1", ""], row0, row1, row2, row3, count, state, $serial0);
            c1.set_low();

            c2.set_high();
            block!($timer0.wait()).unwrap();
            scan_col!(1, &["x", "u", "ü", ""], row0, row1, row2, row3, count, state, $serial0);
            c2.set_low();

            c3.set_high();
            block!($timer0.wait()).unwrap();
            scan_col!(2, &["v", "i", "ö", "t4"], row0, row1, row2, row3, count, state, $serial0);
            c3.set_low();

            c4.set_high();
            block!($timer0.wait()).unwrap();
            scan_col!(3, &["l", "a", "ä", "t1"], row0, row1, row2, row3, count, state, $serial0);
            c4.set_low();

            c5.set_high();
            block!($timer0.wait()).unwrap();
            scan_col!(4, &["c", "e", "p", "t2"], row0, row1, row2, row3, count, state, $serial0);
            c5.set_low();

            c6.set_high();
            block!($timer0.wait()).unwrap();
            scan_col!(5, &["w", "o", "z", "t3"], row0, row1, row2, row3, count, state, $serial0);
            c6.set_low();

            c7.set_high();
            block!($timer0.wait()).unwrap();
            scan_col!(6, &["i1", "i2", "", "t5"], row0, row1, row2, row3, count, state, $serial0);
            c7.set_low();
        }
    }
}

