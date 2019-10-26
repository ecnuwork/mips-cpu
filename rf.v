/*  ģ������rs(register file)
     ģ�鹦�ܣ��Ĵ����ѣ����ڼĴ�����źż���ַ*/
module rf(busW, RegWr, RegDst, rd, rt, RA, RB, busA, busB, clock, reset)
	//����clock,reset,RegWe,RegDst
	input clock, reset, RegWr, RegDst;
	//����λ��Ϊ5��rd,rt,RA,RB
	input [4:0] rd, rt, RA, RB;
	//����λ��Ϊ32��busW
	input [31:0] busW;
	//���λ��Ϊ32��busA,busB
	output [31:0] busA, busB;
	//����һ����32����32λ�Ĵ���
	reg [31:0] register[31:0];
	//����һ��λ��Ϊ5��RW
	wire [4:0] RW;
	//����һ������i
	integer i;

	//�ж�RegDst�Ƿ�Ϊ0��Ϊ0�Ļ�RW��ֵΪrt,����ֵΪrd
	assign RW = RegDst ? rd : rt;
	//busAȡregister[RA]�е�ֵ
	assign busA = register[RA];
	//busBȡregister[RB]�е�ֵ
	assign busB = register[RB];

	//��ʼ������ʼ��ʱ��������register�е�ֵ����Ϊ0
	initial
	begin
		for (i = 0; i < 32; i = i + 1) register[i] <= 0;
	end

	//��clock��reset�仯ʱ�����ж�
	always@(posedge clock, posedge reset)
	begin
		//���reset��ֵ��Ϊ0��������register��ֵ����Ϊ0
		if (reset)
			for (i = 0; i < 32; i = i + 1) register[i] <= 0;
		//���RegWr��RW�е�ֵ����Ϊ0ʱ����busW��ֵ���Ĵ���register[RW]
		else
			if (RegWr && RW != 0) register[RW] = busW;
	end

endmodule