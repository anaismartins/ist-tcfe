all: t2-1.log t2-2.log t2-3.log t2-4.log t2-5.log t2-6.log convert

t2-1.log: t2-1.m
	octave $< > $@

t2-2.log: t2-2.m
	octave $< > $@

t2-3.log: t2-3.m
	octave $< > $@

t2-4.log: t2-4.m
	octave $< > $@

t2-5.log: t2-5.m
	octave $< > $@

t2-6.log: t2-6.m
	octave $< > $@


convert:
	ls *eps | xargs -n1 epstopdf

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex *.cir *.pdf

.PHONY: clean all