all: t3.log

t3.log: t3.m
	octave $< > $@

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex *.cir *.pdf

.PHONY: clean all