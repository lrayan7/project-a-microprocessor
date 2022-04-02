#!/bin/bash



i=1
j=0

rs1=0
rs2=0
imm=0

while read line
do

	echo $line 
	if [[ -n "$line"  && $line != "//"* ]]; then
		if [[ $line == "lw"* ]]; then # lw x2,0(x3) // w
			rs1=$(echo $line | cut -d'x' -f 2)
			rs1=$(echo $rs1 | cut -d',' -f 1)
			
			rs1=$(echo 'obase=2;'$rs1 | bc)
			rs1=$(echo '000000'$rs1) 
			
			finish=${#rs1}

			rs1=$(echo ${rs1:$start -5:5})
			 

			rs2=$(echo $line | cut -d'x' -f 3)
			rs2=$(echo $rs2 | cut -d')' -f 1)
			# rs2=$(echo x$rs2)
			rs2=$(echo 'obase=2;'$rs2 | bc)

			rs2=$(echo '000000'$rs2) 

			finish=${#rs2}

			rs2=$(echo ${rs2:$start -5:5})

			
			# imm=$(echo $line | cut -d',' -f 2)
			# imm=$(echo $imm | cut -d'(' -f 1)
			# imm=$(echo 'obase=2;'$imm | bc)			

			result=$(echo '0'$rs2'010'$rs1'0000011')	
			echo "instruction_memory["$i"] = 32'b"$result "//" $line >> $2
		elif [[ $line == "sw"* ]]; then # sw x2,0(x3) // w
			

			rs1=$(echo $line | cut -d'x' -f 2)
			rs1=$(echo $rs1 | cut -d',' -f 1)
			# rs1=$(echo x$rs1)
			rs1=$(echo 'obase=2;'$rs1 | bc)
			rs1=$(echo '000000'$rs1) 
			
			finish=${#rs1}

			rs1=$(echo ${rs1:$start -5:5})

			rs2=$(echo $line | cut -d'x' -f 3)
			rs2=$(echo $rs2 | cut -d')' -f 1)
			# rs2=$(echo x$rs2)
			rs2=$(echo 'obase=2;'$rs2 | bc)
			rs2=$(echo '000000'$rs2) 

			finish=${#rs2}

			rs2=$(echo ${rs2:$start -5:5})

			# imm=$(echo $line | cut -d',' -f 2)
			# imm=$(echo $imm | cut -d'(' -f 1)
			# imm=$(echo 'obase=2;'${imm:0:4} | bc)			
			
			# echo $imm "*" 

			# imm2=$(echo $line | cut -d',' -f 2)
			# imm2=$(echo $imm2 | cut -d'(' -f 1)
			# imm2=$(echo 'obase=2;'${imm2:5:31} | bc)			
			
			# echo $imm2

			result=$(echo '0'$rs1$rs2'010000000100011')	
			echo "instruction_memory["$i"] = 32'b"$result "//" $line >> $2
		else
			result=$(./getbin.exe $line)	 
			echo "instruction_memory["$i"] = 32'b"$result "//" $line >> $2
		fi

		if [[ $line == "addi"* ]]; then
			j=4;
		else
			j=1;
		fi	
		let i=i+j

	elif [[ $line == "//EOF" ]]; then
		break;
	fi
	
done < $1

