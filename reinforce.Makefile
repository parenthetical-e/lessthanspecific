SHELL:=/bin/bash
BINPATH=~/Code/modelmodel/bin

all: behave_rwfit100 behave_rwfit100Hrf behave_rwset100Hrf behave_rwset100 
	
	
# Fit
behave_rwfit: behave_rwfit100 behave_rwfit100Hrf
	
behave_rwfit100: data/behave_rwfit100_l.csv data/behave_rwfit100_r.csv
	
data/behave_rwfit100_l.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwfit100_l.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \

data/behave_rwfit100_r.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwfit100_r.csv \
	100 \
	--behave random \
	--n_cond 1 \
	--n_trials 60 \

## w HRF
behave_rwfit100Hrf: data/behave_rwfit100_l_hrf.csv data/behave_rwfit100_r_hrf.csv
	
data/behave_rwfit100_l_hrf.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwfit100_l_hrf.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--convolve True

data/behave_rwfit100_r_hrf.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwfit100_r_hrf.csv \
	100 \
	--behave random \
	--n_cond 1 \
	--n_trials 60 \
	--convolve True


# Set
behave_rwset: behave_rwset100 behave_rwset100Hrf
	
behave_rwset100: data/behave_rwset100_l_01.csv data/behave_rwset100_l_03.csv data/behave_rwset100_l_05.csv data/behave_rwset100_l_07.csv data/behave_rwset100_l_09.csv
	
data/behave_rwset100_l_01.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_01.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.1 \

data/behave_rwset100_l_03.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_03.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.3 \

data/behave_rwset100_l_05.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_05.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.5 \

data/behave_rwset100_l_07.csv:
	python $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_07.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.7 \

data/behave_rwset100_l_09.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_09.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.9 \

# HRF
behave_rwset100Hrf: data/behave_rwset100_l_01_hrf.csv data/behave_rwset100_l_03_hrf.csv data/behave_rwset100_l_05_hrf.csv data/behave_rwset100_l_07_hrf.csv data/behave_rwset100_l_09_hrf.csv
	
data/behave_rwset100_l_01_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_01_hrf.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.1 \

data/behave_rwset100_l_03_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_03_hrf.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.3 \

data/behave_rwset100_l_05_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_05_hrf.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.5 \

data/behave_rwset100_l_07_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_07_hrf.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.7 \

data/behave_rwset100_l_09_hrf.csv:
	python  $(BINPATH)/reinforce.py \
	data/behave_rwset100_l_09_hrf.csv \
	100 \
	--behave learn \
	--n_cond 1 \
	--n_trials 60 \
	--alpha 0.9 \
