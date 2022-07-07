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

use std::sync::{Arc, RwLock};
use std::fs::File;
use std::io::prelude::*;
use std::io::Write;
use std::env;

use combwriter_protocol::{
    ScanCode, KeyState, KeyPosition, Part, Column, Row,
    map::{KeyValue, Command, Modifier, Prefix}
};

// start a ydotool if the command is not a character
fn ydotool_do_cmd(
    cmd: Command,
    prefixes: [bool; 3]
) {
    match (cmd, prefixes) {
        (Command::Char(c), [false, false, false]) => {
            print!("{}", c);
            std::io::stdout().flush().unwrap();
        },
        (cmd, prefixes) => {
            std::process::Command::new("ydotool").arg("key").arg(
            format!(
                "{}{}{}{}",
                if prefixes[Prefix::Ctrl as usize] { "ctrl+" } else {""},
                if prefixes[Prefix::Super as usize] { "super+" } else {""},
                if prefixes[Prefix::Alt as usize] { "alt+" } else {""},
                match cmd {
                        Command::Char(c) => c.to_string(),
                        Command::Up => String::from("up"),
                        Command::Dn => "down".into(),
                        Command::Prev => "left".into(),
                        Command::Next => "right".into(),
                        Command::DeletePrev => "backspace".into(),
                        Command::DeleteNext => "delete".into(),
                        Command::Begin => "home".into(),
                        Command::End => "end".into(),
                        Command::Tab => "tab".into(),
                        Command::PageUp => "PageUp".into(),
                        Command::PageDn => "PageDn".into(),
                }
            )).output().unwrap();
        }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        panic!("Please specify input device!");
    }

    let layer_select = Arc::new(RwLock::new([false; 3]));
    let prefix_select = Arc::new(RwLock::new([false; 3]));
    
    for i in 1 .. args.len() {
        let device_path = args[i].clone();

        std::process::Command::new("stty").arg("-F").arg(device_path.clone()).arg("raw")
            .output()
            .expect("Failed to set UART raw mode");
        std::process::Command::new("stty").arg("-F").arg(device_path.clone()).arg("-echo")
            .output()
            .expect("Failed to disable UART echo");
        std::process::Command::new("stty").arg("-F").arg(device_path.clone()).arg("-ispeed").arg("115200")
            .output()
            .expect("Failed to set baud UART rate");

        let mut file = File::open(&device_path).expect("invalid path!");

        std::thread::spawn({
            let layer_select = layer_select.clone();
            let prefix_select = prefix_select.clone();

            move || {
                loop {
                    let mut bytes = [0 as u8; 1];
                    file.read_exact(&mut bytes);

                    let mut sc = ScanCode::from_u8(bytes[0]);
                    let value = combwriter_protocol::map::get_neo_value(sc.pos, *layer_select.read().unwrap());

                    match sc.state {
                        KeyState::Pressed => {
                            match value {
                                KeyValue::Modifier(m) => {
                                    match m {
                                        Modifier::Select1 => {
                                            layer_select.write().unwrap()[0] = true;
                                        }
                                        Modifier::Select2 => {
                                            layer_select.write().unwrap()[1] = true;
                                        }
                                        Modifier::Select3 => {
                                            layer_select.write().unwrap()[2] = true;
                                        }
                                        Modifier::Repeat => {
                                            
                                        }
                                    }
                                }
                                KeyValue::Prefix(p) => {
                                    prefix_select.write().unwrap()[p as usize] = true;
                                }
                                KeyValue::Command(cmd) => {
                                    ydotool_do_cmd(cmd, *prefix_select.read().unwrap());
                                }
                            }
                        }

                        KeyState::Released => {
                            match value {
                                KeyValue::Modifier(m) => {
                                    match m {
                                        Modifier::Select1 => {
                                            layer_select.write().unwrap()[0] = false;
                                        }
                                        Modifier::Select2 => {
                                            layer_select.write().unwrap()[1] = false;
                                        }
                                        Modifier::Select3 => {
                                            layer_select.write().unwrap()[2] = false;
                                        }
                                        Modifier::Repeat => {
                                            
                                        }
                                    }
                                }
                                KeyValue::Prefix(p) => {
                                    prefix_select.write().unwrap()[p as usize] = false;
                                }
                                KeyValue::Command(cmd) => {
                                    
                                }
                            }
                        }
                        
                    }
                }
            }
            });
    }

    loop{}
}


