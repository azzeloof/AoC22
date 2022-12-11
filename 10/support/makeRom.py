def bits(n, bits):
    # https://stackoverflow.com/questions/12946116/twos-complement-binary-in-python
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

data = []
with open('input.txt', 'r') as fIn:
    data = fIn.read().split('\n')

with open('../gateware/memory.rom', 'w') as fOut:
    fOut.write("00000000000000000\n")
    for line in data:
        if line == "noop":
            fOut.write("00000000000000000\n")
        elif line.startswith("addx"):
            sp = line.split(" ")
            toWrite = "1" + str(bits(int(sp[1]),16))
            fOut.write("00000000000000000\n")
            fOut.write(toWrite + "\n")
    