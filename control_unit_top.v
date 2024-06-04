    `include "alu_decoder.v"
    `include "main_decoder.v"

module control_unit_top(op,regwrite,immsrc,alusrc,memwrite,resultsrc,branch,funct3,funct7,alucontrol);


    input [6:0]op,funct7;
    input [2:0]funct3;
    output regwrite,alusrc,memwrite,resultsrc,branch;
    output [1:0]immsrc;
    output [2:0]alucontrol;

    wire [1:0]aluop;

    main_decoder main_decoder(
                .op(op),
                .regwrite(regwrite),
                .immsrc(immsrc),
                .memwrite(memwrite),
                .resultsrc(resultsrc),
                .branch(branch),
                .alusrc(alusrc),
                .aluop(aluop)
    );

    alu_decoder alu_decoder(
                            .aluop(aluop),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(op),
                            .alucontrol(alucontrol)
    );


endmodule