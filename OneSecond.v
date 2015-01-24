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
// generate 1 second.

// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module OneSecond(clk,rst_n,sec1);
input clk;  // 50M主时钟信号
input rst_n;    //复位信号，低有效
output sec1;
reg sec1_r;
reg[24:0] cnt;
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		cnt <= 25'b0000_0000_0000_0000_0000_0000_0;
		sec1_r <= 1;
	end
	else	
		begin
			cnt <= cnt + 1'b1;
			if(cnt == 25'b1_0111_1101_0111_1000_0100_0000)  //当计数到25M次时对结果取一次反，即没半秒出发一次
				cnt<= 0;
				sec1_r <= ~sec1_r;  //对结果取反
		end
end

assign sec1 = sec1_r;

endmodule
