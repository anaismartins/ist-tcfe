f = open("./sim/out_tab.tex", "r")
f2 = open("./sim/rip_tab.tex", "r")

lines = f.readlines()
lines2 = f2.readlines()

""" Cenvelopestring = lines[1].split(" & ")
Renvelopestring = lines[2].split(" & ")
Rregulatorstring = lines[3].split(" & ") """
avgstring = lines[0].split(" & ")
maxstring = lines2[0].split(" & ")
minstring = lines2[1].split(" & ")

""" Cenvelopes = Cenvelopestring[1].split("\\\\")
Renvelopes = Renvelopestring[2].split("\\\\")
Rregulators = Rregulatorstring[3].split("\\\\") """
avgs = avgstring[1].split("\\\\")
maxs = maxstring[1].split("\\\\")
mins = minstring[1].split("\\\\")

""" Cenvelope = float(Cenvelopes[0])
Renvelope = float(Renvelope[0])
Rregulator = float(Rregulators[0]) """
avg = float(avgs[0])
max = float(maxs[0])
min = float(mins[0])

Cenvelope = 485 #placeholder
Renvelope = 700 #placeholder
Rregulator = 300 #placeholder

ripple = max - min
merit = 1/((Cenvelope+Renvelope+Rregulator+2)*(ripple + abs(12 - avg) + 10e-6))

ripplef = open("./sim/ripple.tex", "w")

ripplef.write("ripple & " + str(ripple) + "\\\\ \\hline\n")


meritf = open("./sim/merit.tex", "w")

meritf.write("merit & " + str(merit) + "\\\\ \\hline")

f.close()
f2.close()
ripplef.close()
meritf.close()