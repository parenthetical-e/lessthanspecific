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
# 500 iter run, set
# --------------------
rwsetBothShort: data/rwset500_l.hdf5 data/rwset500_r.hdf5	

data/rwset500_l.hdf5: moremodels.ini
	python rwset.py data/rwset500_l.hdf5 \
		500 \
		--n_trials 60 \
		--behave learn \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models moremodels.ini 

data/rwset500_r.hdf5: moremodels.ini
	python rwset.py data/rwset500_r.hdf5 \
		500 \
		--n_trials 60 \
		--behave random \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models moremodels.ini 


# --------------------
# 2500 iter run, fit
# --------------------
rwfitBoth: data/rwfit2500_l.hdf5 data/rwfit2500_r.hdf5	

data/rwfit2500_l.hdf5: moremodels.ini
	python rwfit.py data/rwfit2500_l.hdf5 \
		2500 \
		--n_trials 60 \
		--behave learn \
		--models moremodels.ini 

data/rwfit2500_r.hdf5: moremodels.ini
	python rwfit.py data/rwfit2500_r.hdf5 \
		2500 \
		--n_trials 60 \
		--behave random \
		--models moremodels.ini 

		
# --------------------
# 2500 iter run, set
# --------------------
test_set: data/rwset50_l.hdf5
	
data/rwset50_l.hdf5: setmodels.ini
	python rwset.py data/rwset50_l.hdf5 \
		50 \
		--n_trials 60 \
		--behave learn \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 


rwsetBoth: data/rwset2500_l.hdf5 data/rwset2500_r.hdf5	

data/rwset2500_l.hdf5: setmodels.ini
	python rwset.py data/rwset2500_l.hdf5 \
		2500 \
		--n_trials 60 \
		--behave learn \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 

data/rwset2500_r.hdf5: setmodels.ini
	python rwset.py data/rwset2500_r.hdf5 \
		2500 \
		--n_trials 60 \
		--behave random \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 

rwsetBothShort: data/rwset500_l.hdf5

data/rwset500_l.hdf5: setmodels.ini
	python rwset.py data/rwset500_l.hdf5 \
		500 \
		--n_trials 60 \
		--behave learn \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels.ini 

# data/rwset500_r.hdf5: setmodels.ini
# 	python rwset.py data/rwset500_r.hdf5 \
# 		500 \
# 		--n_trials 60 \
# 		--behave random \
# 		--alpha 0.1 0.3 0.5 0.7 0.9 \
# 		--models setmodels.ini 
