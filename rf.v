/*  模块名：rs(register file)
     模块功能：寄存器堆，用于寄存各种信号及地址*/
module rf(busW, RegWr, RegDst, rd, rt, RA, RB, busA, busB, clock, reset)
	//输入clock,reset,RegWe,RegDst
	input clock, reset, RegWr, RegDst;
	//输入位宽为5的rd,rt,RA,RB
	input [4:0] rd, rt, RA, RB;
	//输入位宽为32的busW
	input [31:0] busW;
	//输出位宽为32的busA,busB
	output [31:0] busA, busB;
	//定义一个共32个的32位寄存器
	reg [31:0] register[31:0];
	//声明一个位宽为5的RW
	wire [4:0] RW;
	//声明一个整数i
	integer i;

	//判断RegDst是否为0，为0的话RW赋值为rt,否则赋值为rd
	assign RW = RegDst ? rd : rt;
	//busA取register[RA]中的值
	assign busA = register[RA];
	//busB取register[RB]中的值
	assign busB = register[RB];

	//初始化，初始化时，将所有register中的值都置为0
	initial
	begin
		for (i = 0; i < 32; i = i + 1) register[i] <= 0;
	end

	//当clock，reset变化时进行判断
	always@(posedge clock, posedge reset)
	begin
		//如果reset的值不为0，将所有register的值都置为0
		if (reset)
			for (i = 0; i < 32; i = i + 1) register[i] <= 0;
		//如果RegWr和RW中的值都不为0时，将busW赋值给寄存器register[RW]
		else
			if (RegWr && RW != 0) register[RW] = busW;
	end

endmodule