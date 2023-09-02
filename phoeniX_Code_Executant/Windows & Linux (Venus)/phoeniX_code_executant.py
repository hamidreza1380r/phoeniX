# ----------------------------------------------------------------
# |                      phoeniX CORE                            |
# | ------------------------------------------------------------ |
# | Custom-built RISC-V assembly code executant for phoeniX core |
# |          By : Arvin Delavari - Faraz Ghoreishy               |
# |   Iran University of Science and Technology - Summer 2023    |
# ----------------------------------------------------------------
import os
text = """
phoeniX core RISC-V assembly code executant
Version : 0.1
This script is designed to execute an assembly code file generated by the Venus Simulator on the phoeniX core.
By : Arvin Delavari - Faraz Ghoreishy
Iran University of Science and Technology - Summer 2023
To execute this program, please follow these steps:
1) Write, simulate and modify your assembly code in Venus simulator.
2) In 'VENUS OPTIONS' select 'Assembly' and save the output file as a text file (.txt).
3) Enter the created text file name.
4) Rimware file (instruction memory) will be generated.
5) Reade the firmware file in testbench.
"""

print(text)

# File names (input from user)
input_name = input("Enter input file name:\n")
output_name = "firmware32.hex"

input_file  = os.path.join(os.getcwd(), input_name)
output_file = os.path.join(os.getcwd(), output_name)

# Read the contents of the input file (assembly text file)
with open(input_file, "r") as file:
    lines = file.readlines()

# Remove the first and third columns from each line (PC and Code)
modified_lines = [line.split()[1] +'\n' for line in lines]

# Remove the "0x" prefix from each line
modified_lines = [line[2:] for line in modified_lines]

# Remove '\n\n' elements from the array
final_hex_code = [elem for elem in modified_lines if elem != '\n\n']
print(final_hex_code)

# Write the modified contents to the output file
with open(output_file, "w") as file:
    file.writelines(final_hex_code)


# Open and edit testbench file
# testbench_file = "phoeniX_Testbench.v"

# with open(testbench_file, 'r') as file:
#     lines = file.readlines()

# # Edit source files of testbench names
# with open(testbench_file, 'w') as file:
#     for line in lines:
#         # Change instruction memory source file
#         if line.startswith("\t\t$readmemh("):
#             print("Line found!")
#             # Modify the input file name
#             modified_line = line.replace(line,'\t\t$readmemh("Sample_Codes'+ "\\\\" + output_name +'"' + ', uut.fetch_unit.instruction_memory.Memory);\n' )
#             file.write(modified_line)
#         # Change data memory source file
#         elif line.startswith("\t\tdata_memory_file = $fopen("):
#             print("Line found!")
#             # Modify the input file name
#             modified_line = line.replace(line,'\t\tdata_memory_file = $fopen("Sample_Codes' + "\\\\" + data_mem_name + '"' + ', "w");\n')
#             file.write(modified_line)
#         else:
#             file.write(line)

# # OS : cmd commands to execute Verilog simulations:
# # 1 - Create VVP file form testbench
# # 2 - Execute VVP file and create VCD file
# # 3 - Open VCD file in GTKWave
# # Output wavforms will be automatically opened in GTKWave
# os.system('cmd /c "iverilog -o phoeniX.vvp phoeniX_Testbench.v"') 
# os.system('cmd /c "vvp phoeniX.vvp"') 
# os.system('cmd /c "gtkwave phoeniX.vcd"') 