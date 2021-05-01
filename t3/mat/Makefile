all: t3.log convert

t3.log: t3.m
	octave $< > $@

convert:
	ls *eps | xargs -n1 epstopdf

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex *.cir *.pdf

.PHONY: clean all