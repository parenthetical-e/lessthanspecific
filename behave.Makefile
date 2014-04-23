SHELL:=/bin/bash
BINPATH=~/Code/modelmodel/bin

# -----------------
# Save some behave data
# -----------------
behave: behave50 behave50Hrf 

# No HRF
behave50: data/behave50_l.csv data/behave50_r.csv
	
data/behave50_l.csv:
	python $(BINPATH)/behave.py \
	data/behave50_l.csv \
	50 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \

data/behave50_r.csv:
	python $(BINPATH)/behave.py \
	data/behave50_r.csv \
	50 \
	--behave random \
	--n_cond 1 \
	--n_trials 60 \

# HRF
behave50Hrf: data/behave50_l_hrf.csv data/behave50_r_hrf.csv
	
data/behave50_l_hrf.csv:
	python $(BINPATH)/behave.py \
	data/behave50_l_hrf.csv \
	50 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--convolve True

data/behave50_r_hrf.csv:
	python $(BINPATH)/behave.py \
	data/behave50_r_hrf.csv \
	50 \
	--behave random \
	--n_cond 1 \
	--n_trials 60 \
	--convolve True
