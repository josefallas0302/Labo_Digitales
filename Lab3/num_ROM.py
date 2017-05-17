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
                [left, right] = line.split(":")
                print "left:" + "'" + left.strip() + "'"
                print left.strip().isdigit()
                print "right:" + right
                        
                if left.strip().isdigit():
                    writeline = str(i)+":"+right
                    print "writeline: " + writeline
                    i+=1

        outfile.write(writeline)

    infile.close()
    outfile.close()

if __name__ == "__main__":
    main(sys.argv)
