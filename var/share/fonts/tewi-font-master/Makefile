bdf = tewi-medium-11.bdf tewi-bold-11.bdf tewifw-medium-11.bdf tewifw-bold-11.bdf $(var)
var_m = tewi2a-medium-11.bdf tewihm-medium-11.bdf tewii-medium-11.bdf
var_b = tewi2a-bold-11.bdf tewihm-bold-11.bdf tewii-bold-11.bdf
var = $(var_m) $(var_b)
pcf = $(bdf:%.bdf=out/%.pcf.gz)
cache = out/fonts.dir out/fonts.scale
unicode_version = 9.0.0

all: $(pcf)

var: $(var)

fontdir: $(pcf) $(cache)

out:
	mkdir -p out

$(var_b): tewi-bold-11.bdf
$(var_m): tewi-medium-11.bdf

$(var): %: variant/%
	scripts/mkvar $@

out/%.pcf.gz: %.bdf out
	bdftopcf $< | gzip -9 > $@

out/fonts.scale: $(pcf)
	mkfontscale out

out/fonts.dir: $(pcf) out/fonts.scale
	mkfontdir out
	xset fp rehash
	fc-cache

clean:
	rm -rf out *.bak variant/*.bak $(var)

UnicodeData.txt:
	curl http://www.unicode.org/Public/$(unicode_version)/ucd/UnicodeData.txt > $@

.PHONY: all build clean
