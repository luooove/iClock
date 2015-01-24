////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    2015-1-23
// Design Name:   
// Module Name:    
// Project Name:  
// Target Device: 
// Tool versions: 
// Description:
// deal with the key event, get the key results

// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module get_key(rst_n,clk,KEY,KEY_OUT);
input clk;  // 50M主时钟信号
input rst_n;    //复位信号，低有效
input[3:0] KEY;
output[3:0] KEY_OUT;

reg[3:0] key_rst;
always@(posedge clk or negedge rst_n)
	if(!rst_n)
		key_rst <= 4'b1111;
	else	
		key_rst <= {KEY[0],KEY[1],KEY[2],KEY[3]};
	
reg[3:0] key_rst_r;  //每个时钟周期的上升沿按键信号锁存到low_sw_r中

always@(posedge clk or negedge rst_n )
	if(!rst_n)
		key_rst_r <= 4'b1111;
	else
		key_rst_r <= key_rst;

wire[3:0] key_an = key_rst_r & (~key_rst);

reg[19:0] cnt;
always @(posedge clk or negedge rst_n )
	if(!rst_n)
		cnt <= 20'd0;  //异步复位
	else if(key_an)
		cnt <= 20'b0;
	else
		cnt <= cnt + 1'b1;
		
reg[3:0] low_sw;
always @(posedge clk or negedge rst_n)
	if(!rst_n)
		low_sw <= 4'b1111;
	else if(cnt == 20'hffff)
		low_sw <= {KEY[0],KEY[1],KEY[2],KEY[3]};

reg[3:0] low_sw_r;

always @(posedge clk or negedge rst_n )
	if(!rst_n)
		low_sw_r <= 4'b1111;
	else
		low_sw_r <= low_sw;
		
wire[3:0] led_ctrl = low_sw_r[3:0] & (~low_sw[3:0]);
reg d1;
reg d2;
reg d3;

always @(posedge clk or negedge rst_n)
	if(!rst_n)
		begin
			d1 <= 1'b0;
			d2 <= 1'b0;
			d3 <= 1'b0;
		end
	else
		begin
			if(led_ctrl[0]) d1 <= ~d1;
			if(led_ctrl[1]) d2 <= ~d2;
			if(led_ctrl[2]) d3 <= ~d3;
		end
		
assign KEY_OUT[0] = d1 ? 1'b1 : 1'b0;
assign KEY_OUT[1] = d2 ? 1'b1 : 1'b0;
assign KEY_OUT[2] = d3 ? 1'b1 : 1'b0;

endmodule
