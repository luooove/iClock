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
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////


module iClock(clk,rst_n,SMG,KEY,buzzer);
input clk;  // 50M主时钟信号
input rst_n;    //复位信号，低有效
input[3:0] KEY;

output SMG;
output buzzer;



endmodule
