#-----------------------------------------------------
ASCIIDOCTOR=asciidoctor
EXT=adoc
OUTPUT=.
DESSINS=images/dessins
#-----------------------------------------------------

$(OUTPUT)/%.html: %.$(EXT)
	@echo '==> Compiling asciidoc files to generate HTML'
	$(ASCIIDOCTOR) -r asciidoctor-diagram -a linkcss -o $@ $<

$(OUTPUT)/%.final.html: %.$(EXT)
		@echo '==> Compiling asciidoc files to generate final HTML'
		$(ASCIIDOCTOR) -a linkcss -a final -o $@ $<

$(OUTPUT)/%.pdf: %.$(EXT) $(DEP)
	$(ASCIIDOCTOR) -a final \
		-b pdf \
		-r asciidoctor-pdf \
		-o $@ $<

plant: $(DESSINS)/*.png

$(DESSINS)/%.png: $(DESSINS)/%.plantuml
	@echo '==> Compiling plantUML files to generate PNG'
	java -jar ../plantuml.jar $<
