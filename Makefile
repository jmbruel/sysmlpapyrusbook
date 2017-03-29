#-----------------------------------------------------
ASCIIDOCTOR=asciidoctor
EXT=adoc
OUTPUT=.
#-----------------------------------------------------

$(OUTPUT)/%.html: %.$(EXT)
	@echo '==> Compiling asciidoc files to generate HTML'
	$(ASCIIDOCTOR) -a linkcss -o $@ $<

$(OUTPUT)/%.final.html: %.$(EXT)
		@echo '==> Compiling asciidoc files to generate final HTML'
		$(ASCIIDOCTOR) -a linkcss -a final -o $@ $<

$(OUTPUT)/%.pdf: %.$(EXT) $(DEP)
	$(ASCIIDOCTOR) -a final \
		-b pdf \
		-r asciidoctor-pdf \
		-o $@ $<
