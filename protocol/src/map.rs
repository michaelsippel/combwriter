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

use crate::{KeyPosition, Row, Column, Part};

#[repr(u8)]
#[derive(Clone, Copy, Debug)]
pub enum Modifier {
    Select1 = 0,
    Select2 = 1,
    Select3 = 2,
    Repeat = 3
}

#[repr(u8)]
#[derive(Clone, Copy, Debug)]
pub enum Prefix {
    Ctrl = 0,
    Super = 1,
    Alt = 2
}

#[derive(Clone, Copy, Debug)]
pub enum Command {
    Up, Dn, Prev, Next, Begin, End,
    DeletePrev, DeleteNext,
    PageUp, PageDn,
    Tab, Esc,
    Char(char),
    F(u8)
}

#[derive(Clone, Copy, Debug)]
pub enum KeyValue {
    Prefix(Prefix),
    Modifier(Modifier),
    Command(Command)
}

static NEO_CHARS1: [[[char; 5]; 3];  2] = [
        [
            ['w', 'c', 'l', 'v', 'x'],
            ['o', 'e', 'a', 'i', 'u'],
            ['z', 'p', 'ä', 'ö', 'ü'],
        ],
        [
            ['k', 'h', 'g', 'f', 'q'],
            ['s', 'n', 'r', 't', 'd'],
            ['ß', 'm', 'b', 'y', 'j']
        ]
];
static NEO_CHARS2: [[[char; 5]; 3]; 2] = [
        [
            ['W', 'C', 'L', 'V', 'X'],
            ['O', 'E', 'A', 'I', 'U'],
            ['Z', 'P', 'Ä', 'Ö', 'Ü'],
        ],
        [
            ['K', 'H', 'G', 'F', 'Q'],
            ['S', 'N', 'R', 'T', 'D'],
            ['ẞ', 'M', 'B', 'Y', 'J']
        ]
];
static NEO_CHARS3: [[[char; 5]; 3]; 2] = [
        [
            ['^', ']', '[', '_', '…'],
            ['*', '}', '{', '/', '\\'],
            ['`', '~', '|', '$', '#'],
        ],
        [
            ['!', '<', '>', '=', '&'],
            ['?', '(', ')', '-', ':'],
            ['~', '+', '%', '@', ';']
        ]
];
static NEO_CMDS: [[[Option<Command>; 5]; 3]; 2] = [
    [
        [Some(Command::PageDn), Some(Command::DeleteNext), Some(Command::Up), Some(Command::DeletePrev), Some(Command::PageUp)],
        [Some(Command::End),  Some(Command::Next),       Some(Command::Dn), Some(Command::Prev),       Some(Command::Begin)],
        [None,            Some(Command::Tab),                None,        Some(Command::Esc),                None]
    ],
    [
        [None, Some(Command::Char('7')), Some(Command::Char('8')), Some(Command::Char('9')), None],
        [None, Some(Command::Char('4')), Some(Command::Char('5')), Some(Command::Char('6')), None],
        [None, Some(Command::Char('1')), Some(Command::Char('2')), Some(Command::Char('3')), None]
    ]
];

static NEO_F: [[[Option<Command>; 5]; 3]; 2] = [
    [
        [Some(Command::PageDn), Some(Command::DeleteNext), Some(Command::Up), Some(Command::DeletePrev), Some(Command::PageUp)],
        [Some(Command::End),  Some(Command::Next),       Some(Command::Dn), Some(Command::Prev),       Some(Command::Begin)],
        [None,            Some(Command::Tab),                None,        Some(Command::Esc),                None]
    ],
    [
        [None, Some(Command::F(7)), Some(Command::F(8)), Some(Command::F(9)), None],
        [None, Some(Command::F(4)), Some(Command::F(5)), Some(Command::F(6)), None],
        [None, Some(Command::F(1)), Some(Command::F(2)), Some(Command::F(3)), None]
    ]
];

fn map_get<T>(
    map: &[[[T; 5]; 3]; 2],
    pos: KeyPosition,
) -> &T {
    &map[pos.part as usize][pos.row as usize][pos.col as usize - 1]    
}

pub fn get_neo_value(
    pos: KeyPosition,
    layer_select: [bool; 3]
) -> KeyValue {
    if pos.row == Row::Thumb {
        match pos.col as u8 {
            0 => KeyValue::Prefix(Prefix::Super),
            1 => {
                match pos.part {
                    Part::Left => KeyValue::Command(Command::Char(' ')),
                    Part::Right => KeyValue::Command(
                        if layer_select[1] && layer_select[2] {
                            Command::F(10)
                        } else {
                            Command::Char(if layer_select[2] { '0' } else { '\n' })
                        }
                    ),
                }
            }
            2 => KeyValue::Prefix(Prefix::Alt),
            3 => KeyValue::Modifier(Modifier::Repeat),
            _ => KeyValue::Prefix(Prefix::Ctrl),
        }
    } else if pos.col == Column::Pinky1 {
        match pos.row {
            Row::Bot => KeyValue::Modifier(Modifier::Select1),
            Row::Mid => KeyValue::Modifier(Modifier::Select2),
            Row::Top => KeyValue::Modifier(Modifier::Select3),
            _ => panic!("invalid position")
        }
    } else if pos.col == Column::Index2 {
        match (pos.row, pos.part) {
            (Row::Top, Part::Left) => KeyValue::Command(Command::Char(',')),
            (Row::Top, Part::Right) => KeyValue::Command(Command::Char('.')),
            (Row::Mid, Part::Left) => KeyValue::Command(Command::Char('\'')),
            (Row::Mid, Part::Right) => KeyValue::Command(Command::Char('"')),
            _ => KeyValue::Command(Command::Char('*')),
        }
    } else {
        match layer_select {
            [true, false, false] => KeyValue::Command(Command::Char(*map_get(&NEO_CHARS2, pos))),
            [false, true, false] => KeyValue::Command(Command::Char(*map_get(&NEO_CHARS3, pos))),
            [false, false, true] => KeyValue::Command(map_get(&NEO_CMDS, pos).unwrap_or(Command::Char('?'))),
            [false, true, true] => KeyValue::Command(map_get(&NEO_F, pos).unwrap_or(Command::Char('?'))),
            _ => KeyValue::Command(Command::Char(*map_get(&NEO_CHARS1, pos)))
        }
    }
}

