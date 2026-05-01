module sp_seg(
    input logic i_Clk,
    input logic i_Rst_L,

    // SPI Interface //WIll go to GIOs 
    input logic     i_SPI_Clk,
    output logic o_SPI_MISO,
    output logic o_SPI_MISO_EN,
    input logic     i_SPI_MOSI,
    input   logic    i_SPI_CS_n,        // active low

    //drive two 4segments?
    output logic [6:0] a_to_g, //to GIOS 4
    output logic [3:0] an, // to outs

    //segment
    input logic [7:0] data_in //inputs 
    );

logic o_RX_DV;
logic [7:0] o_RX_Byte;
SPI_Slave 
  #(.SPI_MODE(0))
  U0
  (
   // Control/Data Signals,
   .i_Rst_L,    // FPGA Reset, active low
   .i_Clk,      // FPGA Clock
   
   .o_RX_DV,    // Data Valid pulse (1 clock cycle)
   .o_RX_Byte,  // Byte received on MOSI
   .i_TX_DV(o_RX_DV),    // Data Valid pulse to register i_TX_Byte
   .i_TX_Byte(data_in),  // Byte to serialize to MISO.

   // SPI Interface //WIll go to GIOs
   .i_SPI_Clk,
   .o_SPI_MISO,
   .o_SPI_MISO_EN,
   .i_SPI_MOSI,
   .i_SPI_CS_n        // active low
   );


   logic [2:0][7:0] full_word;
    logic [2:0]count;
   always_ff @(posedge i_Clk) begin
    if(!i_Rst_L) begin
        full_word <= '0;
        count <= 0;
    end else begin
        if(!i_SPI_CS_n) begin
            if(o_RX_DV) begin
                full_word[count] <= o_RX_Byte;
                count <= count + 1;
            end
        end else begin
            count <= 0;
        end
    end


   end

   logic we;
    
   assign we = (count>0)?1:0;
   

   segment_disp U1(

	.x({full_word[1], full_word[0]}),
    .clk(i_Clk),
    .rst(i_Rst_L),
    .divider(full_word[2][4:0]),
    .we,
    .a_to_g,
    .an
	);

endmodule