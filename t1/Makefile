# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all: #errors.o errors.exe run
	make -C mat
	make -C sim
	make -C doc
	cp doc/report-1.pdf ../
	errors.o
	errors.exe
	run

run: errors.exe
	./errors.exe

errors.exe: errors.o
	gcc $< -o $@

errors.o: errors.c
	gcc -c $< -o $@

clean:
	make -C mat clean
	make -C sim clean
	make -C doc clean
	@rm -f *.o *.tex *.exe

.PHONY: all clean run