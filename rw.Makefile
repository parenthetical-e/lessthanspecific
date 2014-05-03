SHELL:=/bin/bash

# -----------------
# A quick fast test
# -----------------
data/rwfit10.hdf5: models.ini
	python rwfit.py data/rwfit10.hdf5 \
		10 \
		--n_trials 60 \
		--behave learn \
		--models models.ini 


# --------------------------------
# Save all behave data (for debug)
# --------------------------------
rwfitBeh: data/rwfit50_l_beh.hdf5 data/rwfit50_r_beh.hdf5
	
data/rwfit50_l_beh.hdf5: models.ini
	python rwfit.py data/rwfit50_l_beh.hdf5 \
		50 \
		--n_trials 60 \
		--behave learn \
		--models models.ini \
		--save_behave True

data/rwfit50_r_beh.hdf5: models.ini
	python rwfit.py data/rwfit50_r_beh.hdf5 \
		50 \
		--n_trials 60 \
		--behave random \
		--models models.ini \
		--save_behave True


# --------------------
# 500 iter run, fit
# --------------------
remove_rwfitBothShort: 
	-rm data/rwfit500_l.hdf5
	-rm data/rwfit500_r.hdf5	

rwfitBothShort: data/rwfit500_l.hdf5 data/rwfit500_r.hdf5	

data/rwfit500_l.hdf5: moremodels.ini
	python rwfit.py data/rwfit500_l.hdf5 \
		500 \
		--n_trials 60 \
		--behave learn \
		--models moremodels.ini 

data/rwfit500_r.hdf5: moremodels.ini
	python rwfit.py data/rwfit500_r.hdf5 \
		500 \
		--n_trials 60 \
		--behave random \
		--models moremodels.ini 

# --------------------
# 1000 iter run, fit
# --------------------
remove_rwfitBoth: 
	-rm data/rwfit1000_l.hdf5
	-rm data/rwfit1000_r.hdf5	

rwfitBoth: data/rwfit1000_l.hdf5 data/rwfit1000_r.hdf5	

data/rwfit1000_l.hdf5: moremodels.ini
	python rwfit.py data/rwfit1000_l.hdf5 \
		1000 \
		--n_trials 60 \
		--behave learn \
		--models moremodels.ini 

data/rwfit1000_r.hdf5: moremodels.ini
	python rwfit.py data/rwfit1000_r.hdf5 \
		1000 \
		--n_trials 60 \
		--behave random \
		--models moremodels.ini 


		
# ---
# SET
# ---
remove_test:
	-rm data/rwset50_l.hdf5

test_set: data/rwset50_l.hdf5
	
data/rwset50_l.hdf5: setmodels.ini
	python rwset.py data/rwset50_l.hdf5 \
		50 \
		--n_trials 60 \
		--behave learn \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 

# --------------------
# 500 iter run, set
# --------------------
remove_rwsetBothShort:
	-rm data/rwset500_l.hdf5 
	-rm data/rwset500_r.hdf5

rwsetBothShort: data/rwset500_l.hdf5 data/rwset500_r.hdf5	

data/rwset500_l.hdf5: setmodels.ini
	python rwset.py data/rwset500_l.hdf5 \
		500 \
		--n_trials 60 \
		--behave learn \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 

data/rwset500_r.hdf5: setmodels.ini
	python rwset.py data/rwset500_r.hdf5 \
		500 \
		--n_trials 60 \
		--behave random \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 

remove_rwsetBoth:
	-rm data/rwset1000_l.hdf5 
	-rm data/rwset1000_r.hdf5

rwsetBoth: data/rwset1000_l.hdf5 data/rwset1000_r.hdf5	

data/rwset1000_l.hdf5: setmodels.ini
	python rwset.py data/rwset1000_l.hdf5 \
		1000 \
		--n_trials 60 \
		--behave learn \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 

data/rwset1000_r.hdf5: setmodels.ini
	python rwset.py data/rwset1000_r.hdf5 \
		1000 \
		--n_trials 60 \
		--behave random \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 

