# Usage.
# To (re)run all experiments and analyses use `make all`
# To remake all the plots just use `make analysis`.  Though if you are playing 
# with analysis it may be easier to open analysis/fig.Rmd in Rstudio 
# (https://www.rstudio.com) and go from there


all: preflight remove rwfit rwset behave reinforce analysis

remove: remove_rwfit remove_rwset remove_behave remove_reinforce

preflight:
	-mkdir data
	-mkdir stats
	-mkdir analysis/figs
	
# ----------------------------------------------------------------------------
# Confusion experiment
# 1000 iterations	
remove_rwfit:
	$(MAKE) -f rw.Makefile remove_rwfitBoth
	$(MAKE) -f stats.rwfit.Makefile remove
	
rwfit:
	$(MAKE) -f rw.Makefile rwfitBoth
	$(MAKE) -f stats.rwfit.Makefile all

# ----------------------------------------------------------------------------
# Seperatation experiment
# 1000 iterations	
remove_rwset:
	$(MAKE) -f rw.Makefile remove_rwsetBoth
	$(MAKE) -f stats.rwset.Makefile remove

rwset:
	$(MAKE) -f rw.Makefile rwsetBoth
	$(MAKE) -f stats.rwset.Makefile all

# ----------------------------------------------------------------------------
# MISC:
# Create and save behave and RL data
remove_behave:
	$(MAKE) -f behave.Makefile remove

behave:
	$(MAKE) -f behave.Makefile all


remove_reinforce:
	$(MAKE) -f reinforce.Makefile remove
	
reinforce:
	$(MAKE) -f reinforce.Makefile all

analysis:
	Rscript -e "library(knitr); knit('analysis/figs.Rmd')"
