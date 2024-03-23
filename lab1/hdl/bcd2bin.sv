module bcd2bin(
    input [7:0] bcd_in,
    output reg [6:0] bin_out
);

    always @(*) begin
	#5
        // Define an array for temporary storage of the binary values
        bit [3:0] bin_tmp [7:0];
        integer i;
	#5	
        // Initialize temporary binary storage to zero
        for (i = 0; i < 8; i = i + 1) begin
            bin_tmp[i] = 4'b0000;
        end
	#5
        // Convert BCD to binary using inverted double dabble algorithm
        for (i = 0; i < 8; i = i + 1) begin
            for (int j = 3; j >= 0; j = j - 1) begin
                // Perform binary addition
                bin_tmp[i][j] = bcd_in[i] ^ bin_tmp[i][j];
                if (j != 0) bin_tmp[i][j-1] = bcd_in[i] & bin_tmp[i][j-1];
            end
        end

        // Assign the binary output
        bin_out = {bin_tmp[7][3], bin_tmp[6], bin_tmp[5], bin_tmp[4], bin_tmp[3], bin_tmp[2], bin_tmp[1], bin_tmp[0]};
    end

endmodule

