`timescale 1ns/1ps

module alu_tb;
    reg  [7:0] A, B;
    reg  [2:0] op;
    wire [7:0] Y;

`ifdef ISO
    alu_isolated dut (.A(A), .B(B), .op(op), .Y(Y));
`else
    alu_baseline dut (.A(A), .B(B), .op(op), .Y(Y));
`endif

    integer i, seed, burst;
    reg [255:0] vcdname;
    reg [31:0]  checksum;

    initial begin
        if (!$value$plusargs("VCD=%s", vcdname))  vcdname = "alu.vcd";
        if (!$value$plusargs("BURST=%d", burst))  burst = 16;
        $dumpfile(vcdname);
        $dumpvars(0, alu_tb);

        seed = 1;                 
        checksum = 0;
        A = 0; B = 0; op = 0;
        #10;

        for (i = 0; i < 2000; i = i + 1) begin
            if (i % burst == 0) op = $random(seed);
            A = $random(seed);
            B = $random(seed);
            #10;                  
            checksum = checksum * 31 + Y;
        end

        $display("burst=%0d checksum=%0h", burst, checksum);
        $finish;
    end
endmodule
