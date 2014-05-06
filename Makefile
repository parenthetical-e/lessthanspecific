# ----------------------------------------------------------------------------
# FIT sims
# 1000 iterations	
remove_rwfit:
	$(MAKE) -f rw.Makefile remove_rwfitBoth
	$(MAKE) -f stats.rwfit.Makefile remove
	
rwfit:
	$(MAKE) -f rw.Makefile rwfitBoth
	$(MAKE) -f stats.rwfit.Makefile all

# ----------------------------------------------------------------------------
# SET sims
# 1000 iterations	
remove_rwset:
	$(MAKE) -f rw.Makefile remove_rwsetBoth
	$(MAKE) -f stats.rwset.Makefile remove

rwset:
	$(MAKE) -f rw.Makefile rwsetBoth
	$(MAKE) -f stats.rwset.Makefile all

# ----------------------------------------------------------------------------
# MISC
# Save behave and RL data
remove_behave:
	$(MAKE) -f behave.Makefile remove

behave:
	$(MAKE) -f behave.Makefile all


remove_reinforce:
	$(MAKE) -f reinforce.Makefile remove
	
reinforce:
	$(MAKE) -f reinforce.Makefile all