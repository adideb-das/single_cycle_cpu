module instr_memory(rst,a,rd_data);
input rst;
input [31:0]a;
output [31:0]rd_data;

reg[31:0]mem[0:1023];

assign rd_data= (rst)?mem[a[31:2]]:{32'b0};

initial begin
    $readmemh("memfile.hex",mem);
 end
 endmodule   