all: t2-1.log t2-2.log t2-3.log t2-4.log
	
t2-1.log: t2-1.m
	octave $< > $@

t2-2.log: t2-2.m
	octave $< > $@

t2-3.log: t2-3.m
	octave $< > $@

t2-4.log: t2-4.m
	octave $< > $@

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex *.cir

.PHONY: clean all