all: t2-1.log	t2-2.log
	
t2-1.log: t2-1.m
	octave $< > $@

t2-2.log: t2-2.m
	octave $< > $@

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex

.PHONY: clean all
