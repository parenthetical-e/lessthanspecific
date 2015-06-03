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

data/bbeh10.hdf5: bbehmodels.ini
	python bbeh.py data/bbeh10.hdf5 \
		10 \
		--n_trials 60 \
		--models bbehmodels.ini 

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

# Multivariate models
multi : data/rwfit1000_l_multi_acc.hdf5 data/rwfit1000_r_multi_acc.hdf5 data/rwfit1000_r_multi_box_acc.hdf5 data/rwfit1000_l_multi_box_acc.hdf5


data/rwfit1000_l_multi_acc.hdf5: multivar_acc.ini
	python rwfit.py data/rwfit1000_l_multi_acc.hdf5 \
		1000 \
		--n_trials 60 \
		--behave learn \
		--models multivar_acc.ini \
		--orth acc

data/rwfit1000_r_multi_acc.hdf5: multivar_acc.ini
	python rwfit.py data/rwfit1000_r_multi_acc.hdf5 \
		1000 \
		--n_trials 60 \
		--behave random \
		--models multivar_acc.ini \
		-- orth acc

data/rwfit1000_l_multi_box_acc.hdf5: multivar_box_acc.ini
	python rwfit.py data/rwfit1000_l_multi_box_acc.hdf5 \
		1000 \
		--n_trials 60 \
		--behave learn \
		--models multivar_box_acc.ini \
		--orth box acc

data/rwfit1000_r_multi_box_acc.hdf5: multivar_box_acc.ini
	python rwfit.py data/rwfit1000_r_multi_box_acc.hdf5 \
		1000 \
		--n_trials 60 \
		--behave random \
		--models multivar_box_acc.ini \
		-- orth box acc

# ISI test between values and RPE
data/rwfit1000_l_isi.hdf5: isi.ini
	python rwfit.py data/rwfit1000_l_isi.hdf5 \
		1000 \
		--n_trials 60 \
		--behave learn \
		--models isi.ini \
		--isi value rpe

data/rwfit1000_r_isi.hdf5: isi.ini
	python rwfit.py data/rwfit1000_r_isi.hdf5 \
		1000 \
		--n_trials 60 \
		--behave random \
		--models moremodels.ini \
		--isi value rpe

# ---
# Between Beh modes
# ---
data/bbeh100.hdf5: bbehmodels.ini
	python bbeh.py data/bbeh100.hdf5 \
		100 \
		--n_trials 60 \
		--models bbehmodels.ini 

data/bbeh1000.hdf5: bbehmodels.ini
	python bbeh.py data/bbeh1000.hdf5 \
		1000 \
		--n_trials 60 \
		--models bbehmodels.ini 

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

data/rwset1000_ro.hdf5: setmodels_o.ini
	python rwset.py data/rwset1000_ro.hdf5 \
		1000 \
		--n_trials 60 \
		--behave random \
		--alpha 0.1 0.3 0.5 0.7 0.9 \
		--models setmodels_o.ini 

