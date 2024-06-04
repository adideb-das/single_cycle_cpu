module alu_decoder(aluop, funct3, funct7, op,alucontrol);
    input [1:0]aluop;
    input [2:0]funct3;
    input [6:0]funct7,op;
    output [2:0] alucontrol;


assign alucontrol =(aluop ==2'b00)?3'b000: //lw,sw
                   (aluop ==2'b01)?3'b001: //beq
                  ((aluop ==2'b10) & (funct3==3'b000) & ({op[5],funct7[5]}==2'b11))? 3'b001://sub  
                  ((aluop ==2'b10) & (funct3==3'b000) & ({op[5],funct7[5]}!=2'b11))? 3'b001://add
                  ((aluop ==2'b10) & (funct3==3'b010)) ? 3'b101: //slt
                  ((aluop ==2'b10) & (funct3==3'b110)) ? 3'b011: //or
                  ((aluop ==2'b10) & (funct3==3'b000)) ? 3'b010: //and
                                                        3'b000;
 endmodule