SHELL := /bin/bash
BINPATH=~/Code/modelmodel/bin


# Quick test
data/rwfit10_*.csv: data/rwfit10.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwfit10.hdf5 \
		--names data/rwfit10_fvalue.csv data/rwfit10_pvalue.csv \
		--paths /*/*/tests/fvalue /*/*/tests/pvalue \
		--dims 0 0
		
# ---------
# Get stats
# ---------
clean_extract: clean_rwfit500_l clean_rwfit500_r
	
extract: data/rwfit500_l*.csv data/rwfit500_r*.csv
	
# fit
# learn
clean_rwfit500_l:
	-rm data/rwfit500_l_fvalue.csv
	-rm data/rwfit500_l_pvalue.csv
	-rm data/rwfit500_l_omni_fvalue.csv
	-rm data/rwfit500_l_params_tvalue.csv
	-rm data/rwfit500_l_params_pvalue.csv
	-rm data/rwfit500_l_aic.csv

data/rwfit500_l*.csv: data/rwfit500_l.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwfit500_l.hdf5 \
		--names \
		 data/rwfit500_l_fvalue.csv \
		 data/rwfit500_l_pvalue.csv \
		 data/rwfit500_l_omni_fvalue.csv \
		 data/rwfit500_l_params_tvalue.csv \
		 data/rwfit500_l_params_pvalue.csv \
		 data/rwfit500_l_aic.csv \
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
clean_rwfit500_r:
	-rm data/rwfit500_r_fvalue.csv 
	-rm data/rwfit500_r_pvalue.csv 
	-rm data/rwfit500_r_omni_fvalue.csv 
	-rm data/rwfit500_r_params_tvalue.csv 
	-rm data/rwfit500_r_params_pvalue.csv 
	-rm data/rwfit500_r_aic.csv 
		
data/rwfit500_r*.csv: data/rwfit500_r.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwfit500_r.hdf5 \
		--names \
		 data/rwfit500_r_fvalue.csv \
		 data/rwfit500_r_pvalue.csv \
		 data/rwfit500_r_omni_fvalue.csv \
		 data/rwfit500_r_params_tvalue.csv \
		 data/rwfit500_r_params_pvalue.csv \
		 data/rwfit500_r_aic.csv \
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
clean_conjuction: 
	-rm data/rwfit500_l_params_tvalue_conj.csv
	-rm data/rwfit500_r_params_tvalue_conj.csv
	
conjunction: data/rwfit500_l_params_tvalue_conj.csv data/rwfit500_r_params_tvalue_conj.csv
	
	
data/rwfit500_l_params_tvalue_conj.csv: data/rwfit500_l_params_tvalue.csv data/rwfit500_l_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		data/rwfit500_l_params_tvalue_conj.csv \
		data/rwfit500_l_params_tvalue.csv \
		data/rwfit500_l_params_pvalue.csv \
		--drop 0

data/rwfit500_r_params_tvalue_conj.csv: data/rwfit500_r_params_tvalue.csv data/rwfit500_r_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		data/rwfit500_r_params_tvalue_conj.csv \
		data/rwfit500_r_params_tvalue.csv \
		data/rwfit500_r_params_pvalue.csv \
		--drop 0

