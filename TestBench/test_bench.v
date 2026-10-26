`timescale 1ns / 1ps

module tb_alu_8bit;

    reg  [7:0] A;
    reg  [7:0] B;
    reg  [3:0] ALU_Sel;
    wire [7:0] ALU_Out;
    wire       CarryOut;
    wire       Zero;

    alu_8bit uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut),
        .Zero(Zero)
    );

    integer i;

    initial begin
        $monitor("Time=%0t | Sel=%b | A=%d | B=%d | Out=%d | Carry=%b | Zero=%b",
                 $time, ALU_Sel, A, B, ALU_Out, CarryOut, Zero);

        A = 8'd15;
        B = 8'd10;

        for (i = 0; i < 16; i = i + 1) begin
            ALU_Sel = i[3:0];
            #10;
        end

        A = 8'd200;
        B = 8'd60;
        ALU_Sel = 4'b0000;
        #10;

        A = 8'd50;
        B = 8'd50;
        ALU_Sel = 4'b0001;
        #10;

        $finish;
    end

endmodule
