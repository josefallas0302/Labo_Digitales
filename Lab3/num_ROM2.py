import sys

def main(argv):
    infile = open(argv[1], 'r')
    outfile = open(argv[2], 'w')
    comment = False
    
    i = 0
    for line in infile:
        writeline = line

        if "/*" in line and not comment:
            comment = True
        if "*/" in line and comment:
            comment = False

        if not comment:
            if ":" in line:
                split_list = line.split(":")
                left = split_list[0]
                right = split_list[1]
                
                if left.strip().isdigit():
                    instruction = right.split("=")[1]
                    writeline = "assign memoryROM["+str(i)+"] = "+instruction
                    i+=1

        outfile.write(writeline)

    infile.close()
    outfile.close()

if __name__ == "__main__":
    main(sys.argv)
