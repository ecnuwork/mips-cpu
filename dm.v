/* 模块名：dm(data memory)
    模块功能：存储数据*/
module dm(clock, reset, in, WrEn, Addr, out);
	//输入clock,reset,WrEn
	input clock, reset, WrEn;
	//输入addr,in,addr,in地址位宽32
	input [31:0] Addr, in;
	//输出out,out位宽32位
	output [31:0] out;
	//声明一个共1024个每个32位的存储器
	reg [31:0] memory[1023:0];
	//声明整数i
	integer i;
	//out赋值为memory[addr],取addr的第3位到第12位
	assign out = memory[Addr[11:2]];

	//初始化时所有存储器赋值为0
	initial
	begin
		for (i = 0; i < 1024; i = i + 1) memory[i] <= 0;
	end

	always@(posedge clock, posedge reset)
	//进行判断，当reset信号不为0时，将所有memory置0，当WrEn信号不为0时，将in的值赋给memory[addr]
	begin
		if (reset)
			for (i = 0; i < 1024; i = i + 1) memory[i] <= 0;
		else
			if (WrEn) memory[Addr[11:2]] <= in;
	end

endmodule