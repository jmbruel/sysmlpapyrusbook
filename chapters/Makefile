#-----------------------------------------------------
ASCIIDOCTOR=asciidoctor
EXT=adoc
OUTPUT=.
DESSINS=images/dessins
DECK=swiss

#-----------------------------------------------------

$(OUTPUT)/%.html: %.$(EXT)
	@echo '==> Compiling asciidoc files to generate HTML'
	$(ASCIIDOCTOR) -r asciidoctor-diagram -a linkcss -a data-uri -a imagesdir="../images/" -o $@ $<

$(OUTPUT)/%.final.html: %.$(EXT)
		@echo '==> Compiling asciidoc files to generate final HTML'
		$(ASCIIDOCTOR) -a linkcss -a final -o $@ $<

$(OUTPUT)/%.pdf: %.$(EXT) $(DEP)
	$(ASCIIDOCTOR) -a final \
		-b pdf \
		-r asciidoctor-pdf \
		-o $@ $<

$(OUTPUT)/%.deckjs.html: %.$(EXT) $(DEP)
	@echo '==> Compiling asciidoc files to generate Deckjs'
		$(ASCIIDOCTOR) -T ../../asciidoctor-deck.js/templates/haml/ \
		-a slides \
		-a deckjs_theme=$(DECK) \
    	-a prof -o $@ $<

$(OUTPUT)/%.slides.html: %.$(EXT)  $(DEP)
	@echo '==> Compiling asciidoc files to generate reveal.js'
	$(ASCIIDOCTOR) -T ../../asciidoctor-backends/haml/reveal/ \
        -a slides \
		-a data-uri \
		-a icons=font \
		-a imagesdir=../images \
        -a stylesheet=$(STYLE) -o $@ $<


plant: $(DESSINS)/*.png

$(DESSINS)/%.png: $(DESSINS)/%.plantuml
	@echo '==> Compiling plantUML files to generate PNG'
	java -jar ../plantuml.jar $<

$(DESSINS)/%.svg: $(DESSINS)/%.plantuml
	@echo '==> Compiling plantUML files to generate SVG'
	java -jar ../plantuml.jar -tsvg $<
