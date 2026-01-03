`timescale 1ns/1ps

module alu_32bit_tb();

   // Testbench global variables
   reg  [31:0] a, b;
   reg  [3:0]  command;
   reg         enable;
   wire [63:0] out;

   // Variables for iteration of the loops
   integer m, n, o;

   // Parameter constants
   parameter ADD  = 4'b0000,
             INC  = 4'b0001,
             SUB  = 4'b0010,
             DEC  = 4'b0011,
             MUL  = 4'b0100,
             DIV  = 4'b0101,
             SHL  = 4'b0110,
             SHR  = 4'b0111,
             AND  = 4'b1000,
             OR   = 4'b1001,
             INV  = 4'b1010,
             NAND = 4'b1011,
             NOR  = 4'b1100,
             XOR  = 4'b1101,
             XNOR = 4'b1110,
             BUF  = 4'b1111;

   // String for displaying command
   reg [8*5:0] string_cmd;

   // Step1 : Instantiate the DUT
   alu_32bit dut (
      .a_in(a),
      .b_in(b),
      .command_in(command),
      .oe(enable),
      .d_out(out)
   );

   // Step2 : Initialize task
   task initialize;
      begin
         {a, b, enable, command} = 0;
         #10;
      end
   endtask

   // Enable task
   task en_oe(input i);
      begin
         enable = i;
      end
   endtask

   // Input task
   task inputs(input [31:0] j, k);
      begin
         a = j;
         b = k;
      end
   endtask

   // Command task
   task cmd(input [3:0] l);
      begin
         command = l;
      end
   endtask

   // Delay task
   task delay;
      begin
         #10;
      end
   endtask

   // Command string decoding
   always @(command) begin
      case (command)
         ADD  : string_cmd = "ADD";
         INC  : string_cmd = "INC";
         SUB  : string_cmd = "SUB";
         DEC  : string_cmd = "DEC";
         MUL  : string_cmd = "MUL";
         DIV  : string_cmd = "DIV";
         SHL  : string_cmd = "SHL";
         SHR  : string_cmd = "SHR";
         AND  : string_cmd = "AND";
         OR   : string_cmd = "OR";
         INV  : string_cmd = "INV";
         NAND : string_cmd = "NAND";
         NOR  : string_cmd = "NOR";
         XOR  : string_cmd = "XOR";
         XNOR : string_cmd = "XNOR";
         BUF  : string_cmd = "BUF";
         default: string_cmd = "UNK";
      endcase
   end

   // Stimulus generation
   initial begin
      initialize;
      en_oe(1'b1);

      for (m = 0; m < 16; m = m + 1) begin
         for (n = 0; n < 16; n = n + 1) begin
            inputs(m, n);
            for (o = 0; o < 16; o = o + 1) begin
               command = o;
               delay;
            end
         end
      end

      // Tri-state test
      en_oe(0);
      inputs(32'd20, 32'd10);
      cmd(ADD);
      delay;

      en_oe(1);
      inputs(32'd25, 32'd17);
      cmd(ADD);
      delay;

      $finish;
   end

   // Monitor output
   initial begin
      $monitor("oe=%b a=%d b=%d cmd=%s out=%d",
                enable, a, b, string_cmd, out);
   end

endmodule

