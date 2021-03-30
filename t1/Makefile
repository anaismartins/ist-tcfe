# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all:
	make -C mat
	make -C sim
	make -C errors
	make -C doc
	cp doc/report-1.pdf ../



clean:
	make -C mat clean
	make -C sim clean
	make -C errors clean
	make -C doc clean
	@rm -f ../*.pdf 

.PHONY: all clean run