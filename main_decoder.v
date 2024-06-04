module main_decoder(op,regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop);
    input [6:0]op;
    output regwrite,alusrc,memwrite,resultsrc,branch;
    output [1:0]immsrc,aluop;

    assign regwrite = (op == 7'b0000011 | op == 7'b0110011) ? 1'b1 : 1'b0 ;
    
    assign immsrc = (op == 7'b0100011) ? 2'b01 : 
                    (op== 7'b1100011) ? 2'b10 :    
                                         2'b00 ;
    
    assign alusrc = (op == 7'b0000011 | op == 7'b0100011) ? 1'b1 : 1'b0 ;
    assign memwrite = (op == 7'b0100011) ? 1'b1 : 1'b0 ;
    assign resultsrc = (op == 7'b0000011) ? 1'b1 :1'b0 ;
    assign branch = (op == 7'b1100011) ? 1'b1 : 1'b0 ;
    
    assign aluop = (op == 7'b0110011) ? 2'b10 :
                   (op == 7'b1100011) ? 2'b01 :
                                        2'b00 ;

endmodule