`include "recursos.sv"

module PROCESADOR_HARVARD_Testbench();
    localparam periodo = 2;
    opcode_e opcode;
    //logic [6:0] direccion = 7'b000000;
    int direccion = 7'b000000;
    int direccion_2;
    

    reg clk,rst,wr;

    processor_Inputs proc_inputs;
    processor_outputs proc_outputs;

    int i;
    localparam iteraciones_inc = 20;
    logic [31:0] aux = 6'b010100;


    // Instanciar el procesador
    PROCESADOR_HARVARD dut (
        .clk(clk),
        .reset(rst),
        .wr(wr),
        .address(proc_inputs.address),
        .data_in(proc_inputs.data_in),
        .data_out(proc_outputs.data_out),
        .pc_debug(proc_outputs.pcl_debug),
        .rc_debug(proc_outputs.rx_debug),
        .op_code_debug(proc_outputs.op_code)
    );

    // Generador de reloj
    always #(periodo/2) clk = ~clk;

    // Inicio de prueba
    initial begin
        clk = 0;
        rst = 1;
        wr = 0;
        #(periodo * 4);


        // Desactivar reset despu�s de algunos ciclos
        
        rst = 0;
        wr = 1;
        #(periodo * 4);

        //borrar_memoria(proc_inputs, 80);

        /*
        // TESTING DE MOVI

        for (direccion = 0; direccion < 25; direccion++) begin
            movi_tb(proc_inputs,direccion,opcode);
            #3;
        end
        */

        /*
        // TESTING DE SHIFT_LEFT y SHIFT_RIGHT
        opcode = OP_MOVI;
        proc_inputs.address = 0;
        proc_inputs.data_in = {opcode , 32'b1};
        #3
        for (direccion = 1; direccion < 33; direccion++) begin
            shl_tb(proc_inputs,direccion,opcode);
            #3;
        end
        for (direccion = 32; direccion < 63; direccion++) begin
            shr_tb(proc_inputs,direccion,opcode);
            #3;
        end
        */

        //TASK SUMI
        //movi_task(proc_inputs, 0,3);
        
        /*
        // TESTING DE SUMI
        opcode = OP_MOVI;
        proc_inputs.address = 0;
        proc_inputs.data_in = {opcode , generador_numeros()};
        #3
        for (direccion = 1; direccion < 6; direccion++) begin
            sumi_tb(proc_inputs,direccion,opcode);
            #3;
        end
        */

        /*
        // TESTING DE SUBI
        opcode = OP_MOVI;
        proc_inputs.address = 0;
        proc_inputs.data_in = {opcode , generador_numeros()};
        #3
        for (direccion = 1; direccion < 6; direccion++) begin
            subi_tb(proc_inputs,direccion,opcode);
            #3;
        end
        */

        /*
        // TESTING DE MULI
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < 6; direccion++) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            direccion ++;
            #3;
            muli_tb(proc_inputs,direccion_2,opcode);
            #3;
        end
        */

        /*
        // TESTING DE DIVI
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < 15; direccion++) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            direccion ++;
            #3;
            divi_tb(proc_inputs,direccion_2,opcode);
            #3;
        end
        */

        /*
        // TESTING DE ANDI
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < 6; direccion++) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            direccion ++;
            #3;
            andi_tb(proc_inputs,direccion_2,opcode);
            #3;
        end
        */

        /*
        // TESTING DE ORI
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < 6; direccion++) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            direccion ++;
            #3;
            ori_tb(proc_inputs,direccion_2,opcode);
            #3;
        end
        */

        /*
        // TESTING DE XORI
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < 6; direccion++) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            direccion ++;
            #3;
            xori_tb(proc_inputs,direccion_2,opcode);
            #3;
        end
        */
        

        /*
        // TESTING DE INC
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2*(iteraciones_inc))+1; direccion = direccion + iteraciones_inc) begin
            movi_tb(proc_inputs,direccion,opcode);
            #3;
            for (direccion_2 = direccion + 1; direccion_2 < (direccion + iteraciones_inc); direccion_2++) begin
                inc_tb(proc_inputs,direccion_2,opcode);
                #3;
            end
        end
        */

        /*
        // TESTING DE DEC
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2*(iteraciones_inc))+1; direccion = direccion + iteraciones_inc) begin
            movi_tb(proc_inputs,direccion,opcode);
            #3;
            for (direccion_2 = direccion + 1; direccion_2 < (direccion + iteraciones_inc); direccion_2++) begin
                dec_tb(proc_inputs,direccion_2,opcode);
                #3;
            end
        end
        */

        /*
        // TESTING DE BITSET, CLEAR Y LOAD
        opcode = OP_MOVI;
        
        #3
        for (direccion = 0; direccion < (3*4) - 1; direccion = direccion + 4) begin
            bitset_tb(proc_inputs,direccion,opcode, aux);
            direccion_2 = direccion + 1;
            #3;

            load_tb(proc_inputs,direccion_2,opcode, aux);
            direccion_2 = direccion_2 + 1;
            #3;

            bitclear_tb(proc_inputs,direccion_2,opcode, aux);
            direccion_2 = direccion_2 + 1;
            #3;

            load_tb(proc_inputs,direccion_2,opcode, aux);
            #3;
            

            aux++;
            #3;
        end
        */

        /*
        // TESTING DE STORE Y LOAD
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            store_tb(proc_inputs, direccion_2, opcode, aux);
            aux++;
            #3;
        end

        aux = 20;
        #3;
        direccion_2++;
        #3;
        for (direccion = direccion_2; direccion < (direccion_2 + 2); direccion++) begin
            load_tb(proc_inputs,direccion,opcode, aux);
            aux++;
            #3;
        end
        */

        
        // TESTING DE NOT
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (5 * (2) -1); direccion++) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            not_tb(proc_inputs, direccion_2, opcode);
            direccion++;
            #3;
        end
        

        
        /*
        // TESTING DE STORE Y XOR  
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            store_tb(proc_inputs, direccion_2, opcode, aux);
            aux++;
            #3;
        end

        aux = 20;
        direccion_2++;
        movi_tb(proc_inputs,direccion_2,opcode);
        #3;
        direccion_2++;
        #3;
        for (direccion = direccion_2; direccion < (direccion_2 + 2); direccion++) begin
            xor_tb(proc_inputs,direccion,opcode, aux);
            aux++;
            #3;
        end
        */

        /*
        // TESTING DE STORE Y AND  
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            store_tb(proc_inputs, direccion_2, opcode, aux);
            aux++;
            #3;
        end

        aux = 20;
        direccion_2++;
        movi_tb(proc_inputs,direccion_2,opcode);
        #3;
        direccion_2++;
        #3;
        for (direccion = direccion_2; direccion < (direccion_2 + 2); direccion++) begin
            and_tb(proc_inputs,direccion,opcode, aux);
            aux++;
            #3;
        end
        */

        /*
        // TESTING DE STORE Y OR  
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            store_tb(proc_inputs, direccion_2, opcode, aux);
            aux++;
            #3;
        end

        aux = 20;
        direccion_2++;
        movi_tb(proc_inputs,direccion_2,opcode);
        #3;
        direccion_2++;
        #3;
        for (direccion = direccion_2; direccion < (direccion_2 + 2); direccion++) begin
            or_tb(proc_inputs,direccion,opcode, aux);
            aux++;
            #3;
        end
        */

        /*
        // TESTING DE STORE Y MUL  
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            store_tb(proc_inputs, direccion_2, opcode, aux);
            aux++;
            #3;
        end

        aux = 20;
        direccion_2++;
        movi_tb(proc_inputs,direccion_2,opcode);
        #3;
        direccion_2++;
        #3;
        for (direccion = direccion_2; direccion < (direccion_2 + 2); direccion++) begin
            mul_tb(proc_inputs,direccion,opcode, aux);
            aux++;
            #3;
        end
        */

        /*
        // TESTING DE STORE Y DIV  
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            store_tb(proc_inputs, direccion_2, opcode, aux);
            aux++;
            #3;
        end

        aux = 20;
        direccion_2++;
        #3;
        for (direccion = direccion_2; direccion < (direccion_2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            i = direccion + 1;
            #3;
            div_tb(proc_inputs,i,opcode, aux);
            aux++;
            #3;
        end
        */

        /*
        // TESTING DE STORE Y ADD  
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            store_tb(proc_inputs, direccion_2, opcode, aux);
            aux++;
            #3;
        end

        aux = 20;
        direccion_2++;
        #3;
        for (direccion = direccion_2; direccion < (direccion_2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            i = direccion + 1;
            #3;
            add_tb(proc_inputs,i,opcode, aux);
            aux++;
            #3;
        end
        */


        /*
        // TESTING DE STORE Y SUB  
        opcode = OP_MOVI;
        #3
        for (direccion = 0; direccion < (2 * 3) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            direccion_2 = direccion + 1;
            #3;
            store_tb(proc_inputs, direccion_2, opcode, aux);
            aux++;
            #3;
        end

        aux = 20;
        direccion_2++;
        #3;
        for (direccion = direccion_2; direccion < (direccion_2 * 2) - 1; direccion = direccion + 2) begin
            movi_tb(proc_inputs,direccion,opcode);
            i = direccion + 1;
            #3;
            sub_tb(proc_inputs,i,opcode, aux);
            aux++;
            #3;
        end
        */


        rst = 0;
        wr = 0;
        end


        
    // Monitor para observar la salida
    always @(posedge clk && (wr == 0)) begin
        $display("Acumulador: %b \n",proc_outputs.data_out);
    end

endmodule

//10001110101101110100101001111100
//00010010111110000011011111100111
//00000010101100000000001001100100

//01000110100000100110011110011100
//00110000001100001011101000011100
//00000000000000000010001000011100

//01010001100110101111110111101000
//11000111001101010010001110100111
//01000001000100000010000110100000

