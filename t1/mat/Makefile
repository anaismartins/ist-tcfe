all: oct-kvl.log oct-kcl.log

oct-kvl.log: kvl.m
	octave $< > $@

oct-kcl.log: kcl.m
	octave $< > $@

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex

.PHONY: clean all
