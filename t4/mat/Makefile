all: t4.log

t3.log: t4.m
	octave $< > $@

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex *.cir *.pdf

.PHONY: clean all