SHELL := /bin/bash
BINPATH=~/Code/modelmodel/bin
		
# ---------
# Get stats
# ---------
	
all: extract conjunction

# -------
# EXTRACT
# -------	

# Quick test
stats/bbeh10_*.csv:
	python $(BINPATH)/extract.py \
		--hdf data/bbeh10.hdf5 \
		--names stats/bbeh10_fvalue.csv stats/bbeh10_pvalue.csv \
		--paths /*/*/tests/fvalue /*/*/tests/pvalue \
		--dims 0 0

remove_bbeh100:
	-rm stats/bbeh100_fvalue.csv
	-rm stats/bbeh100_pvalue.csv
	-rm stats/bbeh100_omni_fvalue.csv
	-rm stats/bbeh100_params_tvalue.csv
	-rm stats/bbeh100_params_pvalue.csv
	-rm stats/bbeh100_aic.csv

remove_bbeh1000:
	-rm stats/bbeh1000_fvalue.csv
	-rm stats/bbeh1000_pvalue.csv
	-rm stats/bbeh1000_omni_fvalue.csv
	-rm stats/bbeh1000_params_tvalue.csv
	-rm stats/bbeh1000_params_pvalue.csv
	-rm stats/bbeh1000_aic.csv

extract: stats/bbeh100_*.csv 

stats/bbeh100_*.csv: 
	python $(BINPATH)/extract.py \
		--hdf data/bbeh100.hdf5 \
		--names \
		 stats/bbeh100_fvalue.csv \
		 stats/bbeh100_pvalue.csv \
		 stats/bbeh100_omni_fvalue.csv \
		 stats/bbeh100_params_tvalue.csv \
		 stats/bbeh100_params_pvalue.csv \
		 stats/bbeh100_aic.csv \
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

stats/bbeh1000_*.csv: 
	python $(BINPATH)/extract.py \
		--hdf data/bbeh1000.hdf5 \
		--names \
		 stats/bbeh1000_fvalue.csv \
		 stats/bbeh1000_pvalue.csv \
		 stats/bbeh1000_omni_fvalue.csv \
		 stats/bbeh1000_params_tvalue.csv \
		 stats/bbeh1000_params_pvalue.csv \
		 stats/bbeh1000_aic.csv \
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
	-rm stats/bbeh100_params_tvalue_conj.csv
	-rm stats/bbeh1000_params_tvalue_conj.csv
	
conjunction: stats/bbeh100_params_tvalue_conj.csv 

stats/bbeh100_params_tvalue_conj.csv: stats/bbeh100_params_tvalue.csv stats/bbeh100_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		stats/bbeh100_params_tvalue_conj.csv \
		stats/bbeh100_params_tvalue.csv \
		stats/bbeh100_params_pvalue.csv \
		--drop 0

stats/bbeh1000_params_tvalue_conj.csv: stats/bbeh1000_params_tvalue.csv stats/bbeh1000_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		stats/bbeh1000_params_tvalue_conj.csv \
		stats/bbeh1000_params_tvalue.csv \
		stats/bbeh1000_params_pvalue.csv \
		--drop 0

