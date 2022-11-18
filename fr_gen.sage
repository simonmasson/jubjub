# r_jubjub = 0x0e7db4ea6533afa906673b0101343b00a6682093ccc81082d0970e5ed6f72cb7
r_bandersnatch = 0x1cfb69d4ca675f520cce760202687600ff8f87007419047174fd06b52876e7e1

def in_base(r, n):
    # return r in base 2^n
    s = ZZ(r) 
    l = []
    while s>0 :
        l.append(s%(1<<n))
        s = s >> n
    return l
    
def print_base(r,n,in_hex=0):
    print('[')
    for x in in_base(r,n):
        if in_hex:
            print("\t{},".format(hex(x)))
        else: # decimal
            print("\t{},".format(x))
    print(']')


    
def print_params(r):
    print("PARAMS")
    print("r in base 64")
    print_base(r, 64)
    print("r in base 32")
    print_base(r,32)
    print("r size")
    print(r.nbits())
    
    Fr = GF(r)
    
    R = Fr(1<<256)
    print("R in base 64")
    print_base(R,64, 1)
    g = Fr.multiplicative_generator()
    assert not(g.is_square())
    print("generator in base 64")
    print_base(g*R, 64,1)

    s = valuation(r-1, 2)
    t = (r-1)//(2**s)
    print("s={}".format(s))
    
    print("Root of unity")
    print_base(g**t*R, 64, 1)
    assert (g**t)**(2**s) == 1

    print("INV")
    print(hex(Zmod(1<<64)(-1/r_jubjub)))

    print("R")
    print_base(R, 64,1)
    print("R2")
    print(hex(R**2))
    print_base(R**2, 64,1)
    print("R3")
    print_base(R**3, 64,1)

    print('\n\n')


# print_params(r_jubjub)
print_params(r_bandersnatch)
