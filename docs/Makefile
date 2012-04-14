include ../common.mki

PERL = perl

DOC_PROJDIR := .

DOC_INDIRS := ../$(INCLUDE_DIR) # ... additional input dirs ...

DOC_FORMAT := FramedHTML
DOC_OUTDIR := $(DOC_PROJDIR)/$(DOC_FORMAT)

all :
	$(PERL) $(NATURALDOCS_DIR)/NaturalDocs -p $(DOC_PROJDIR) $(addprefix -i ,$(DOC_INDIRS)) -s fbext -o $(DOC_FORMAT) $(DOC_OUTDIR)

clean :
	-$(RM) -rf $(DOC_OUTDIR)/*.*
