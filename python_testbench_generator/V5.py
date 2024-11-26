import struct
from enum import Enum

def float_to_bin(num):
    packed = struct.pack('>f', num)
    binary_rep = ''.join(f'{byte:08b}' for byte in packed)
    return binary_rep

class OPP(Enum):
    OP_MOV   = 0
    OP_STORE = 1
    OP_LOAD  = 2
    OP_PUSH  = 3
    OP_POP   = 4
    OP_ADD   = 5
    OP_SUB   = 6
    OP_MUL   = 7
    OP_DIV   = 8
    OP_AND   = 9
    OP_OR    = 10
    OP_XOR   = 11
    OP_NOT   = 12
    OP_JUMP  = 13
    OP_JUMPC = 14
    OP_COMP  = 15
    OP_MOVI  = 16
    OP_INC   = 17
    OP_DEC   = 18
    OP_SHL   = 19
    OP_SHR   = 20
    OP_CALL  = 20
    OP_RET   = 22
    OP_BITSET  = 23
    OP_BITCLEAR = 24
    OP_SUMI = 25
    OP_SUBI = 26
    OP_MULI = 27
    OP_DIVI = 28
    OP_ANDI = 29
    OP_ORI  = 30
    OP_XORI = 31

def read_instructions_from_file(file_name_to_read, output_file_name):
    start_address = 0
    with open(file_name_to_read, 'r') as file:
        for line in file:
            parts = line.strip().split()
            if len(parts) == 2:
                instruction_5bits = parts[0]  
                instruction_32bits = parts[1]  
                op_code = to_binary_5bits(instruction_5bits)
                direction = to_binary_32bits(instruction_32bits)
                data_salida = generate_data_in(op_code, direction)
                generate_instructions(start_address, data_salida, output_file_name)
                start_address += 1
            elif len(parts) == 3:
                if parts[1] == "f":
                    instruction_5bits = parts[0]  
                    instruction_32bits = float_to_bin(float(parts[2]))  
                    op_code = to_binary_5bits(instruction_5bits)
                    direction = instruction_32bits
                    data_salida = generate_data_in(op_code, direction)
                    generate_instructions(start_address, data_salida, output_file_name)
                    start_address += 1
                else:
                    print("Las partes no contienen un flotante, verificar formato.")

# Convertir a binario de 5 bits para las operaciones
def to_binary_5bits(value):
    try:
        value_bin = OPP[value].value
    except KeyError:
        raise ValueError(f"Operación no válida: {value}")
    return format(value_bin, '05b')

# Convertir a binario de 32 bits (para enteros)
def to_binary_32bits(value):
    try:
        value = int(value)
    except ValueError:
        raise ValueError(f"El valor debe ser un número entero: {value}")
    return format(value, '032b')

# Generar datos combinados (5 bits y 32 bits)
def generate_data_in(binary_5bits, binary_32bits):
    return f"{binary_5bits}{binary_32bits}"

# Generar instrucciones en el archivo de salida
def generate_instructions(start_address, data_in, output_file_name):
    with open(output_file_name, 'a') as file:
        file.write(f"address = {start_address}; data_in = {data_in};\n")
        print(f"address = {start_address}; data_in = {data_in};")

# Archivo de salida y archivo de entrada
file_name = 'instructions.dat'
file_name_to_read = 'programa.txt'  

# Limpiar archivo de salida antes de escribir
with open(file_name, 'w') as file:
    file.write("")  # Limpiar contenido

# Leer instrucciones desde el archivo y escribir en el archivo de salida
read_instructions_from_file(file_name_to_read, file_name)
