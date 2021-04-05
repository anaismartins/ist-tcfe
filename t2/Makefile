# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

NUMBER = 96506

all: python
	make -C mat
	make -C sim
	make -C doc
	cp doc/report-2.pdf ../

python:
	echo "$(NUMBER)" | python t2_datagen.py > data.txt

clean:
	make -C mat clean
	make -C sim clean
	make -C doc clean
	@rm -f data.txt

.PHONY: all clean python