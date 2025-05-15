const std = @import("std");
const math = std.math;
const ArrayList = std.ArrayList;

//Type to represent a bitboard
//don't know why jujustu is saying nothing changed when I am clearly adding comments.
pub const bitboard: type = u64;

pub const Piece = enum {
    white_pawn,
    white_knight,
    white_bishop,
    white_rook,
    white_queen,
    white_king,
    black_pawn,
    black_knight,
    black_bishop,
    black_rook,
    black_queen,
    black_king,
};

pub const Move = struct {
    piece: Piece,
    from: u6,
    to: u6,
};

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

pub const all_white_pawn_starting_squares = A2 | B2 | C2 | D2 | E2 | F2 | G2 | H2;

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

//Function to print bitboard in semi-readable format for chess players.
pub fn print_bitboard(bb: bitboard) void {
    std.debug.print("   a b c d e f g h\n", .{});
    std.debug.print("   _ _ _ _ _ _ _ _\n", .{});
    var i: u6 = 0;
    while (i < 64) {
        //this is just logic to make the rank appear correctly
        if (i % 8 == 0) {
            var remainder = (i / 8);
            if (remainder == 0) {
                remainder += 8;
            } else {
                remainder = 8 - remainder;
            }
            std.debug.print("{d}| ", .{remainder});
        }
        //sets 1 for occupied squares and "_" for unoccupied
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

        //this prevents integer overflow which could break the program. I is u6, so the largest it can be is 63, when it reaches this value we don't want to increment it anymore.
        //further incrementing it will lead to integer overflow. All this occurs because bitwise operators in zig don't work on all integer types.
        //there might need to be exploration of the math library later.
        if (i == 63) {
            break;
        }
        i += 1;
    }

    std.debug.print("   _ _ _ _ _ _ _ _\n", .{});
    std.debug.print("   a b c d e f g h\n", .{});
}

pub fn generate_white_pawn_moves(white_pawns: bitboard, allOccupied: bitboard) ArrayList(Move) {

    //1. white pawns can only move one rank forward
    const single_push = white_pawns << 8 & ~allOccupied;

    var moves = ArrayList(Move).init(std.heap.page_allocator);
    if (single_push != 0) {
        var new_move: Move = .{ .piece = Piece.white_pawn, .from = 0, .to = 0 };
        new_move = Move{ .piece = Piece.white_pawn, .from = A2, .to = A3 };
        moves.append(new_move) catch unreachable;
    }
    return moves;
}

pub fn main() !void {
    const anum = 0b0000;
    var mybitboard: bitboard = undefined;
    mybitboard = anum;
    const generated_white_pawn_moves = generate_white_pawn_moves(all_white_pawn_starting_squares, mybitboard);

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    set_chessboard(&mybitboard);
    try stdout.print("This is my bitboard: {b:0>64}\n", .{mybitboard});
    try stdout.print("This is the population count: {d}\n", .{population_count(mybitboard)});
    try stdout.print("This is the bitboard for possible pawn move generation: {any}\n", .{generated_white_pawn_moves.items});

    try bw.flush();
    print_bitboard(mybitboard);
}
