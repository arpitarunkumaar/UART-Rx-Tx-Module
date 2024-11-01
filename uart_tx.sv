module uart_tx
    #(parameter CLKS_PER_BIT)
    (
        input clk,
        input [7:0] i_data_byte, 
        input i_data_avail,  // start transmission if high
        output reg o_active,  // high while transmitting
        output reg o_done,  // high for 1 clk cycle when complete
        output reg o_tx  // bit to be transmitted
    );
 
    localparam IDLE_STATE = 2'b00;
    localparam START_STATE = 2'b01;
    localparam SEND_BIT_STATE = 2'b10;
    localparam STOP_STATE = 2'b11;
    
    reg [1:0] state = 0;
    reg [15:0] counter = 0;
    reg [2:0] bit_index = 0;
    reg [7:0] data_byte = 0;

    always @(posedge clk) begin
        case(state)
            IDLE_STATE: begin    
                o_tx <= 1;
                o_done <= 0;
                counter <= 0;
                bit_index <= 0;

                if (i_data_avail) begin
                    o_active <= 1;
                    data_byte <= i_data_byte;
                    state <= START_STATE;
                end else begin
                    o_active <= 0;
                    state <= IDLE_STATE;
                end
            end

            START_STATE: begin
                o_tx <= 0;
                if (counter < CLKS_PER_BIT - 1) begin
                    counter <= counter + 1;
                    state <= START_STATE;
                end else begin
                    counter <= 0;
                    state <= SEND_BIT_STATE;
                end
            end

            SEND_BIT_STATE: begin
                o_tx <= data_byte[bit_index];
                if (counter < CLKS_PER_BIT - 1) begin
                    counter <= counter + 1;
                    state <= SEND_BIT_STATE;
                end else begin
                    counter <= 0;
                    if (bit_index < 7) begin
                        bit_index <= bit_index + 1;
                        state <= SEND_BIT_STATE;
                    end else begin
                        bit_index <= 0;
                        state <= STOP_STATE;
                    end
                end
            end

            STOP_STATE: begin
                o_tx <= 1;
                if (counter < CLKS_PER_BIT - 1) begin
                    counter <= counter + 1;
                    state <= STOP_STATE;
                end else begin
                    o_done <= 1;
                    counter <= 0;
                    state <= IDLE_STATE;
                    o_active <= 0;
                end
            end
        endcase
    end
endmodule
