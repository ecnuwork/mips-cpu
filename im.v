/*  模块名：im(instruction memory)
     模块功能：指令存储器，存储指令*/
module im(Addr, out, reset);
	//输入reset,addr,其中addr取第1到10位
	input reset;
	input [9:0] Addr;
	//输出out，out位宽为32
	output [31:0] out;
	//定义一个共1024个32位寄存器
	reg [31:0] memory[1023:0];
	//声明整数i
	integer i;
	//out赋值为memory[addr]
	assign out = memory[Addr];

	//初始化，将code.txt中的指令集读入memory
	initial
	begin
		$readmemh("code.txt", memory);
	end

	//如果reset不为0时，将所有memory的值清空，重新读入memory
	always@(posedge reset)
	begin
		for (i = 0; i < 1024; i = i + 1) memory[i] = 0;
		$readmemh("code.txt", memory);
	end

endmodule