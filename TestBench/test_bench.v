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

    initial begin
        
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_alu_8bit);

        $display("----------------------------------------------------------------------------------");
        $display(" Time |  A  |  B  | ALU_Sel (Op) | ALU_Out (Dec) | ALU_Out (Hex) | Carry | Zero ");
        $display("----------------------------------------------------------------------------------");
        $monitor(" %4t | %3d | %3d |    %b     |      %3d      |      0x%h     |   %b   |  %b  ",
                 $time, A, B, ALU_Sel, ALU_Out, ALU_Out, CarryOut, Zero);

        
        A = 8'd10;
        B = 8'd15;
        ALU_Sel = 4'b0000; 
        #20;

        
        A = 8'd25;
        B = 8'd10;
        ALU_Sel = 4'b0001; 
        #20;

        
        A = 8'd10;
        B = 8'd15;
        ALU_Sel = 4'b0010; 
        #20;

        
        A = 8'd10;
        B = 8'd15;
        ALU_Sel = 4'b1000; 
        #20;

        
        A = 8'd10;
        B = 8'd15;
        ALU_Sel = 4'b1001; 
        #20;

        
        A = 8'd200;
        B = 8'd60;
        ALU_Sel = 4'b0000; 
        #20;

       
        A = 8'd50;
        B = 8'd50;
        ALU_Sel = 4'b0001; 
        #20;

        #20;
        $finish;
    end

endmodule

