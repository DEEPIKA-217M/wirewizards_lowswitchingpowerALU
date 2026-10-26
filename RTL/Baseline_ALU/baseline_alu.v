module alu_isolated (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [2:0] op,
    output reg  [7:0] Y
);

   
    wire en_arith;
    wire en_logic;
    wire en_shift;

    assign en_arith = (op == 3'b000) || (op == 3'b001);

    assign en_logic = (op == 3'b010) ||
                      (op == 3'b011) ||
                      (op == 3'b100) ||
                      (op == 3'b101);

    assign en_shift = (op == 3'b110) || (op == 3'b111);

    
    wire [7:0] A_arith = A & {8{.}};
    wire [7:0] B_arith = B & {8{en_arith}};

    wire [7:0] A_logic = A & {8{en_logic}};
    wire [7:0] B_logic = B & {8{en_logic}};

    wire [7:0] A_shift = A & {8{en_shift}};
    wire [7:0] B_shift = B & {8{en_shift}};

    
    wire [7:0] add_result = A_arith + B_arith;
    wire [7:0] sub_result = A_arith - B_arith;

    wire [7:0] and_result = A_logic & B_logic;
    wire [7:0] or_result  = A_logic | B_logic;
    wire [7:0] xor_result = A_logic ^ B_logic;
    wire [7:0] not_result = ~A_logic;

    wire [7:0] left_result  = A_shift << B_shift[2:0];
    wire [7:0] right_result = A_shift >> B_shift[2:0];

    
    always @(*) begin
        case (op)
            3'b000: Y = add_result;
            3'b001: Y = sub_result;
            3'b010: Y = and_result;
            3'b011: Y = or_result;
            3'b100: Y = xor_result;
            3'b101: Y = ~A;
            3'b110: Y = left_result;
            3'b111: Y = right_result;
            default: Y = 8'b0;
        endcase
    end

endmodule
