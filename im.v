/*  ģ������im(instruction memory)
     ģ�鹦�ܣ�ָ��洢�����洢ָ��*/
module im(Addr, out, reset);
	//����reset,addr,����addrȡ��1��10λ
	input reset;
	input [9:0] Addr;
	//���out��outλ��Ϊ32
	output [31:0] out;
	//����һ����1024��32λ�Ĵ���
	reg [31:0] memory[1023:0];
	//��������i
	integer i;
	//out��ֵΪmemory[addr]
	assign out = memory[Addr];

	//��ʼ������code.txt�е�ָ�����memory
	initial
	begin
		$readmemh("code.txt", memory);
	end

	//���reset��Ϊ0ʱ��������memory��ֵ��գ����¶���memory
	always@(posedge reset)
	begin
		for (i = 0; i < 1024; i = i + 1) memory[i] = 0;
		$readmemh("code.txt", memory);
	end

endmodule