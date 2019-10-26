/* ģ������dm(data memory)
    ģ�鹦�ܣ��洢����*/
module dm(clock, reset, in, WrEn, Addr, out);
	//����clock,reset,WrEn
	input clock, reset, WrEn;
	//����addr,in,addr,in��ַλ��32
	input [31:0] Addr, in;
	//���out,outλ��32λ
	output [31:0] out;
	//����һ����1024��ÿ��32λ�Ĵ洢��
	reg [31:0] memory[1023:0];
	//��������i
	integer i;
	//out��ֵΪmemory[addr],ȡaddr�ĵ�3λ����12λ
	assign out = memory[Addr[11:2]];

	//��ʼ��ʱ���д洢����ֵΪ0
	initial
	begin
		for (i = 0; i < 1024; i = i + 1) memory[i] <= 0;
	end

	always@(posedge clock, posedge reset)
	//�����жϣ���reset�źŲ�Ϊ0ʱ��������memory��0����WrEn�źŲ�Ϊ0ʱ����in��ֵ����memory[addr]
	begin
		if (reset)
			for (i = 0; i < 1024; i = i + 1) memory[i] <= 0;
		else
			if (WrEn) memory[Addr[11:2]] <= in;
	end

endmodule