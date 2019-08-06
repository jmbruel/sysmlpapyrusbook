#-----------------------------------------------------
ASCIIDOCTOR=asciidoctor
ASCIIDOCTORPDF=asciidoctor-pdf
EXT=adoc
OUTPUT=.
DESSINS=images/dessins
DEP=definitions.txt chapters/*.adoc
#-----------------------------------------------------

$(OUTPUT)/%.html: %.$(EXT) $(DEP)
	@echo '==> Compiling asciidoc files to generate HTML'
	$(ASCIIDOCTOR) -a linkcss -o $@ $<

$(OUTPUT)/%.final.html: %.$(EXT)
		@echo '==> Compiling asciidoc files to generate final HTML'
		$(ASCIIDOCTOR) -a linkcss -a data-uri -a final -o $@ $<

$(OUTPUT)/%.pdf: %.$(EXT) $(DEP)
	$(ASCIIDOCTORPDF) \
		-o $@ $<

plant: $(DESSINS)/*.png

$(DESSINS)/%.png: $(DESSINS)/%.plantuml
	@echo '==> Compiling plantUML files to generate PNG'
	java -jar ../plantuml.jar $<

$(DESSINS)/%.svg: $(DESSINS)/%.plantuml
	@echo '==> Compiling plantUML files to generate SVG'
	java -jar ../plantuml.jar -tsvg $<
