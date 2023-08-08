`timescale 1ns/1ps

module Up_Dn_Counter_tb();
  
  reg [4:0] IN_tb;
  reg       load_tb,Up_tb,Down_tb,CLK_tb,rst_n_tb;
  wire [4:0] Counter_tb;
  wire       High_tb,Low_tb;
  
  initial
   begin
     $dumpfile("Up_Dn_Counter.vcd");
     $dumpvars;
     
     initialization();
	 
	 $display("************************************* TEST CASE 1: reset TEST ***********************************");
	 reset();
	 
	 $display("************************************* TEST CASE 2: LOAD TEST ************************************");
	 test_load();
	 
	 $display("************************************* TEST CASE 3: DOWN TEST ************************************");
	 test_down();
	 
	 $display("************************************** TEST CASE 4: UP TEST *************************************");
	 test_up();
	 
	 $display("******************************** TEST CASE 5: DOWN PRIORITY TEST ********************************");
	 test_down_priority();
	 
	 $display("******************************** TEST CASE 6: LOAD PRIORITY TEST ********************************");
	 test_load_priority();
	 
     #100 
	 $stop;
   end
   
   
   ///////////////////////////////////////////////////////initialization task//////////////////////////////////////////////////////////
   task initialization;
	begin
	 CLK_tb = 0;
	 rst_n_tb = 1;
     load_tb = 0;
     Up_tb = 0;
     Down_tb = 0;
     IN_tb = 5'b0;
	end
   endtask

   
   //////////////////////////////////////////////////////////////reset task/////////////////////////////////////////////////////////   
	task reset;
	begin
	 @(negedge CLK_tb)
	 rst_n_tb = 0;
	 @(negedge CLK_tb)
	 if(Counter_tb == 'b0)
		$display("reset works well");
	 else
		$display("reset has an error");
	 @(negedge CLK_tb)
	 rst_n_tb = 1;
	end
	endtask

	
	////////////////////////////////////////////////load input signal testing task////////////////////////////////////////////////
   task test_load;
   begin
     @(negedge CLK_tb)
	 IN_tb = 5'd9;
     load_tb = 1;
     @(negedge CLK_tb)
	 if(Counter_tb == IN_tb)
		$display("test passed successfully");
	 else
		$display("test faild");
	load_tb = 0;
   end
   endtask

   
	////////////////////////////////////////////////down input signal testing task////////////////////////////////////////////////   
   task test_down;
   begin
     @(negedge CLK_tb)
	 Down_tb = 1;
     wait(Up_Dn_Counter_tb.DUT.Low == 1'b1);
     @(negedge CLK_tb)
	 if(Counter_tb == 'b0)
		$display("test passed successfully");
	 else
		$display("test faild");
	 Down_tb = 0; 
   end
   endtask

   
	////////////////////////////////////////////////up input signal testing task////////////////////////////////////////////////
   task test_up;
   begin
     @(negedge CLK_tb)
	 Up_tb = 1;
	 wait(Up_Dn_Counter_tb.DUT.High == 1'b1);
	 @(negedge CLK_tb)
	 if(Counter_tb == 'd31)
		$display("test passed successfully");
	 else
		$display("test faild");
	 Up_tb = 0;
   end
   endtask
   

	////////////////////////////////////////////down input signal priorty testing task///////////////////////////////////////////   
   task test_down_priority;
   begin
     @(negedge CLK_tb)
	 Down_tb = 1;
	 @(negedge CLK_tb)
	 Up_tb = 1;
	 @(negedge CLK_tb)
	 if(Counter_tb == 'd29)
		$display("test passed successfully");
	 else
		$display("test faild");
	@(negedge CLK_tb)
	Down_tb = 0;
	Up_tb = 0;
   end
   endtask
   
   
	////////////////////////////////////////////down input signal priorty testing task///////////////////////////////////////////   
   task test_load_priority;
   begin
     IN_tb = 5'd5;
     @(negedge CLK_tb)
	 Down_tb = 1;
	 Up_tb = 1;
	 load_tb = 1;
	 @(negedge CLK_tb)
	 if(Counter_tb == 'd5)
		$display("test passed successfully");
	 else
		$display("test faild");
	Down_tb = 0;
	Up_tb = 0;
	load_tb = 0;
   end
   endtask
	
	
  /////////////////////////////////////////////////////////CLK generation////////////////////////////////////////////////////////
  always #5 CLK_tb = ~CLK_tb;
  
  
  /////////////////////////////////////////////////////////DUT instantiation////////////////////////////////////////////////////
  Up_Dn_counter DUT(
  .IN (IN_tb),
  .load (load_tb),
  .Up (Up_tb),
  .Down (Down_tb),
  .CLK (CLK_tb),
  .rst_n(rst_n_tb),
  .Counter (Counter_tb),
  .High (High_tb),
  .Low (Low_tb)
  );
    
endmodule
  
  
  
