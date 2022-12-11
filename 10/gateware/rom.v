module rom (
address , // Address input
data    , // Data output
en , // Read Enable 
);
input [31:0] address;
output [16:0] data; 
input en;
           
reg [16:0] mem [0:250] ;  // yes 17 bits
      
assign data = en ? mem[address] : 16'b0;

initial begin
  $readmemb("memory.rom", mem); // memory_list is memory file
end

endmodule