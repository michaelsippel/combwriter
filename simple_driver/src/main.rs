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

use std::process::Command;

use std::sync::{Arc, RwLock};
use std::fs::File;
use std::io::prelude::*;
use std::io::Write;
use std::env;

use combwriter_protocol::{
    ScanCode, KeyState, KeyPosition, Part, Column, Row
};


fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        panic!("Please specify input device!");
    }

    let mod_state = Arc::new(RwLock::new((false, false, false)));
    
    for i in 1 .. args.len() {
        let device_path = args[i].clone();

        Command::new("stty").arg("-F").arg(device_path.clone()).arg("raw")
            .output()
            .expect("Failed to set UART raw mode");
        Command::new("stty").arg("-F").arg(device_path.clone()).arg("-echo")
            .output()
            .expect("Failed to disable UART echo");
        Command::new("stty").arg("-F").arg(device_path.clone()).arg("-ispeed").arg("115200")
            .output()
            .expect("Failed to set baud UART rate");

        let mut file = File::open(&device_path).expect("invalid path!");

        std::thread::spawn({
            let mod_state = mod_state.clone();
            move || {
                loop {
            let mut bytes = [0 as u8; 1];
            file.read_exact(&mut bytes);

            let mut sc = ScanCode::from_u8(bytes[0]);

                    if sc.pos.col == Column::Pinky1 {
                        if sc.pos.row == Row::Top {
                            if sc.state == KeyState::Pressed {
                                mod_state.write().unwrap().2 = true;
                            } else {
                                mod_state.write().unwrap().2 = false;
                            }
                        }
                        if sc.pos.row == Row::Mid {
                            if sc.state == KeyState::Pressed {
                                mod_state.write().unwrap().1 = true;
                            } else {
                                mod_state.write().unwrap().1 = false;
                            }
                        }
                        if sc.pos.row == Row::Bot {
                            if sc.state == KeyState::Pressed {
                                mod_state.write().unwrap().0 = true;
                            } else {
                                mod_state.write().unwrap().0 = false;
                            }
                        }
                    }

                    if sc.state == KeyState::Pressed {
                        match *mod_state.read().unwrap() {
                            (false, false, false) => {
                                if let Some(mut c) = get_char(sc.pos) {
                                    print!("{}", c);
                                    std::io::stdout().flush();
                                }
                            },
                            (true, false, false) => {
                                if let Some(mut c) = get_char(sc.pos) {
                                    print!("{}", c.to_ascii_uppercase());
                                    std::io::stdout().flush();
                                }
                            }
                            (false, true, false) => {
                                if let Some(mut c) = get_special_char(sc.pos) {
                                    print!("{}", c);
                                    std::io::stdout().flush();
                                }
                            }
                            (false, false, true) => {
                                match sc.pos.row {
                                    Row::Top => {
                                        match sc.pos.col {
                                            Column::Ring => {
                                                Command::new("ydotool").arg("key").arg("backspace").output().expect("");
                                            }
                                            Column::Middle => {
                                                Command::new("ydotool").arg("key").arg("up").output().expect("");
                                            }
                                            Column::Index0 => {
                                                Command::new("ydotool").arg("key").arg("delete").output().expect("");
                                            }
                                            _ => {}                                            
                                        }
                                    }
                                    Row::Mid => {
                                        match sc.pos.col {
                                            Column::Pinky0 => {
                                                Command::new("ydotool").arg("key").arg("home").output().expect("");
                                            }
                                            Column::Ring => {
                                                Command::new("ydotool").arg("key").arg("left").output().expect("");
                                            }
                                            Column::Middle => {
                                                Command::new("ydotool").arg("key").arg("down").output().expect("");
                                            },
                                            Column::Index0 => {
                                                Command::new("ydotool").arg("key").arg("right").output().expect("");
                                            }
                                            _ => {}
                                        }
                                    }
                                    Row::Bot => {
                                        match sc.pos.col {
                                            Column::Middle => {
                                                Command::new("ydotool").arg("key").arg("down").output().expect("");
                                            },
                                            _ => {}
                                        }
                                    }
                                    Row::Thumb => {
                                        match sc.pos.col as u8 {
                                        1 => {
                                            Command::new("ydotool").arg("key").arg("end").output().expect("");
                                        }
                                            _=> {}
                                        }
                                    }
                                    _ => {}
                                }
                            }
                            _ => {}
                        }
                    }
                }
            }
            });
    }

    loop{}
}

fn get_char(
    pos: KeyPosition
) -> Option<char>
{
    match pos {
        KeyPosition {
            part: Part::Left,
            row: row,
            col: col
        } => {
            match row {
                Row::Top => {
                    match col {
                        Column::Pinky0 => Some('x'),
                        Column::Ring => Some('v'),
                        Column::Middle => Some('l'),
                        Column::Index0 => Some('c'),
                        Column::Index1 => Some('w'),
                        Column::Index2 => Some('\''),
                        _=> None
                    }
                },
                Row::Mid => {
                    match col {
                        Column::Pinky0 => Some('u'),
                        Column::Ring => Some('i'),
                        Column::Middle => Some('a'),
                        Column::Index0 => Some('e'),
                        Column::Index1 => Some('o'),
                        Column::Index2 => Some('"'),
                        _ => None
                    }
                },
                Row::Bot => {
                    match col {
                        Column::Pinky0 => Some('ü'),
                        Column::Ring => Some('ö'),
                        Column::Middle => Some('ä'),
                        Column::Index0 => Some('p'),
                        Column::Index1 => Some('z'),
                        Column::Index2 => Some('»'),
                        _ => None
                    }
                },
                Row::Thumb => {
                    match col as u8 {
                        0 => Some(','),
                        1 => Some(' '),
                        _ => None
                    }
                }
            }
        }

        KeyPosition {
            part: Part::Right,
            row: row,
            col: col
        } => {
            match row {
                Row::Top => {
                    match col {
                        Column::Index2 => Some('\''),
                        Column::Index1 => Some('k'),
                        Column::Index0 => Some('h'),
                        Column::Middle => Some('g'),
                        Column::Ring => Some('f'),
                        Column::Pinky0 => Some('ß'),
                        _=> None
                    }
                },
                Row::Mid => {
                    match col {
                        Column::Index2 => Some('"'),
                        Column::Index1 => Some('s'),
                        Column::Index0 => Some('n'),
                        Column::Middle => Some('r'),
                        Column::Ring => Some('t'),
                        Column::Pinky0 => Some('d'),
                        _=> None
                    }
                },
                Row::Bot => {
                    match col {
                        Column::Index2 => Some('«'),
                        Column::Index1 => Some('b'),
                        Column::Index0 => Some('m'),
                        Column::Middle => Some('q'),
                        Column::Ring => Some('y'),
                        Column::Pinky0 => Some('j'),
                        _=> None
                    }
                },
                Row::Thumb => {
                    match col as u8 {
                        0 => Some('.'),
                        1 => Some('\n'),
                        _ => None
                    }
                }
            }
        }
    }
}


fn get_special_char(
    pos: KeyPosition
) -> Option<char>
{
    match pos {
        KeyPosition {
            part: Part::Left,
            row: row,
            col: col
        } => {
            match row {
                Row::Top => {
                    match col {
                        Column::Pinky0 => Some('…'),
                        Column::Ring => Some('_'),
                        Column::Middle => Some('['),
                        Column::Index0 => Some(']'),
                        Column::Index1 => Some('^'),
                        Column::Index2 => None,
                        _=> None
                    }
                },
                Row::Mid => {
                    match col {
                        Column::Pinky0 => Some('\\'),
                        Column::Ring => Some('/'),
                        Column::Middle => Some('{'),
                        Column::Index0 => Some('}'),
                        Column::Index1 => Some('*'),
                        Column::Index2 => Some('?'),
                        _ => None
                    }
                },
                Row::Bot => {
                    match col {
                        Column::Pinky0 => Some('#'),
                        Column::Ring => Some('$'),
                        Column::Middle => Some('|'),
                        Column::Index0 => Some('~'),
                        Column::Index1 => Some('`'),
                        Column::Index2 => None,
                        _ => None
                    }
                },
                Row::Thumb => {
                    match col as u8 {
                        _ => None
                    }
                }
            }
        }

        KeyPosition {
            part: Part::Right,
            row: row,
            col: col
        } => {
            match row {
                Row::Top => {
                    match col {
                        Column::Index1 => Some('!'),
                        Column::Index0 => Some('<'),
                        Column::Middle => Some('>'),
                        Column::Ring => Some('='),
                        _=> None
                    }
                },
                Row::Mid => {
                    match col {
                        Column::Index1 => Some('?'),
                        Column::Index0 => Some('('),
                        Column::Middle => Some(')'),
                        Column::Ring => Some('-'),
                        Column::Pinky0 => Some(':'),
                        _=> None
                    }
                },
                Row::Bot => {
                    match col {
                        Column::Index1 => Some('+'),
                        Column::Index0 => Some('%'),
                        Column::Middle => Some('&'),
                        Column::Ring => Some('@'),
                        Column::Pinky0 => Some(';'),
                        _=> None
                    }
                },
                Row::Thumb => {
                    match col as u8 {
                        0 => Some('.'),
                        1 => Some('\n'),
                        _ => None
                    }
                }
            }
        }
    }
}



