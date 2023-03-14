/* This example is not tested. 
It is a simplified version from our first processor*/

// synthesis translate_off

`include "define.v"
`include "opcode_define.v"

module decoder_better (
	input  logic  [7:0] operand,
	output logic  [4:0] aci,
	output logic  [3:0] prm_param,adr,
	output logic  [2:0] awm,mem,opr,alu,
	output logic  [1:0] prm,
	output logic  pci,tog
);
	always_comb begin
		pci  =    0;
		aci  =   `aci_none;
		awm  =   `awm_AC	;
		mem  =   `mem_none;
		alu  =   `alu_none;
		prm  =   `prm_jmp;
		opr  =   `opr_none;
		adr  =   `adr_none;
		tog  =    0;
		unique case(operand)
			`FETCH_2, 
			`LODK, 
			`LADD, 
			`LADD_3, 
			`LADD_5, 
			`COPY, 
			`RSET, 
			`JUMP, 
			`INCR, 
			`DECR,
			`LODK		: begin
					pci  =    1;
					mem  =   `mem_midr_m_ci;
				end
			`END   : opr  =   `opr_pc;
			`LADD_2:  begin
					awm  =   `awm_MIDR;
					adr  =   `adr_first2;
				end
			`LADD_4:  begin
					awm  =   `awm_MIDR	;
					adr  =   `adr_mid8;
				end
			`LADD_6:  begin
					awm  =   `awm_MIDR	;
					adr  =   `adr_last8;
				end
			`LADD_7: prm  =   `prm_adr;
			`LOAD:  begin
					prm  =   `prm_adr;
					adr  =   `adr_none;		
				end
			`LOAD_3:mem  =   `mem_mddr_m_ci;
			`STAC:  begin
					aci  =   `aci_MDDR;
					mem  =   `mem_dm_write;
					prm  =   `prm_adr;
				end
			`COPY_2: opr  =   `opr_aci_awm;
			`RSET_2: opr  =   `opr_rst;
			`JUMP_2:  begin
					prm  =   `prm_jmp;
					opr  =   `opr_pc;
				end
			`INCR_2: opr  =   `opr_inc;
			`DECR_2: opr  =   `opr_dec;
			`ADD:  begin
					alu  =   `alu_add;
					prm  =   `prm_add_sub;
				end
			`SUBT:  begin
					alu  =   `alu_sub;
					prm  =   `prm_add_sub;
				end
			`DIV:  begin
					pci  =    1;
					mem  =   `mem_midr_m_ci;
				end
			`DIV_2:  begin
					awm  =   `awm_MIDR	;
					alu  =   `alu_div;
				end
			`MUL:  begin
					pci  =    1;
					mem  =   `mem_midr_m_ci;
				end
			`MUL_2:  begin
					awm  =   `awm_MIDR	;
					alu  =   `alu_mul;
				end
			`togL:  tog  =    1;
		endcase
	end
endmodule



module decoder_naive(
	input  logic  [7:0] operand = 8'd0,
	output logic  [4:0] aci=5'd0,
	output logic  [3:0] prm_param=4'd0,adr=4'd0,
	output logic  [2:0] awm=3'd0,mem=3'd0,opr=3'd0,alu=3'd0;,
	output logic  [1:0] prm=2'd0,
	output logic  pci=0,tog=0
);
always_comb begin
	unique case(operand)
		`END:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_pc;
				adr  =   `adr_none;
				tog  =    0;
			end
		`FETCH:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`FETCH_2:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;	
				adr  =   `adr_none;
				tog  =    0;
			end
		`FETCH_3:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`LODK:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`LODK_2:
			begin
				pci  =    0;
				aci  =   `aci_AC;
				awm  =   `awm_MIDR;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`LADD:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`LADD_2:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_MIDR	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_first2;
				tog  =    0;
			end
		`LADD_3:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`LADD_4:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_MIDR	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_mid8;
				tog  =    0;
			end
		`LADD_5:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`LADD_6:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_MIDR	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_last8;
				tog  =    0;
			end
		`LADD_7:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_adr;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`LOAD:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_adr;
				opr  =   `opr_none;	
        adr  =   `adr_none;		
				tog  =    0;
			end
		`LOAD_2:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`LOAD_3:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_mddr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`STAC:
			begin
				pci  =    0;
				aci  =   `aci_MDDR;
				awm  =   `awm_AC	;
				mem  =   `mem_dm_write;
				alu  =   `alu_none;
				prm  =   `prm_adr;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`COPY:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`COPY_2:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_aci_awm;
				adr  =   `adr_none;
				tog  =    0;
			end
		`RSET:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`RSET_2:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_rst;
				adr  =   `adr_none;
				tog  =    0;
			end
		`JUMP:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`JUMP_2:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_jmp;
				opr  =   `opr_pc;
				adr  =   `adr_none;
				tog  =    0;
			end
		`INCR:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
		`INCR_2:
			begin
				pci  =    0;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_none;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_inc;
				adr  =   `adr_none;
				tog  =    0;
			end
		`DECR:
			begin
				pci  =    1;
				aci  =   `aci_none;
				awm  =   `awm_AC	;
				mem  =   `mem_midr_m_ci;
				alu  =   `alu_none;
				prm  =   `prm_none;
				opr  =   `opr_none;
				adr  =   `adr_none;
				tog  =    0;
			end
			`DECR_2:
				begin
					pci  =    0;
					aci  =   `aci_none;
					awm  =   `awm_AC	;
					mem  =   `mem_none;
					alu  =   `alu_none;
					prm  =   `prm_none;
					opr  =   `opr_dec;
					adr  =   `adr_none;
					tog  =    0;
				end
			`ADD:
				begin
					pci  =    0;
					aci  =   `aci_none;
					awm  =   `awm_AC	;
					mem  =   `mem_none;
					alu  =   `alu_add;
					prm  =   `prm_add_sub;
					opr  =   `opr_none;
					adr  =   `adr_none;
					tog  =    0;
				end
			`SUBT:
				begin
					pci  =    0;
					aci  =   `aci_none;
					awm  =   `awm_AC	;
					mem  =   `mem_none;
					alu  =   `alu_sub;
					prm  =   `prm_add_sub;
					opr  =   `opr_none;
					adr  =   `adr_none;
					tog  =    0;
				end
			`DIV:
				begin
					pci  =    1;
					aci  =   `aci_none;
					awm  =   `awm_AC	;
					mem  =   `mem_midr_m_ci;
					alu  =   `alu_none;
					prm  =   `prm_none;
					opr  =   `opr_none;
					adr  =   `adr_none;
					tog  =    0;
				end
			`DIV_2:
				begin
					pci  =    0;
					aci  =   `aci_none;
					awm  =   `awm_MIDR	;
					mem  =   `mem_none;
					alu  =   `alu_div;
					prm  =   `prm_none;
					opr  =   `opr_none;
					adr  =   `adr_none;
					tog  =    0;
				end
			`MUL:
				begin
					pci  =    1;
					aci  =   `aci_none;
					awm  =   `awm_AC	;
					mem  =   `mem_midr_m_ci;
					alu  =   `alu_none;
					prm  =   `prm_none;
					opr  =   `opr_none;
					adr  =   `adr_none;
					tog  =    0;
				end
			`MUL_2:
				begin
					pci  =    0;
					aci  =   `aci_none;
					awm  =   `awm_MIDR	;
					mem  =   `mem_none;
					alu  =   `alu_mul;
					prm  =   `prm_none;
					opr  =   `opr_none;
					adr  =   `adr_none;
					tog  =    0;
				end
			`togL:
				begin
					pci  =    0;
					aci  =   `aci_none;
					awm  =   `awm_AC	;
					mem  =   `mem_none;
					alu  =   `alu_none;
					prm  =   `prm_none;
					opr  =   `opr_none;
					adr  =   `adr_none;
					tog  =    1;
				end
			`NOOP:
				begin
					pci  =    0;
					aci  =   `aci_none;
					awm  =   `awm_AC	;
					mem  =   `mem_none;
					alu  =   `alu_none;
					prm  =   `prm_none;
					opr  =   `opr_none;
					adr  =   `adr_none;
					tog  =    0;
				end
	endcase
end
endmodule

// synthesis translate_on