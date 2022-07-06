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

use combwriter_protocol::{ScanCode, KeyPosition, KeyState};

macro_rules! scan_key {
    ( $in:ident, $x:expr, $y:expr, $part:expr, $count:expr, $state:expr, $serial:ident ) => {
        if let Ok(inp) = $in.is_high() {
            let idx = $y * 7 + $x;
            if $state[idx] != inp {
                if $count[idx] == 0 {
                    // was stable long enough, take the change
                    $state[idx] = inp;

                    let scan_code = ScanCode {
                        pos: KeyPosition::from_scan($x, $y, $part),
                        state: KeyState::from_bool(inp)
                    };

                    $serial.write(scan_code.encode_u8()).unwrap();
                }

                // reset timer
                $count[idx] = 20;
            } else if $count[idx] > 0 {
                $count[idx] -= 1;
            }
        }
    }
}

