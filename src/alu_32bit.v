module alu_32bit (
    input  [31:0] a_in,
    input  [31:0] b_in,
    input  [3:0]  command_in,
    input         oe,
    output [63:0] d_out
);

    // ALU operation codes
    parameter ADD  = 4'b0000, // Add a and b
              INC  = 4'b0001, // Increment a
              SUB  = 4'b0010, // Subtract b from a
              DEC  = 4'b0011, // Decrement a
              MUL  = 4'b0100, // Multiply a and b
              DIV  = 4'b0101, // Divide a by b
              SHL  = 4'b0110, // Shift left
              SHR  = 4'b0111, // Shift right
              AND  = 4'b1000, // AND
              OR   = 4'b1001, // OR
              INV  = 4'b1010, // Invert a
              NAND = 4'b1011, // NAND
              NOR  = 4'b1100, // NOR
              XOR  = 4'b1101, // XOR
              XNOR = 4'b1110, // XNOR
              BUF  = 4'b1111; // Buffer

    // Internal register
    reg [63:0] out;

    // Combinational logic
    always @(*) begin
        case (command_in)
            ADD  : out = a_in + b_in;
            INC  : out = a_in + 1;
            SUB  : out = a_in - b_in;
            DEC  : out = a_in - 1;
            MUL  : out = a_in * b_in;
            DIV  : out = (b_in != 0) ? a_in / b_in : 64'd0;
            SHL  : out = a_in << 1;
            SHR  : out = a_in >> 1;
            AND  : out = a_in & b_in;
            OR   : out = a_in | b_in;
            INV  : out = ~a_in;
            NAND : out = ~(a_in & b_in);
            NOR  : out = ~(a_in | b_in);
            XOR  : out = a_in ^ b_in;
            XNOR : out = ~(a_in ^ b_in);
            BUF  : out = a_in;
            default : out = 64'd0;
        endcase
    end

    // Tri-state output
    assign d_out = oe ? out : 64'hZZZZ_ZZZZ_ZZZZ_ZZZZ;

endmodule
