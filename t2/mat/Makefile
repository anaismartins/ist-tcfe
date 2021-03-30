all: t2-1.log

t2-1.log: t2-1.m
	octave $< > $@

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex

.PHONY: clean all
