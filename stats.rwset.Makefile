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
remove_extract: remove_rwset1000_l remove_rwset1000_r
	
extract: stats/rwset1000_l*.csv stats/rwset1000_r*.csv
	
# set
# learn
remove_rwset1000_l:
	-rm stats/rwset1000_l_fvalue.csv
	-rm stats/rwset1000_l_pvalue.csv
	-rm stats/rwset1000_l_omni_fvalue.csv
	-rm stats/rwset1000_l_params_tvalue.csv
	-rm stats/rwset1000_l_params_pvalue.csv
	-rm stats/rwset1000_l_aic.csv

stats/rwset1000_l*.csv: data/rwset1000_l.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwset1000_l.hdf5 \
		--names \
		 stats/rwset1000_l_fvalue.csv \
		 stats/rwset1000_l_pvalue.csv \
		 stats/rwset1000_l_omni_fvalue.csv \
		 stats/rwset1000_l_params_tvalue.csv \
		 stats/rwset1000_l_params_pvalue.csv \
		 stats/rwset1000_l_aic.csv \
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
remove_rwset1000_r:
	-rm stats/rwset1000_r_fvalue.csv 
	-rm stats/rwset1000_r_pvalue.csv 
	-rm stats/rwset1000_r_omni_fvalue.csv 
	-rm stats/rwset1000_r_params_tvalue.csv 
	-rm stats/rwset1000_r_params_pvalue.csv 
	-rm stats/rwset1000_r_aic.csv 
		
stats/rwset1000_r*.csv: data/rwset1000_r.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwset1000_r.hdf5 \
		--names \
		 stats/rwset1000_r_fvalue.csv \
		 stats/rwset1000_r_pvalue.csv \
		 stats/rwset1000_r_omni_fvalue.csv \
		 stats/rwset1000_r_params_tvalue.csv \
		 stats/rwset1000_r_params_pvalue.csv \
		 stats/rwset1000_r_aic.csv \
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


remove_rowset1000_ro:
	-rm stats/rwset1000_ro_fvalue.csv 
	-rm stats/rwset1000_ro_pvalue.csv 
	-rm stats/rwset1000_ro_omni_fvalue.csv 
	-rm stats/rwset1000_ro_params_tvalue.csv 
	-rm stats/rwset1000_ro_params_pvalue.csv 
	-rm stats/rwset1000_ro_aic.csv 
		
stats/rwset1000_ro*.csv: data/rwset1000_ro.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwset1000_ro.hdf5 \
		--names \
		 stats/rwset1000_ro_fvalue.csv \
		 stats/rwset1000_ro_pvalue.csv \
		 stats/rwset1000_ro_omni_fvalue.csv \
		 stats/rwset1000_ro_params_tvalue.csv \
		 stats/rwset1000_ro_params_pvalue.csv \
		 stats/rwset1000_ro_aic.csv \
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

# ---------
#  Get beta
#  --------
stats/rwset1000_ro_params_tvalue_parambeta.csv: stats/rwset1000_ro_params_tvalue.csv stats/rwset1000_ro_params_pvalue.csv
	python $(BINPATH)/getbeta.py \
		stats/rwset1000_ro_params_tvalue_parambeta.csv \
		stats/rwset1000_ro_params_tvalue.csv \
		stats/rwset1000_ro_params_pvalue.csv \
		--col -1 \
		--drop 0

# -----------
# conjunction
# -----------
remove_conjuction: 
	-rm stats/rwset1000_l_params_tvalue_conj.csv
	-rm stats/rwset1000_r_params_tvalue_conj.csv
	
conjunction: stats/rwset1000_l_params_tvalue_conj.csv stats/rwset1000_r_params_tvalue_conj.csv
	
	
stats/rwset1000_l_params_tvalue_conj.csv: stats/rwset1000_l_params_tvalue.csv stats/rwset1000_l_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		stats/rwset1000_l_params_tvalue_conj.csv \
		stats/rwset1000_l_params_tvalue.csv \
		stats/rwset1000_l_params_pvalue.csv \
		--drop 0

stats/rwset1000_r_params_tvalue_conj.csv: stats/rwset1000_r_params_tvalue.csv stats/rwset1000_r_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		stats/rwset1000_r_params_tvalue_conj.csv \
		stats/rwset1000_r_params_tvalue.csv \
		stats/rwset1000_r_params_pvalue.csv \
		--drop 0



# Quick test
stats/rwset10_*.csv: data/rwset10.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwset10.hdf5 \
		--names stats/rwset10_fvalue.csv stats/rwset10_pvalue.csv \
		--paths /*/*/tests/fvalue /*/*/tests/pvalue \
		--dims 0 0
