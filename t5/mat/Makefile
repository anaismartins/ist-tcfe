all: t5.log

t5.log: t5.m
	octave $< > $@

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex *.cir *.pdf

.PHONY: clean all