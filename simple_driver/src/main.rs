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

use uinput::event::keyboard;

use combwriter_protocol::{
    ScanCode, KeyState, KeyPosition, Part, Column, Row,
    map::{KeyValue, Command, Modifier, Prefix}
};

fn get_uinput_code(val: KeyValue) -> Vec<keyboard::Key> {
    match val {
        KeyValue::Modifier(Modifier::Select1) => vec![ keyboard::Key::LeftShift ],
        KeyValue::Modifier(Modifier::Select2) => vec![ keyboard::Key::CapsLock ],
        KeyValue::Modifier(Modifier::Select3) => vec![ keyboard::Key::Tab ],
        KeyValue::Prefix(Prefix::Ctrl) => vec![ keyboard::Key::LeftControl ],
        KeyValue::Prefix(Prefix::Super) => vec![],
        KeyValue::Prefix(Prefix::Alt) => vec![ keyboard::Key::LeftAlt ],
        KeyValue::Command(cmd) => {
            match cmd {
                Command::Up => vec![ keyboard::Key::Up ],
                Command::Dn => vec![ keyboard::Key::Down ],
                Command::Prev => vec![ keyboard::Key::Left ],
                Command::Next => vec![ keyboard::Key::Right ],
                Command::Begin => vec![ keyboard::Key::Home ],
                Command::End => vec![ keyboard::Key::End ],
                Command::DeletePrev => vec![ keyboard::Key::BackSpace ],
                Command::DeleteNext => vec![ keyboard::Key::Delete ],
                Command::PageUp => vec![ keyboard::Key::PageUp ],
                Command::PageDn => vec![ keyboard::Key::PageDown ],
                Command::Tab => vec![ keyboard::Key::Tab ],
                Command::Esc => vec![ keyboard::Key::Esc ],
                Command::Char(c) => {
                    match c {
                        ' ' => vec![ keyboard::Key::Space ],
                        '\n' => vec![ keyboard::Key::Enter ],
                        'x' => vec![ keyboard::Key::X ],
                        'v' => vec![ keyboard::Key::V ],
                        'l' => vec![ keyboard::Key::L ],
                        'c' => vec![ keyboard::Key::C ],
                        'w' => vec![ keyboard::Key::W ],
                        'k' => vec![ keyboard::Key::K ],
                        'h' => vec![ keyboard::Key::H ],
                        'g' => vec![ keyboard::Key::G ],
                        'f' => vec![ keyboard::Key::F ],
                        'q' => vec![ keyboard::Key::Q ],
                        'u' => vec![ keyboard::Key::U ],
                        'i' => vec![ keyboard::Key::I ],
                        'a' => vec![ keyboard::Key::A ],
                        'e' => vec![ keyboard::Key::E ],
                        'o' => vec![ keyboard::Key::O ],
                        's' => vec![ keyboard::Key::S ],
                        'n' => vec![ keyboard::Key::N ],
                        'r' => vec![ keyboard::Key::R ],
                        't' => vec![ keyboard::Key::T ],
                        'd' => vec![ keyboard::Key::D ],
                        'ü' => vec![ keyboard::Key::U ],
                        'ö' => vec![ keyboard::Key::O ],
                        'ä' => vec![ keyboard::Key::A ],
                        'p' => vec![ keyboard::Key::P ],
                        'z' => vec![ keyboard::Key::Z ],
                        'ß' => vec![ keyboard::Key::S ],
                        'm' => vec![ keyboard::Key::M ],
                        'b' => vec![ keyboard::Key::B ],
                        'y' => vec![ keyboard::Key::Y ],
                        'j' => vec![ keyboard::Key::J ],
                        '0' => vec![ keyboard::Key::_0 ],
                        '1' => vec![ keyboard::Key::_1 ],
                        '2' => vec![ keyboard::Key::_2 ],
                        '3' => vec![ keyboard::Key::_3 ],
                        '4' => vec![ keyboard::Key::_4 ],
                        '5' => vec![ keyboard::Key::_5 ],
                        '6' => vec![ keyboard::Key::_6 ],
                        '7' => vec![ keyboard::Key::_7 ],
                        '8' => vec![ keyboard::Key::_8 ],
                        '9' => vec![ keyboard::Key::_9 ],
                        '[' => vec![ keyboard::Key::LeftBrace ],
                        ']' => vec![ keyboard::Key::RightBrace ],
                        '/' => vec![ keyboard::Key::Slash ],
                        '\\' => vec![ keyboard::Key::BackSlash ],
                        '`' => vec![ keyboard::Key::Grave ],
                        '-' => vec![ keyboard::Key::Minus ],
                        '=' => vec![ keyboard::Key::Equal ],
                        ',' => vec![ keyboard::Key::Comma ],
                        '.' => vec![ keyboard::Key::Dot ],
                        ';' => vec![ keyboard::Key::SemiColon ],
                        '\'' => vec![ keyboard::Key::Apostrophe ],
                        '{' => vec![ keyboard::Key::LeftShift, keyboard::Key::LeftBrace ],
                        '}' => vec![ keyboard::Key::LeftShift, keyboard::Key::RightBrace ],
                        '|' => vec![ keyboard::Key::LeftShift, keyboard::Key::BackSlash ],
                        '~' => vec![ keyboard::Key::LeftShift, keyboard::Key::Grave ],
                        '!' => vec![ keyboard::Key::LeftShift, keyboard::Key::_1 ],
                        '@' => vec![ keyboard::Key::LeftShift, keyboard::Key::_2 ],
                        '#' => vec![ keyboard::Key::LeftShift, keyboard::Key::_3 ],
                        '$' => vec![ keyboard::Key::LeftShift, keyboard::Key::_4 ],
                        '%' => vec![ keyboard::Key::LeftShift, keyboard::Key::_5 ],
                        '^' => vec![ keyboard::Key::LeftShift, keyboard::Key::_6 ],
                        '&' => vec![ keyboard::Key::LeftShift, keyboard::Key::_7 ],
                        '*' => vec![ keyboard::Key::LeftShift, keyboard::Key::_8 ],
                        '(' => vec![ keyboard::Key::LeftShift, keyboard::Key::_9 ],
                        ')' => vec![ keyboard::Key::LeftShift, keyboard::Key::_0 ],
                        '?' => vec![ keyboard::Key::LeftShift, keyboard::Key::Slash ],
                        '_' => vec![ keyboard::Key::LeftShift, keyboard::Key::Minus ],
                        '+' => vec![ keyboard::Key::LeftShift, keyboard::Key::Equal ],
                        '<' => vec![ keyboard::Key::LeftShift, keyboard::Key::Comma ],
                        '>' => vec![ keyboard::Key::LeftShift, keyboard::Key::Dot ],
                        ':' => vec![ keyboard::Key::LeftShift, keyboard::Key::SemiColon ],
                        '"' => vec![ keyboard::Key::LeftShift, keyboard::Key::Apostrophe ],
                        _ => vec![],
                    }
                },
                Command::F(n) => {
                    match n {
                        1 => vec![ keyboard::Key::F1 ],
                        2 => vec![ keyboard::Key::F2 ],
                        3 => vec![ keyboard::Key::F3 ],
                        4 => vec![ keyboard::Key::F4 ],
                        5 => vec![ keyboard::Key::F5 ],
                        6 => vec![ keyboard::Key::F6 ],
                        7 => vec![ keyboard::Key::F7 ],
                        8 => vec![ keyboard::Key::F8 ],
                        9 => vec![ keyboard::Key::F9 ],
                        10 => vec![ keyboard::Key::F10 ],
                        11 => vec![ keyboard::Key::F11 ],
                        12 => vec![ keyboard::Key::F12 ],                        
                        _ => vec![]
                    }
                }
                _ => vec![]
            }
        }
        _ => vec![]
    }
}

/*
static NEO_CODES1: [[[keyboard::Key; 5]; 3];  2] = [
        [
            [keyboard::Key::W, keyboard::Key::C, keyboard::Key::L, keyboard::Key::V, keyboard::Key::X],
            [keyboard::Key::O, keyboard::Key::E, keyboard::Key::A, keyboard::Key::I, keyboard::Key::U],
            [keyboard::Key::Z, keyboard::Key::P, keyboard::Key::A, keyboard::Key::A, keyboard::Key::A],
        ],
        [
            [keyboard::Key::K, keyboard::Key::H, keyboard::Key::G, keyboard::Key::F, keyboard::Key::Q],
            [keyboard::Key::S, keyboard::Key::N, keyboard::Key::R, keyboard::Key::T, keyboard::Key::D],
            [keyboard::Key::A, keyboard::Key::M, keyboard::Key::B, keyboard::Key::Y, keyboard::Key::J]
        ]
];
*/
fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        panic!("Please specify input device!");
    }

    let layer_select = Arc::new(RwLock::new([false; 3]));
    let prefix_select = Arc::new(RwLock::new([false; 3]));
    let complex_keys = Arc::new(RwLock::new(Vec::new()));
    
    let mut join_handles = Vec::new();

    
    let mut device = Arc::new(RwLock::new(uinput::default().unwrap()
	.name("Combwriter").unwrap()
	.event(uinput::event::Keyboard::All).unwrap()
	.create().unwrap()));

    for i in 1 .. args.len() {
        let device_path = args[i].clone();

        std::process::Command::new("stty").arg("-F").arg(device_path.clone()).arg("raw")
            .output()
            .expect("Failed to set UART raw mode");
        std::process::Command::new("stty").arg("-F").arg(device_path.clone()).arg("speed").arg("115200")
            .output()
            .expect("Failed to set baud UART rate");

        let mut file = File::open(&device_path).expect("invalid path!");

        join_handles.push(std::thread::spawn({
            let layer_select = layer_select.clone();
            let prefix_select = prefix_select.clone();
            let device = device.clone();
            let complex_keys = complex_keys.clone();

            move || {
                loop {
                    let mut bytes = [0 as u8; 1];
                    file.read_exact(&mut bytes);

                    let mut sc = ScanCode::from_u8(bytes[0]);

                    let ps = *prefix_select.read().unwrap();
                    let ls = *layer_select.read().unwrap();
               
                    let value =
                        if ps[0] {
                            combwriter_protocol::map::get_neo_value(sc.pos, [false, ls[1], ls[2]])
                        } else { 
                            combwriter_protocol::map::get_neo_value(sc.pos, *layer_select.read().unwrap())
                        };

                    let mut dev = device.write().unwrap();
                    let mut ck = complex_keys.write().unwrap();

                    match sc.state {
                        KeyState::Pressed => {
                            match value {
                                KeyValue::Modifier(m) => {
                                    match m {
                                        Modifier::Select1 => {
                                            dev.press(&keyboard::Key::LeftShift);
                                        }
                                        Modifier::Select2 => {
                                            layer_select.write().unwrap()[1] = true;
                                        }
                                        Modifier::Select3 => {
                                            layer_select.write().unwrap()[2] = true;
                                        }
                                        Modifier::Repeat => {}
                                    }
                                },
                                KeyValue::Prefix(p) => {
                                    for v in get_uinput_code(value) {
                                        dev.press(&v);
                                    }
                                },
                                _ => {
                                    for v in get_uinput_code(value) {
                                        ck.push(v);
                                        dev.press(&v);
                                    }
                                }
                            }
                        },
                        KeyState::Released => {
                            match value {
                                KeyValue::Modifier(m) => {
                                    match m {
                                        Modifier::Select1 => {
                                            dev.release(&keyboard::Key::LeftShift);
                                        }
                                        Modifier::Select2 => {
                                            layer_select.write().unwrap()[1] = false;
                                        }
                                        Modifier::Select3 => {
                                            layer_select.write().unwrap()[2] = false;
                                        }
                                        Modifier::Repeat => {}
                                    }
                                }
                                KeyValue::Prefix(p) => {
                                    for v in get_uinput_code(value) {
                                        dev.release(&v);
                                    }
                                }
                                _ => {
                                    while let Some(v) = ck.pop() {
                                        dev.release(&v);
                                    }
                                }
                            }
                        }
                    }

                    dev.synchronize();
                }
            }
        }
        ));
    }

    for jh in join_handles {
        jh.join();
    }
    
}


