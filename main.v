module PROCESADOR_HARVARD(
    input wire clk,
    input wire reset,
    input wire wr,
    input wire [6:0] address,
    input wire [36:0] data_in,
    output wire [31:0] data_out,
    output wire [31:0] pc_debug,
    output wire [31:0] rc_debug,
    output wire [31:0] op_code_debug
);

// Definición de parámetros
parameter ADDR_WIDTH = 6; 
parameter DATA_WIDTH = 11; 
parameter OPCODE_WIDTH = 5;
parameter LENGTH_MEMORY = 64; 
parameter STACK_INIT = 81;
parameter STACK_END = 100;

reg [OPCODE_WIDTH-1:0] instruction_memory [0:80];                       // Memoria de instrucciones
reg [31:0] data_memory [0:100];                                         // Memoria de datos
reg [7:0] pc;                                                           // Contador de programa
reg [31:0] acc;                                                         // Acumulador
reg [31:0] rx;                                                          // Direccionamiento directo
reg [31:0] stack_pointer = STACK_INIT;                                  // Stack pointer
reg [4:0] instruction_register;                                         // Registro de instrucciones


// CODIGOS DE OPERACION (HASTA 32 CODIGOS)
localparam OP_MOV        = 5'b00000;
localparam OP_STORE      = 5'b00001;
localparam OP_LOAD       = 5'b00010;
localparam OP_PUSH       = 5'b00011;//
localparam OP_POP        = 5'b00100;//
localparam OP_ADD        = 5'b00101;
localparam OP_SUB        = 5'b00110;
localparam OP_MUL        = 5'b00111;
localparam OP_DIV        = 5'b01000;
localparam OP_AND        = 5'b01001;
localparam OP_OR         = 5'b01010;
localparam OP_XOR        = 5'b01011;
localparam OP_NOT        = 5'b01100;
localparam OP_JUMP       = 5'b01101;/////////
localparam OP_JUMPC      = 5'b01110;/////////
localparam OP_COMP       = 5'b01111;//
localparam OP_MOVI       = 5'b10000;
localparam OP_INC        = 5'b10001;
localparam OP_DEC        = 5'b10010;
localparam OP_SHL        = 5'b10011;
localparam OP_SHR        = 5'b10100;
localparam OP_CALL       = 5'b10101;//
localparam OP_RET        = 5'b10110;//
localparam OP_BITSET     = 5'b10111;
localparam OP_BITCLEAR   = 5'b11000;
localparam OP_SUMI       = 5'b11001;
localparam OP_SUBI       = 5'b11010;
localparam OP_MULI       = 5'b11011;
localparam OP_DIVI       = 5'b11100;
localparam OP_ANDI       = 5'b11101;
localparam OP_ORI        = 5'b11110;
localparam OP_XORI       = 5'b11111;

// Asignación de pines de salida
assign data_out = acc;
assign pc_debug = pc;
assign rc_debug = rx;
assign op_code_debug = instruction_register;

// Comportamiento del procesador
always @(posedge clk or posedge reset) begin
    if (reset) begin
        acc <= 0;
        pc <= 0;
        stack_pointer <= 0;
        rx <= 0;
    end else begin
        if (wr) begin
            instruction_memory[address] <= data_in[36:32];
            data_memory[address] <= data_in[31:0];
        end
        else begin
            // Selecciona la instrucción de la memoria según el contador de programa
            instruction_register <= instruction_memory[pc];
            
            // Extraer el dato de la instrucción
            rx <= data_memory[pc];
            
            // Decodifica la instrucción
            case(instruction_register)
                OP_MOV: acc <= data_in;
                OP_STORE: data_memory[rx] <= acc;
                OP_LOAD: acc <= data_memory[rx];
                OP_PUSH: begin
                            if (stack_pointer <= STACK_END) begin

                                data_memory[stack_pointer] <= acc; 
                                stack_pointer <= stack_pointer + 1; 
                            end else begin
                                // STACKOVERFLOW
                            end
                         end
                OP_POP: begin
                           if (stack_pointer > STACK_INIT) begin
                                // La pila no está vacía
                                stack_pointer <= stack_pointer - 1;
                                acc <= data_memory[stack_pointer];
                            end else begin
                                // STACKUNDERFLOW
                            end
                       end
                OP_SUMI: acc <= ((acc + rx) >= 32'hFFFFFFFF) ? 32'h0 : (acc + rx); 
                OP_SUBI: acc <= (acc > rx) ? acc - rx : rx - acc;
                OP_ANDI: acc <= acc & rx;
                OP_DIVI: acc <= acc / rx;
                OP_XORI: acc <= acc ^ rx;
                OP_ORI:  acc <= acc | rx;
                OP_MULI:begin
                    if ((acc > 16'hFFFF) || (rx > 16'hFFFF)) begin
                        acc <= 32'hFFFFFFFF;
                    end
                    else acc <= (acc * rx);
                end
                OP_ADD: acc <= acc + data_memory[rx];
                OP_SUB: acc <= (acc > data_memory[rx]) ? acc - data_memory[rx] : data_memory[rx] - acc;
                OP_MUL: acc <= acc * data_memory[rx];
                OP_DIV: acc <= acc / data_memory[rx];
                OP_AND: acc <= acc & data_memory[rx];
                OP_OR: acc <= acc | data_memory[rx];
                OP_XOR: acc <= acc ^ data_memory[rx];
                OP_NOT: acc <= ~acc;
                OP_JUMP: pc <= rx;
                OP_JUMPC: if (acc == 0) pc <= rx;
                OP_COMP: acc <= (acc > data_memory[rx]) ? 0 : 1;
                OP_MOVI: acc <= rx;
                OP_INC: acc <= (acc < 32'hFFFFFFFF) ? acc + 1 : 0;
                OP_DEC: acc <= (acc > 0) ? acc - 1 : 63;
                OP_SHL: acc <= acc << 1;
                OP_SHR: acc <= acc >> 1;
                OP_CALL:begin
                            if (stack_pointer <= STACK_END) begin
                                // Almacena la dirección de retorno en la pila
                                stack_pointer <= stack_pointer + 1;
                                data_memory[stack_pointer] <= pc + 1;  // Guardamos el pc + 1 para que retorne después
                                pc <= rx;  // Salta a la subrutina
                            end else begin
                                // STACKOVERFLOW
                            end 
                        end
                OP_RET: begin
                            if (stack_pointer > STACK_INIT) begin
                                pc <= data_memory[stack_pointer];
                                stack_pointer <= stack_pointer - 1;
                            end else begin
                                // STACKUNDERFLOW
                            end
                         end
                OP_BITSET: data_memory[rx] <= 1;
                OP_BITCLEAR: data_memory[rx] <= 0;

                default: acc <= 32'b0;
            endcase
            
            if (pc < 80 && instruction_register != OP_JUMP && instruction_register != OP_JUMPC && instruction_register != OP_CALL && instruction_register != OP_RET) begin
                // Si no es un salto, llamada o retorno, simplemente incrementamos el PC
                pc <= pc + 1;
            end
            else if (pc > 80 && instruction_register != OP_JUMP && instruction_register != OP_JUMPC && instruction_register != OP_CALL && instruction_register != OP_RET) begin
                // Limitar el valor de pc a 63 si excede ese valor
                pc <= 80;
            end

        end
    end
end

endmodule
