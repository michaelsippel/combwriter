#![no_std]

#[repr(u8)]
#[derive(Clone, Copy, PartialEq)]
pub enum KeyState {
    Released = 0,
    Pressed = 1,
}

#[repr(u8)]
#[derive(Clone, Copy, PartialEq)]
pub enum Column {
    Index2 = 0,
    Index1 = 1,
    Index0 = 2,
    Middle = 3,
    Ring = 4,
    Pinky0 = 5,
    Pinky1 = 6,
}

#[repr(u8)]
#[derive(Clone, Copy, PartialEq)]
pub enum Row {
    Top = 0,
    Mid = 1,
    Bot = 2,
    Thumb = 3,
}

#[repr(u8)]
#[derive(Clone, Copy, PartialEq)]
pub enum Part {
    Left = 0,
    Right = 1
}

#[derive(Clone, Copy, PartialEq)]
pub struct KeyPosition {
    pub col: Column,
    pub row: Row,
    pub part: Part
}

impl Row {
    pub fn from_u8(i: u8) -> Self {
        match i {
            0 => Row::Top,
            1 => Row::Mid,
            2 => Row::Bot,
            _ => Row::Thumb
        }
    }
}

impl Column {
    pub fn from_u8(i: u8) -> Self {
        match i {
            0 => Column::Index2,
            1 => Column::Index1,
            2 => Column::Index0,
            3 => Column::Middle,
            4 => Column::Ring,
            5 => Column::Pinky0,
            _ => Column::Pinky1,
        }
    }
}

impl Part {
    pub fn from_u8(i: u8) -> Self {
        match i {
            0 => Part::Left,
            _ => Part::Right
        }
    }
}

impl KeyState {
    pub fn from_bool(s: bool) -> Self {
        match s {
            false => KeyState::Released,
            true => KeyState::Pressed
        }
    }

    pub fn from_u8(s: u8) -> Self {
        match s {
            0 => KeyState::Released,
            _ => KeyState::Pressed
        }
    }
}

impl KeyPosition {
    pub fn encode_u8(&self) -> u8 {
        (self.col as u8 & 0x7) |
        (self.row as u8 & 0x3) << 3 |
        (self.part as u8 & 0x1) << 5
    }

    // swap positions to compensate irregularities in PCB layout
    pub fn from_scan(mut x: u8, y: u8, part: Part) -> Self {
        if y == 3 {
            if x == 0 {
                x = 4;
            } else if x == 4 {
                x = 0;
            }
        }

        KeyPosition { col: Column::from_u8(x), row: Row::from_u8(y), part }
    }

    pub fn from_u8(psc: u8) -> Self {
        KeyPosition {
            col: Column::from_u8((psc >> 0) & 0x7),
            row: Row::from_u8((psc >> 3) & 0x3),
            part: Part::from_u8((psc >> 5) & 1),
        }
    }
}

pub struct ScanCode {
    pub pos: KeyPosition,
    pub state: KeyState
}

impl ScanCode {
    pub fn encode_u8(&self) -> u8 {
        self.pos.encode_u8() | ((self.state as u8) << 6)
    }

    pub fn from_u8(s: u8) -> Self {
        ScanCode {
            pos: KeyPosition::from_u8(s),
            state: if (s>>6) & 1 == 1 {
                KeyState::Pressed
            } else {
                KeyState::Released
            }
        }
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        let result = 2 + 2;
        assert_eq!(result, 4);
    }
}
