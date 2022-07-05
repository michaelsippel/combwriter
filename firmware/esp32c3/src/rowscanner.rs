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

macro_rules! scan_row {
    (
        $y:expr, $values:expr,
        $c0:ident, $c1:ident, $c2:ident, $c3:ident, $c4:ident, $c5:ident, $c6:ident,
        $count:ident, $state:ident, $serial:ident
    ) => {
        scan_key!($values[0], $c0, $count[7*$y+0], $state[7*$y+0], $serial);
        scan_key!($values[1], $c1, $count[7*$y+1], $state[7*$y+1], $serial);
        scan_key!($values[2], $c2, $count[7*$y+2], $state[7*$y+2], $serial);
        scan_key!($values[3], $c3, $count[7*$y+3], $state[7*$y+3], $serial);
        scan_key!($values[4], $c4, $count[7*$y+4], $state[7*$y+4], $serial);
        scan_key!($values[5], $c5, $count[7*$y+5], $state[7*$y+5], $serial);
        scan_key!($values[6], $c6, $count[7*$y+6], $state[7*$y+6], $serial);
    }
}

macro_rules! rowscanner {
    ($io:ident, $timer0: ident, $serial0: ident) =>
    {
        let mut count = [0; 4*7];
        let mut state = [false; 4*7];

        let col1 = $io.pins.gpio4.into_floating_input();
        let col2 = $io.pins.gpio5.into_floating_input();
        let col3 = $io.pins.gpio3.into_floating_input();
        let col4 = $io.pins.gpio7.into_floating_input();
        let col5 = $io.pins.gpio2.into_floating_input();
        let col6 = $io.pins.gpio0.into_floating_input();
        let col7 = $io.pins.gpio1.into_floating_input();

        let mut row0 = $io.pins.gpio10.into_push_pull_output();
        let mut row1 = $io.pins.gpio6.into_push_pull_output();
        let mut row2 = $io.pins.gpio8.into_push_pull_output();
        let mut row3 = $io.pins.gpio9.into_push_pull_output();

        block!($timer0.wait()).unwrap();

        loop {
            row0.set_high().unwrap();
            block!($timer0.wait()).unwrap();
            scan_row!(0, &["i2", "k", "h", "g", "f", "ß", "mod3"], col1, col2, col3, col4, col5, col6, col7, count, state, $serial0);
            row0.set_low().unwrap();
            block!($timer0.wait()).unwrap();

            row1.set_high().unwrap();
            block!($timer0.wait()).unwrap();
            scan_row!(1, &["i1", "s", "n", "r", "t", "d", "mod2"], col1, col2, col3, col4, col5, col6, col7, count, state, $serial0);
            row1.set_low().unwrap();
            block!($timer0.wait()).unwrap();

            row2.set_high().unwrap();
            block!($timer0.wait()).unwrap();
            scan_row!(2, &["t8", "q", "m", "b", "y", "j", "mod1"], col1, col2, col3, col4, col5, col6, col7, count, state, $serial0);
            row2.set_low().unwrap();
            block!($timer0.wait()).unwrap();

            row3.set_high().unwrap();
            block!($timer0.wait()).unwrap();
            scan_row!(3, &["t1", "t2", "t3", "t4", "t5", "t6", "t7"], col1, col2, col3, col4, col5, col6, col7, count, state, $serial0);
            row3.set_low().unwrap();
            block!($timer0.wait()).unwrap();
        }
    }
}
