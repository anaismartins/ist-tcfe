all: nodes-t2.log	
	
nodes-t2.log: nodes-t2.m
	octave $< > $@

clean:
	@rm -f *.log octave-workspace *.eps *~ *.tex

.PHONY: clean all
