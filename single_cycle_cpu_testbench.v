`include "single_cycle_cpu_topmodule.v"
module single_cycle_cpu_testbench();

    single_cycle_cpu_topmodule dut(clk,rst);
    reg clk=1'b0;
    reg rst;
    
    initial begin
        $dumpfile("single_cycle_cpu_waveform.vcd");
        $dumpvars(0,single_cycle_cpu_testbench);
    end

    always 
    begin
        clk = ~ clk;
        #50;  
        
    end
    
    initial
    begin
        rst <= 1'b0;
        #150;

        rst <=1'b1;
        #450;
        $finish;
    end
endmodule