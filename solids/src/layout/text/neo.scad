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

text_left = [
	["", "X…Ξ", "V_√", "L\[Λ", "C]χ", "W^Ω", "\'»"],
        ["", "U\\⊂", "I/∫", "A{∀", "E}∃", "O*∈", ",:"],
	["",  "Ü#∪",  "Ö$∩", "Ä|",  "P~Π", "Z`ℤ", ""],
	["", "", "", "", "", ""],
];

text_right = [
        ["\"«", "K!×", "H<Ψ", "G>Γ", "F=Φ", "ẞς", ""],
	[".;", "S?Σ", "N(ℕ", "R)ℝ", "T-∂", "D:Δ", ""],
	["", "Q&",  "M%μ", "B+β", "Y@",  "J;Θ", ""],
	["",  "", "", "", "", ""],
];

function gtl(s,x,y) = [ if(s == 1) text_left[1-y][x+3] ];
function gtr(s,x,y) = [ if(s == -1) text_right[1-y][3-x] ];
function get_text(s, x, y) = concat(gtl(s,x,y), gtr(s,x,y));

