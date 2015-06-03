SHELL := /bin/bash
BINPATH=~/Code/modelmodel/bin
		
# ---------
# Get stats
# ---------
remove: remove_extract remove_conjuction
	
all: extract conjunction

# -------
# EXTRACT
# -------	
remove_extract: remove_rwfit1000_l remove_rwfit1000_r
	
extract: stats/rwfit1000_l*.csv stats/rwfit1000_r*.csv
	
# fit
# learn
remove_rwfit1000_l:
	-rm stats/rwfit1000_l_fvalue.csv
	-rm stats/rwfit1000_l_pvalue.csv
	-rm stats/rwfit1000_l_omni_fvalue.csv
	-rm stats/rwfit1000_l_params_tvalue.csv
	-rm stats/rwfit1000_l_params_pvalue.csv
	-rm stats/rwfit1000_l_aic.csv

stats/rwfit1000_l*.csv: data/rwfit1000_l.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwfit1000_l.hdf5 \
		--names \
		 stats/rwfit1000_l_fvalue.csv \
		 stats/rwfit1000_l_pvalue.csv \
		 stats/rwfit1000_l_omni_fvalue.csv \
		 stats/rwfit1000_l_params_tvalue.csv \
		 stats/rwfit1000_l_params_pvalue.csv \
		 stats/rwfit1000_l_aic.csv \
		--paths \
		 /*/*/tests/fvalue \
		 /*/*/tests/pvalue \
		 /*/*/fvalue \
		 /*/*/t \
		 /*/*/p \
		 /*/*/aic \
		--dims \
		 0 \
		 0 \
		 0 \
		 1 \
		 1 \
		 0

# random
remove_rwfit1000_r:
	-rm stats/rwfit1000_r_fvalue.csv 
	-rm stats/rwfit1000_r_pvalue.csv 
	-rm stats/rwfit1000_r_omni_fvalue.csv 
	-rm stats/rwfit1000_r_params_tvalue.csv 
	-rm stats/rwfit1000_r_params_pvalue.csv 
	-rm stats/rwfit1000_r_aic.csv 
		
stats/rwfit1000_r*.csv: data/rwfit1000_r.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwfit1000_r.hdf5 \
		--names \
		 stats/rwfit1000_r_fvalue.csv \
		 stats/rwfit1000_r_pvalue.csv \
		 stats/rwfit1000_r_omni_fvalue.csv \
		 stats/rwfit1000_r_params_tvalue.csv \
		 stats/rwfit1000_r_params_pvalue.csv \
		 stats/rwfit1000_r_aic.csv \
		--paths \
		 /*/*/tests/fvalue \
		 /*/*/tests/pvalue \
		 /*/*/fvalue \
		 /*/*/t \
		 /*/*/p \
		 /*/*/aic \
		--dims \
		 0 \
		 0 \
		 0 \
		 1 \
		 1 \
		 0

# -----------
# conjunction
# -----------
remove_conjuction: 
	-rm stats/rwfit1000_l_params_tvalue_conj.csv
	-rm stats/rwfit1000_r_params_tvalue_conj.csv
	
conjunction: stats/rwfit1000_l_params_tvalue_conj.csv stats/rwfit1000_r_params_tvalue_conj.csv
	
	
stats/rwfit1000_l_params_tvalue_conj.csv: stats/rwfit1000_l_params_tvalue.csv stats/rwfit1000_l_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		stats/rwfit1000_l_params_tvalue_conj.csv \
		stats/rwfit1000_l_params_tvalue.csv \
		stats/rwfit1000_l_params_pvalue.csv \
		--drop 0

stats/rwfit1000_r_params_tvalue_conj.csv: stats/rwfit1000_r_params_tvalue.csv stats/rwfit1000_r_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		stats/rwfit1000_r_params_tvalue_conj.csv \
		stats/rwfit1000_r_params_tvalue.csv \
		stats/rwfit1000_r_params_pvalue.csv \
		--drop 0

# ----------------
# get partial beta
# ----------------
remove_parambeta: 
	-rm stats/rwfit1000_l_params_tvalue_parambeta.csv
	-rm stats/rwfit1000_r_params_tvalue_parambeta.csv
	
parambeta: stats/rwfit1000_l_params_tvalue_parambeta.csv stats/rwfit1000_r_params_tvalue_parambeta.csv
	
	
stats/rwfit1000_l_params_tvalue_parambeta.csv: stats/rwfit1000_l_params_tvalue.csv stats/rwfit1000_l_params_pvalue.csv
	python $(BINPATH)/getbeta.py \
		stats/rwfit1000_l_params_tvalue_parambeta.csv \
		stats/rwfit1000_l_params_tvalue.csv \
		stats/rwfit1000_l_params_pvalue.csv \
		--col -1 \
		--drop 0

stats/rwfit1000_r_params_tvalue_parambeta.csv: stats/rwfit1000_r_params_tvalue.csv stats/rwfit1000_r_params_pvalue.csv
	python $(BINPATH)/getbeta.py \
		stats/rwfit1000_r_params_tvalue_parambeta.csv \
		stats/rwfit1000_r_params_tvalue.csv \
		stats/rwfit1000_r_params_pvalue.csv \
		--col -1 \
		--drop 0


# Quick test
stats/rwfit10_*.csv: data/rwfit10.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwfit10.hdf5 \
		--names stats/rwfit10_fvalue.csv stats/rwfit10_pvalue.csv \
		--paths /*/*/tests/fvalue /*/*/tests/pvalue \
		--dims 0 0
