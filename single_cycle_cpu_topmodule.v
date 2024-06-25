module single_cycle_cpu_topmodule(clk,rst,data_out);

    input clk,rst;
    output [31:0]data_out;
    wire [31:0] pc_top,rd_instr,rd1_top,imm_ext_top,aluresult,readdata,pcplus4,rd2_top,srcb,result;
    wire regwrite,memwrite,alusrc,resultsrc;
    wire [1:0]immsrc;
    wire [2:0]alucontrol_top;

    pc pc_dut(
        .clk(clk),
        .rst(rst),
        .pc(pc_top),
        .pc_next(pcplus4)
    );

    pc_adder pc_adder_dut(
                    .a(pc_top),
                    .b(32'd4),
                    .c(pcplus4)
    );
    
    instr_memory instr_memory_dut(
                            .rst(rst),
                            .a(pc_top),
                            .rd_data(rd_instr)
    );

    register_file register_file_dut(
                            .clk(clk),
                            .rst(rst),
                            .wr_en(regwrite),
                            .wr_data(result),
                            .a1(rd_instr[19:15]),
                            .a2(rd_instr[24:20]),
                            .a3(rd_instr[11:7]),
                            .rd_data1(rd1_top),
                            .rd_data2(rd2_top)
    );


    sign_extend sign_extend_dut(
                        .in(rd_instr),
                        .imm_src(immsrc[0]),
                        .imm_ext(imm_ext_top)
    );

    mux mux_register_to_alu(
                            .a(rd2_top),
                            .b(imm_ext_top),
                            .s(alusrc),
                            .c(srcb)
    );

    alu alu_dut(
            .a(rd1_top),
            .b(srcb),
            .result(aluresult),
            .alucontrol(alucontrol_top),
            .overflow(),
            .carry(),
            .zero(),
            .negetive()
    );

    control_unit_top control_unit_top_dut(
                            .op(rd_instr[6:0]),
                            .regwrite(regwrite),
                            .immsrc(immsrc),
                            .alusrc(alusrc),
                            .memwrite(memwrite),
                            .resultsrc(resultsrc),
                            .branch(),
                            .funct3(rd_instr[14:12]),
                            .funct7(rd_instr[6:0]),
                            .alucontrol(alucontrol_top)
    );

    data_memory data_memory_dut(
                        .clk(clk),
                        .rst(rst),
                        .wr_en(memwrite),
                        .wr_data(rd2_top),
                        .a(aluresult),
                        .read_data(readdata)
    );

    mux mux_datamemory_to_register(
                            .a(aluresult),
                            .b(readdata),
                            .s(resultsrc),
                            .c(result)
    );
    assign data_out=result;
endmodule
