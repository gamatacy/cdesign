bcds = []
bins = []

with open("bcd.txt","r") as f:
    lines = f.readlines()
    for l in lines:
        bcds.append(list(map(int, l.split())))

with open("bin.txt","r") as f:
    lines = f.readlines()
    for l in lines:
        bins.append(list(map(int, l.split())))


basis = {
    0 : "",
    1 : "",
    2 : "",
    3 : "",
    4 : "",
    5 : "",
    6 : ""
}

mapin = {
    0 : "z",
    1 : "x",
    2 : "c",
    3 : "f",
    4 : "b",
    5 : "n",
    6 : "m",
    7 : "k",
}

for i in range(7):
    
    for idxdx, b in enumerate(bins):
        terms = ""
        term = ""
        if b[6-i] == 1:
            
            bcd = bcds[idxdx]
            term = "("
            for idx, j in enumerate(bcd):
                if j == 1:
                    if term == "(":
                        term +=  mapin[idx]
                    else:
                        term +=  " and " + mapin[idx]
                else:
                    if term == "(":
                        term +=  " not " + mapin[idx]
                    else:
                        term +=  " and not " + mapin[idx]
            term += ")"
        
        if term != "(":
            if terms == "": 
                terms += term 
            else: 
                terms += " or " + term

        if basis[i] == "": 
            basis[i] = terms
        elif term != "":
            basis[i] += " or " + terms

for i in range(7):
    print(f"x{i}: {basis[i]}")
    print()