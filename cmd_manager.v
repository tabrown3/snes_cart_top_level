module cmd_manager
(
    input clk,
    input [7:0] in_byte,
    input byte_finished,
    output reg [7:0] out_byte = 8'h00
);

    localparam [5:0] INITIALIZE_CMD = 6'h00;
    localparam [5:0] WRITE_BYTE_CMD = 6'h01;
    localparam [5:0] READ_BYTE_CMD = 6'h02;

    reg prev_finished = 1'b0;
    reg [31:0] cmd_frame = 32'h00000000;
    reg [2:0] byte_cnt = 3'h4;

    always @(posedge clk) begin
        if (byte_finished ^ prev_finished) begin
            prev_finished <= byte_finished;
            cmd_frame[(byte_cnt * 8) - 1:(byte_cnt - 1 * 8)] <= in_byte;
            
            if (byte_cnt > 3'h1) begin
                byte_cnt <= byte_cnt - 3'h1;
            end else begin
                byte_cnt <= 3'h4;
            end
        end
    end
endmodule