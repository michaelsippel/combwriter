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

macro_rules! scan_key {
    ( $c:expr, $in:ident, $count:expr, $state:expr, $serial:ident ) => {
        if let Ok(inp) = $in.is_high() {
            if $state != inp {
                if $count == 0 {
                    // was stable long enough, take the change
                    $state = inp;

                    if $state {
                        writeln!($serial, "press {}", $c).unwrap();
                    } else {
                        writeln!($serial, "release {}", $c).unwrap();
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

