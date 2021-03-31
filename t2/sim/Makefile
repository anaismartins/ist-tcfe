all: ngspice-1.log ngspice-2.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)

ngspice-1.log: ../sim/t2-1.net
	ngspice -b $< -o $@

ngspice-2.log: ../sim/t2-2.net
	ngspice -b $< -o $@

clean:
	@rm -f ngspice.log *.tex *.pdf *.ps *~

.PHONY: all clean
