module Up_Dn_counter(

input wire [4:0] IN,
input wire       load,Down,Up,CLK,rst_n,
output reg [4:0] Counter,
output wire      High, Low

);

always @(posedge CLK or negedge rst_n)
  begin
   if(!rst_n) begin
	Counter <= 'b0;
   end
   
   else begin
    if (load)
      begin
        Counter <= IN;
      end
      
	else if (Down && !Low)
      begin
        Counter <= Counter - 5'b1;
      end
      
	else if (Up && !High)
      begin
        Counter <= Counter + 5'b1;
      end
	end
  end

assign High = (Counter == 5'b11111);
assign Low = (Counter == 5'b0);

endmodule

