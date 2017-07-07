import sys

def main(argv):
	infile = open(argv[1], 'r')
	outfile = open(argv[2], 'w')
	comment = False
    

	for line in infile:


		if "," in line:		 	
			pixel_string = line.split(",")

								
		for i in range(len(pixel_string)-1):
		
			if(int(pixel_string[i],16) < 128):
				pixel_string[i] = '1'
			else :
				pixel_string[i] = '0'
	
		writeline = ",".join(pixel_string)
				
		outfile.write(writeline)

	infile.close()
	outfile.close()

if __name__ == "__main__":
	main(sys.argv)
