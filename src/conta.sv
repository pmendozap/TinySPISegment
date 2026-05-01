module conta(
    input logic clk, 
    input logic rst_n, 
    output logic [7:0] contador, 
    input logic dir, 
    input logic [6:0] pl);


  always_ff @ (posedge clk) begin
    if(!rst_n) contador <= 8'd0;
    else if(dir == 1'b0) begin
      contador <= contador + 1;
    end else begin
      contador <= {1'b0, pl};
    end
  end
endmodule