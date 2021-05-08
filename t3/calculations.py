f = open("./sim/op_tab.tex", "r")

lines = f.readlines()

""" Cenvelopestring = lines[1].split(" & ")
Renvelopestring = lines[2].split(" & ")
Rregulatorstring = lines[3].split(" & ") """
avgstring = lines[0].split(" & ")
maxstring = lines[1].split(" & ")
minstring = lines[2].split(" & ")

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

out = open("./doc/values.tex", "w")

out.write("average value & " + str(abs(12-avg)) + "\\\\ \\hline\n")
out.write("ripple & " + str(ripple) + "\\\\ \\hline\n")
out.write("merit & " + str(merit) + "\\\\ \\hline")