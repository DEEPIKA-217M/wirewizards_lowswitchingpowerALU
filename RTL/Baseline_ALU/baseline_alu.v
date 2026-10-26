module alu_8bit (
    input  wire [7:0] A,         
    input  wire [7:0] B,        
    input  wire [3:0] ALU_Sel,    
    output reg  [7:0] ALU_Out,    
    output reg        CarryOut,   
    output wire       Zero        
);

    reg [8:0] temp; 
    
    assign Zero = (ALU_Out == 8'b0);

    always @(*) begin
        CarryOut = 1'b0;
        temp     = 9'b0;

        case (ALU_Sel)
           
            4'b0000: begin 
                temp     = {1'b0, A} + {1'b0, B};
                ALU_Out  = temp[7:0];
                CarryOut = temp[8]; 
            end

            4'b0001: begin 
                temp     = {1'b0, A} - {1'b0, B};
                ALU_Out  = temp[7:0];
                CarryOut = temp[8];  
            end

            4'b0010: begin 
                temp     = A * B;
                ALU_Out  = temp[7:0];
                CarryOut = |temp[8]; 
            end

            4'b0011: begin 
                if (B != 8'b0)
                    ALU_Out = A / B;
                else
                    ALU_Out = 8'hFF; 
            end

            
            4'b0100: ALU_Out = A << 1;               
            4'b0101: ALU_Out = A >> 1;                
            4'b0110: ALU_Out = {A[6:0], A[7]};       
            4'b0111: ALU_Out = {A[0], A[7:1]};        

           
            4'b1000: ALU_Out = A & B;                
            4'b1001: ALU_Out = A | B;                 
            4'b1010: ALU_Out = A ^ B;                 
            4'b1011: ALU_Out = ~(A | B);             
            4'b1100: ALU_Out = ~(A & B);              
            4'b1101: ALU_Out = ~(A ^ B);              

            
            4'b1110: ALU_Out = (A > B)  ? 8'd1 : 8'd0; 
            4'b1111: ALU_Out = (A == B) ? 8'd1 : 8'd0; 

            default: begin
                ALU_Out  = 8'b0;
                CarryOut = 1'b0;
            end
        endcase
    end

endmodule
