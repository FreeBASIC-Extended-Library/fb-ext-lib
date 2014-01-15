include ../common.mki

DOC_PROJDIR := .

DOC_INDIRS := ../$(INCLUDE_DIR) # ... additional input dirs ...

DOC_FORMAT := FramedHTML
DOC_OUTDIR := $(DOC_PROJDIR)/$(DOC_FORMAT)

ND := `which naturaldocs`

all :
	$(MD) $(DOC_OUTDIR)
	$(ND) -p $(DOC_PROJDIR) $(addprefix -i ,$(DOC_INDIRS)) -s fbext -o $(DOC_FORMAT) $(DOC_OUTDIR)

clean :
	-$(RM) -rf $(DOC_OUTDIR)/*.*
	-$(RM) -rf $(DOC_PROJDIR)/Data

.PHONY: install
install : all
	@echo installing documentation files..
	@$(MD) -p $(DOC_INSTALL_DIR)
	@$(CP) $(DOC_OUTDIR) $(DOC_INSTALL_DIR)
