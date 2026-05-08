module tt_um_pmendozap_ieee_tiny_spi_segment (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    assign uio_oe[7:1] = 7'b1111000;
    assign uo_out[7] = 0;

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out[3:1] = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[0], uio_in[7:4], 1'b0};

    sp_seg U(
    .i_Clk(clk),
    .i_Rst_L(rst_n),

    // SPI Interface //WIll go to GIOs 
    .i_SPI_Clk(uio_in[3]),
    .i_SPI_CS_n(uio_in[2]),        // active low
    .i_SPI_MOSI(uio_in[1]),
    .o_SPI_MISO(uio_out[0]),
    .o_SPI_MISO_EN(uio_oe[0]),
    
    
    //drive two 4segments?
    .a_to_g(uo_out[6:0]), //to GIOS 4
    .an(uio_out[7:4]), // to outs

    //segment
    .data_in(ui_in) //inputs 
    );

endmodule
