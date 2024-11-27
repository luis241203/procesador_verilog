typedef enum logic [4:0] {
    OP_MOV     ,
    OP_STORE   ,
    OP_LOAD    ,
    OP_PUSH    ,
    OP_POP     ,
    OP_ADD     ,
    OP_SUB     ,
    OP_MUL     ,
    OP_DIV     ,
    OP_AND     ,
    OP_OR      ,
    OP_XOR     ,
    OP_NOT     ,
    OP_JUMP    ,
    OP_JUMPC   ,
    OP_COMP    ,
    OP_MOVI    ,
    OP_INC     ,
    OP_DEC     ,
    OP_SHL     ,
    OP_SHR     ,
    OP_CALL    ,
    OP_RET     ,
    OP_BITSET  ,
    OP_BITCLEAR,
    OP_SUMI    ,
    OP_SUBI    ,
    OP_MULI    ,
    OP_DIVI    ,
    OP_ANDI    ,
    OP_ORI     ,
    OP_XORI
} opcode_e;



typedef struct {
    logic [6:0] address;
    logic [36:0] data_in;  
} processor_Inputs;

typedef struct {
    logic [31:0] data_out;
    logic [31:0] pcl_debug;
    logic [31:0] rx_debug;
    logic [31:0] op_code;  
} processor_outputs;

function automatic logic [31:0] generador_numeros();
    logic [31:0] random_number;
    random_number = $urandom_range(0, 2**32 - 1);
    //$display("numero en el generador = %d\n", random_number);
    return random_number;
endfunction

function automatic void movi_tb(inout processor_Inputs instancia,logic [6:0] direccion, opcode_e opcode);
    opcode = OP_MOVI;
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
    $display("numero generado MOVI = %d\n", instancia.data_in[31:0]);
endfunction

function automatic void sumi_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_SUMI;  // Cambié OP_MOVI a OP_SUMI
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
    $display("numero generado SUMI= %d\n", instancia.data_in[31:0]);
endfunction


function automatic void subi_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_SUBI;  // Cambié OP_SUMI a OP_SUBI
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
    $display("numero generado = %b\n", instancia.data_in[31:0]);
endfunction


function automatic void shl_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_SHL;  // Cambié OP_SUBI a OP_SHL
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void shr_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_SHR;  // Cambié OP_SHL a OP_SHR
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void xori_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_XORI;  // Cambié OP_SHR a OP_XORI
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void andi_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_ANDI;  // Cambié OP_XORI a OP_ANDI
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void ori_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_ORI;  // Cambié OP_ANDI a OP_ORI
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void bitset_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode,logic [31:0] direccion_lectura);
    opcode = OP_BITSET;  // Cambié OP_ORI a OP_BITSET
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction


function automatic void bitclear_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode,logic [31:0] direccion_lectura);
    opcode = OP_BITCLEAR;  // Cambié OP_BITSET a OP_BITCLEAR
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction

function automatic void muli_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_MULI;  // Cambié OP_BITSET a OP_BITCLEAR
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void divi_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_DIVI;  // Cambié OP_BITSET a OP_BITCLEAR
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void inc_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_INC;  // Cambié OP_BITCLEAR a OP_INC
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void dec_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_DEC;  // Cambié OP_INC a OP_DEC
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction

function automatic void load_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode,logic [31:0] direccion_lectura);
    opcode = OP_LOAD;  // Cambié OP_INC a OP_DEC
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction

function automatic void store_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode, logic [31:0] direccion_lectura);
    opcode = OP_STORE;  // Cambié OP_LOAD a OP_STORE
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction

function automatic void and_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode, logic [31:0] direccion_lectura);
    opcode = OP_AND;  // Cambié OP_STORE a OP_AND
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction

function automatic void or_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode, logic [31:0] direccion_lectura);
    opcode = OP_OR;  // Cambié OP_AND a OP_OR
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction


function automatic void xor_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode, logic [31:0] direccion_lectura);
    opcode = OP_XOR;  // Cambié OP_OR a OP_XOR
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction


function automatic void add_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode, logic [31:0] direccion_lectura);
    opcode = OP_ADD;  // Cambié OP_XOR a OP_ADD
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction


function automatic void sub_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode, logic [31:0] direccion_lectura);
    opcode = OP_SUB;  // Cambié OP_ADD a OP_SUB
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction


function automatic void mul_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode, logic [31:0] direccion_lectura);
    opcode = OP_MUL;  // Cambié OP_SUB a OP_MUL
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction


function automatic void div_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode, logic [31:0] direccion_lectura);
    opcode = OP_DIV;  // Cambié OP_MUL a OP_DIV
    instancia.address = direccion;
    instancia.data_in = {opcode, direccion_lectura};
endfunction


function automatic void not_tb(inout processor_Inputs instancia, logic [6:0] direccion, opcode_e opcode);
    opcode = OP_NOT;  // Cambié el opcode a OP_NOT
    instancia.address = direccion;
    instancia.data_in = {opcode, generador_numeros()};
endfunction
