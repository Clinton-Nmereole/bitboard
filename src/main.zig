const std = @import("std");

//Type to represent a bitboard
//don't know why jujustu is saying nothing changed when I am clearly adding comments.
pub const bitboard: type = u64;

pub const A1 = 0;
pub const B1 = 1;
pub const C1 = 2;
pub const D1 = 3;
pub const E1 = 4;
pub const F1 = 5;
pub const G1 = 6;
pub const H1 = 7;
pub const A2 = 8;
pub const B2 = 9;
pub const C2 = 10;
pub const D2 = 11;
pub const E2 = 12;
pub const F2 = 13;
pub const G2 = 14;
pub const H2 = 15;
pub const A3 = 16;
pub const B3 = 17;
pub const C3 = 18;
pub const D3 = 19;
pub const E3 = 20;
pub const F3 = 21;
pub const G3 = 22;
pub const H3 = 23;
pub const A4 = 24;
pub const B4 = 25;
pub const C4 = 26;
pub const D4 = 27;
pub const E4 = 28;
pub const F4 = 29;
pub const G4 = 30;
pub const H4 = 31;
pub const A5 = 32;
pub const B5 = 33;
pub const C5 = 34;
pub const D5 = 35;
pub const E5 = 36;
pub const F5 = 37;
pub const G5 = 38;
pub const H5 = 39;
pub const A6 = 40;
pub const B6 = 41;
pub const C6 = 42;
pub const D6 = 43;
pub const E6 = 44;
pub const F6 = 45;
pub const G6 = 46;
pub const H6 = 47;
pub const A7 = 48;
pub const B7 = 49;
pub const C7 = 50;
pub const D7 = 51;
pub const E7 = 52;
pub const F7 = 53;
pub const G7 = 54;
pub const H7 = 55;
pub const A8 = 56;
pub const B8 = 57;
pub const C8 = 58;
pub const D8 = 59;
pub const E8 = 60;
pub const F8 = 61;
pub const G8 = 62;
pub const H8 = 63;

pub const all_piece_starting_squares = [_]u6{ A1, B1, C1, D1, E1, F1, G1, H1, A2, B2, C2, D2, E2, F2, G2, H2, A7, B7, C7, D7, E7, F7, G7, H7, A8, B8, C8, D8, E8, F8, G8, H8 };
pub const all_white_piece_starting_squares = [_]u6{ A1, B1, C1, D1, E1, F1, G1, H1, A2, B2, C2, D2, E2, F2, G2, H2 };
pub const all_black_piece_starting_squares = [_]u6{ A7, B7, C7, D7, E7, F7, G7, H7, A8, B8, C8, D8, E8, F8, G8, H8 };

//Function to set a bit on a bitboard
pub fn set_bit(bb: *bitboard, square: u6) void {
    bb.* |= (@as(u64, 1) << square);
}

//Function to clear a bit on a bitboard
pub fn clear_bit(bb: *bitboard, square: u6) void {
    bb.* &= ~(@as(u64, 1) << square);
}

//Function to check if a bit is set on a bitboard
pub fn is_set(bb: bitboard, square: u6) bool {
    return (bb & (@as(u64, 1) << square)) != 0;
}

//Function to get the bitboard for a single square
pub fn get_bitboard(square: u6) bitboard {
    return (@as(u64, 1) << square);
}

//Function to perform population count on a bitboard
pub fn population_count(bb: bitboard) u6 {
    var count: u6 = 0;
    var i = bb;
    while (i != 0) {
        i &= (i - 1);
        count += 1;
    }
    return count;
}

//Function to set entire chessboard
pub fn set_chessboard(bb: *bitboard) void {
    for (all_piece_starting_squares) |square| {
        set_bit(bb, square);
    }
}

//Function to clear entire chessboard
pub fn clear_chessboard(bb: *bitboard) void {
    for (all_piece_starting_squares) |square| {
        clear_bit(bb, square);
    }
}

//Function to set entire white chessboard
pub fn set_white_chessboard(bb: *bitboard) void {
    for (all_white_piece_starting_squares) |square| {
        set_bit(bb, square);
    }
}

//Function to clear entire white chessboard
pub fn clear_white_chessboard(bb: *bitboard) void {
    for (all_white_piece_starting_squares) |square| {
        clear_bit(bb, square);
    }
}

//Function to set entire black chessboard
pub fn set_black_chessboard(bb: *bitboard) void {
    for (all_black_piece_starting_squares) |square| {
        set_bit(bb, square);
    }
}

//Function to clear entire black chessboard
pub fn clear_black_chessboard(bb: *bitboard) void {
    for (all_black_piece_starting_squares) |square| {
        clear_bit(bb, square);
    }
}

//Function currently breaks due to u6 overflow
pub fn print_bitboard(bb: bitboard) void {
    std.debug.print("   a b c d e f g h\n", .{});
    std.debug.print("   _ _ _ _ _ _ _ _\n", .{});
    var i: u6 = 0;
    while (i < 64) {
        if (i % 8 == 0) {
            var remainder = (i / 8);
            if (remainder == 0) {
                remainder += 8;
            } else {
                remainder = 8 - remainder;
            }
            std.debug.print("{d}| ", .{remainder});
        }
        if (is_set(bb, i)) {
            std.debug.print("1 ", .{});
        } else {
            std.debug.print("_ ", .{});
        }
        if (i % 8 == 7) {
            var remainder = (i / 8);
            if (remainder == 0) {
                remainder += 8;
            } else {
                remainder = 8 - remainder;
            }

            std.debug.print(" |{d}\n", .{remainder});
        }

        if (i == 63) {
            break;
        }
        i += 1;
    }

    std.debug.print("   _ _ _ _ _ _ _ _\n", .{});
    std.debug.print("   a b c d e f g h\n", .{});
}

pub fn main() !void {
    const anum = 0b0000;
    var mybitboard: bitboard = undefined;
    mybitboard = anum;
    const white_pawn_bitboard: bitboard = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1111_1111_0000_0000;
    const white_rook_bitboard: bitboard = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1000_0001;
    const white_knight_bitboard: bitboard = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0100_0010;
    const white_bishop_bitboard: bitboard = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0010_0100;
    const white_queen_bitboard: bitboard = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001_0000;
    const white_king_bitboard: bitboard = 0b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1000;
    const all_white_bitboard: bitboard = white_pawn_bitboard | white_rook_bitboard | white_knight_bitboard | white_bishop_bitboard | white_queen_bitboard | white_king_bitboard;

    const black_pawn_bitboard: bitboard = 0b0000_0000_1111_1111_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
    const black_rook_bitboard: bitboard = 0b1000_0001_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
    const black_knight_bitboard: bitboard = 0b0100_0010_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
    const black_bishop_bitboard: bitboard = 0b0010_0100_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
    const black_queen_bitboard: bitboard = 0b0001_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
    const black_king_bitboard: bitboard = 0b0000_1000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
    const all_black_bitboard: bitboard = black_pawn_bitboard | black_rook_bitboard | black_knight_bitboard | black_bishop_bitboard | black_queen_bitboard | black_king_bitboard;

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    set_chessboard(&mybitboard);

    try stdout.print("White Pawn Bitboard says: {d}\n", .{white_pawn_bitboard});
    try stdout.print("Black Pawn Bitboard says: {d}\n", .{black_pawn_bitboard});
    try stdout.print("White Rook Bitboard says: {d}\n", .{white_rook_bitboard});
    try stdout.print("White Knight Bitboard says: {d}\n", .{white_knight_bitboard});
    try stdout.print("White Bishop Bitboard says: {d}\n", .{white_bishop_bitboard});
    try stdout.print("White Queen Bitboard says: {d}\n", .{white_queen_bitboard});
    try stdout.print("White King Bitboard says: {d}\n", .{white_king_bitboard});
    try stdout.print("All White Bitboard says: {b:0>64}\n", .{all_white_bitboard});
    try stdout.print("All Black Bitboard says: {b:0>64}\n", .{all_black_bitboard});
    try stdout.print("This is my bitboard: {b:0>64}\n", .{mybitboard});
    try stdout.print("This is the population count: {d}\n", .{population_count(mybitboard)});

    try bw.flush();
    print_bitboard(mybitboard);
}
