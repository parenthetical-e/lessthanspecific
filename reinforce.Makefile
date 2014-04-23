SHELL:=/bin/bash
BINPATH=~/Code/modelmodel/bin

all: behave_rwfit500 behave_rwfit500Hrf behave_rwset500 behave_rwset500Hrf 
	
	
# Fit
behave_rwfit: behave_rwfit500 behave_rwfit500Hrf
	
behave_rwfit500: data/behave_rwfit500_l.csv data/behave_rwfit500_r.csv
	
data/behave_rwfit500_l.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwfit500_l.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \

data/behave_rwfit500_r.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwfit500_r.csv \
	500 \
	--behave random \
	--n_cond 1 \
	--n_trials 60 \

## w HRF
behave_rwfit500Hrf: data/behave_rwfit500_l_hrf.csv data/behave_rwfit500_r_hrf.csv
	
data/behave_rwfit500_l_hrf.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwfit500_l_hrf.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--convolve True

data/behave_rwfit500_r_hrf.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwfit500_r_hrf.csv \
	500 \
	--behave random \
	--n_cond 1 \
	--n_trials 60 \
	--convolve True


# Set
behave_rwset: behave_rwset500 behave_rwset500Hrf
	
behave_rwset500: data/behave_rwset500_l_01.csv data/behave_rwset500_l_03.csv data/behave_rwset500_l_05.csv data/behave_rwset500_l_07.csv data/behave_rwset500_l_09.csv
	
data/behave_rwset500_l_01.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_01.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.1 \

data/behave_rwset500_l_03.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_03.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.3 \

data/behave_rwset500_l_05.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_05.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.5 \

data/behave_rwset500_l_07.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_07.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.7 \

data/behave_rwset500_l_09.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_09.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.9 \

# HRF
behave_rwset500Hrf: data/behave_rwset500_l_01_hrf.csv data/behave_rwset500_l_03_hrf.csv data/behave_rwset500_l_05_hrf.csv data/behave_rwset500_l_07_hrf.csv data/behave_rwset500_l_09_hrf.csv
	
data/behave_rwset500_l_01_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_01_hrf.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.1 \

data/behave_rwset500_l_03_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_03_hrf.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.3 \

data/behave_rwset500_l_05_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_05_hrf.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.5 \

data/behave_rwset500_l_07_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_07_hrf.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.7 \

data/behave_rwset500_l_09_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset500_l_09_hrf.csv \
	500 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.9 \
